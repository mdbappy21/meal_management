import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_management/Data/models/member_model.dart';
import 'package:meal_management/Data/models/mess_info_model.dart';
import 'package:meal_management/Presentation/state_holder/members_info_controller.dart';
import 'package:meal_management/Presentation/state_holder/mess_info_controller.dart';
import 'package:meal_management/Presentation/state_holder/pending_request_controller.dart';
import 'package:meal_management/Presentation/ui/screen/add_cost.dart';
import 'package:meal_management/Presentation/ui/screen/add_meal.dart';
import 'package:meal_management/Presentation/ui/screen/auth/sign_in.dart';
import 'package:meal_management/Presentation/ui/screen/pending_request.dart';
import 'package:meal_management/Presentation/ui/screen/send_message.dart';
import 'package:meal_management/Presentation/ui/widgets/app_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.messInfoModel});
  final MessInfoModel? messInfoModel;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey _addFabKey=GlobalKey();
  final MessInfoController messInfoController=Get.find<MessInfoController>();
  final MembersInfoController memberInfoController =Get.find<MembersInfoController>();
  List<MemberModel>memberList=[];

  @override
  void initState() {
    super.initState();
    _onTapGetMembersInfo();
  }

  void _onTapMessage() {
    Get.to(()=>SendMessage());
  }

  Future<void> onTapSignOut() async {
    FirebaseAuth.instance.signOut();
    final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    sharedPreferences.remove('isLoggedIn');
    Get.offAll(SignIn());
  }

  Future<void>_onTapPendingRequest()async{
    PendingRequestController pendingRequestController=Get.find<PendingRequestController>();
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();
    bool isSuccess= await pendingRequestController.pendingRequest(token!);
    if(isSuccess){
      Get.to(()=>PendingRequest(pendingRequest: pendingRequestController.pendingRequests));
    }else{
      // Get.offAll(() => const UserType());
      Get.snackbar('failed', '${pendingRequestController.errorMassage}');
    }
  }
  Future<void>_onTapGetMembersInfo()async{
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();
    bool success = await Get.find<MembersInfoController>().fetchMembers(token!);
    if (success) {
      memberList=memberInfoController.memberList;
    } else {
      Get.snackbar('Failed to Fetch data', memberInfoController.errorMessage!);
    }

  }
  void _onTapPopUpMenu(){
    final context = _addFabKey.currentContext;
    if (context == null) return;

    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    showMenu(
      color: Colors.cyan,
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + size.height + 4,
        offset.dx + size.width,
        0,
      ),
      items: const [
        PopupMenuItem(
          value: 'cost',
          child: Text('Cost'),
        ),
        PopupMenuItem(
          value: 'meal',
          child: Text('Meal'),
        ),PopupMenuItem(
          value: 'deposit',
          child: Text('Deposit'),
        ),
      ],
    ).then((value) {
      if (value == 'cost') {
        Get.to(() => AddCost());
      } else if (value == 'meal') {
        Get.to(() => AddMeal());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        title: Text(widget.messInfoModel!.messName ?? 'Mess Name'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _onTapPendingRequest,
            icon: Icon(Icons.notifications_active),
          ),
          IconButton(
            onPressed: onTapSignOut,
            icon: Icon(Icons.logout),
          ),
          SizedBox(width: 8),
        ],
      ),
      drawer: AppDrawer(),
      body: Column(
        children: [
          const SizedBox(height: 8),
          _buildBannerItems(size),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: memberList.length,
              itemBuilder: (context, index) {
                return _buildMembersDetailsCard(size, index);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildFloatingActionButton(heroTag: 'SendMessage', icon: Icon(Icons.send), onPressed: _onTapMessage,),
            _buildFloatingActionButton(heroTag: 'add',key: _addFabKey, icon: Icon(Icons.add), onPressed: _onTapPopUpMenu),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton(
      {required String heroTag, required Icon icon, required VoidCallback onPressed, Key? key,}) {
    return FloatingActionButton(
      heroTag: heroTag,
      key: key,
      onPressed: onPressed,
      mini: true,
      backgroundColor: Colors.cyan,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: icon,
    );
  }

  Widget _buildMembersDetailsCard(Size size, int index) {
    return Card(
      color: Colors.teal,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: size.width * .95,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Member ${memberList[index].name}'),
                  Text('Meal: ${memberList[index].meal}'),
                  Text('Deposit: ${memberList[index].deposit}'),
                ],
              ),
              Text('Balance : ${memberList[index].balance}'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBannerItems(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildBannerCard(size, 'Total Meal', '${widget.messInfoModel!.totalMeal}'),
        _buildBannerCard(size, 'Total Cost', '${widget.messInfoModel!.totalCost}'),
        _buildBannerCard(size, 'Meal Rate', '${widget.messInfoModel!.mealRate}'),
      ],
    );
  }

  Widget _buildBannerCard(Size size, String title, String value) {
    return Card(
      color: Colors.green,
      child: SizedBox(
        height: 80,
        width: size.width / 3.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            Text(value),
          ],
        ),
      ),
    );
  }
}