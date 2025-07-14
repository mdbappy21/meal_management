import 'package:meal_management/Presentation/utils/import_export.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.messInfoModel});
  final MessInfoModel? messInfoModel;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey _addFabKey=GlobalKey();
  MonthModel? monthModel;

  @override
  void initState() {
    super.initState();
    _onTapGetMembersInfo();
  }

  @override
  Widget build(BuildContext context) {
    if (monthModel == null) {
      return Scaffold(
        appBar: _buildAppBar(),
        body: CenteredCircularProgressIndicator(),
      );
    }
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: AppDrawer(monthModel: monthModel!, messInfoModel: widget.messInfoModel!,),
      body: RefreshIndicator(
        onRefresh: ()async{
          _refreshData();
        },
        child: Column(
          children: [
            const SizedBox(height: 8),
            _buildBannerItems(size),
            const SizedBox(height: 8),
            GetBuilder<MonthMembersInfoController>(
              builder: (monthMembersInfoController) {
                return Visibility(
                  visible: !monthMembersInfoController.inProgress,
                  replacement: CenteredCircularProgressIndicator(),
                  child: Expanded(
                    child: ListView.builder(
                      itemCount: monthModel?.members?.length??0,
                      itemBuilder: (context, index) {
                        return _buildMembersDetailsCard(size, index);
                      },
                    ),
                  ),
                );
              }
            ),
          ],
        ),
      ),
      floatingActionButton: _buildFAB(),
    );
  }

  //Widgets //
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.grey.shade300,
      title: Text(widget.messInfoModel?.messName ?? 'Mess Name'),
      centerTitle: true,
      actions: [
        if(widget.messInfoModel!.isManager!)
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
    );
  }

  Widget _buildFAB() {
    return Padding(
      padding: const EdgeInsets.only(left: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildFloatingActionButton(heroTag: 'SendMessage', icon: Icon(Icons.send), onPressed: _onTapMessage,),
          if(widget.messInfoModel!.isManager!)
            _buildFloatingActionButton(heroTag: 'add',key: _addFabKey, icon: Icon(Icons.add), onPressed: _onTapPopUpMenu),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton({required String heroTag, required Icon icon, required VoidCallback onPressed, Key? key,}) {
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
      color: monthModel!.members![index].isManager! ?Colors.orange:Colors.teal,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: size.width * .95,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: ${monthModel?.members?[index].name??'N/A'}'),
              Text('Email ${monthModel?.members?[index].email??'N/A'}'),
              Text('Total Meal: ${monthModel?.members?[index].totalMeal??'N/A'}'),
              Text('Deposit: ${monthModel?.members?[index].deposit??'Null deposit'}'),
              Text('Total Cost: ${((monthModel?.members?[index].totalMeal ?? 0) * (monthModel?.mealRate??0)) .toStringAsFixed(2)}'),
              Text('Balance : ${monthModel?.members?[index].balance??'null balance'}'),
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
        _buildBannerCard(size, 'Total Meal', '${monthModel?.totalMeal??'N/A'}'),
        _buildBannerCard(size, 'Total Cost', '${monthModel?.totalCost??'N/A'}'),
        _buildBannerCard(size, 'Meal Rate', monthModel?.mealRate?.toStringAsFixed(2)??'N/A'),
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

  //Functions //

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
          value: 'AddMember',
          child: Text('Add Member'),
        ),
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
        Get.to(() => AddMeal(member: monthModel!.members!,));
      }else if (value == 'AddMember') {
        Get.to(() => AddMember());
      }else if (value == 'deposit') {
        Get.to(() => DepositScreen(monthModel: monthModel!,));
      }
    });
  }

  Future<void>_onTapPendingRequest()async{
    PendingRequestController pendingRequestController=Get.find<PendingRequestController>();
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();
    bool isSuccess= await pendingRequestController.pendingRequest(token!);
    if(isSuccess){
      Get.to(()=>PendingRequest(pendingRequest: pendingRequestController.pendingRequests!));
    }else{
      // Get.offAll(() => const UserType());
      Get.snackbar('failed', '${pendingRequestController.errorMassage}');
    }
  }

  Future<void>_refreshData()async{
    _onTapGetMembersInfo();
  }

  Future<void>_onTapGetMembersInfo()async{
    MonthMembersInfoController monthMembersInfoController=Get.find<MonthMembersInfoController>();
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();
    bool success = await monthMembersInfoController.getMessDetails(token!);
    if (success) {
      monthModel=monthMembersInfoController.monthModel;
      setState(() {});
    } else {
      Get.snackbar('Failed to Fetch data', monthMembersInfoController.errorMessage??'missing error message');
    }
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

}