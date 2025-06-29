import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_management/Data/models/mess_info_model.dart';
import 'package:meal_management/Presentation/state_holder/mess_info_controller.dart';
import 'package:meal_management/Presentation/ui/screen/add_cost.dart';
import 'package:meal_management/Presentation/ui/screen/add_meal.dart';
import 'package:meal_management/Presentation/ui/screen/auth/sign_in.dart';
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


  Future<void> _onTapMessage() async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user == null) { /* user must be logged in */ }
//     AuthController authController=Get.find<AuthController>();
//     final token = await user?.getIdToken(); // no `true` parameter—cached and valid
//     authController.saveAccessToken(token!);
//     print('Firebase ID token: $token');
//     print('Saved Token : ${AuthController.accessToken1}');
//
// // Then use it in your request:
//     final NetworkResponse response = await Get.find<NetworkCaller>().postRequest(url:Urls.createMess);
//
//     print(response.statusCode);
//     // print(response.body);
//     final token = await FirebaseAuth.instance.currentUser?.getIdToken(true);
//     print('Firebase ID token: $token');
    // final response = await http.post(
    //   Uri.parse('http://192.168.0.180:8000/create-mess'),
    //   headers: {
    //     'Authorization': 'Bearer $token',
    //     'Content-Type': 'application/json',
    //   },
    //   body: jsonEncode({'name': 'TestMess'}),
    // );
    // print(response.body);
    // final response = await http.get(
    //   Uri.parse(Urls.messInfo),
    //   headers: {
    //     'Authorization': 'Bearer $token',
    //   },
    // );
    // print(response.body);
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
          IconButton(onPressed: (

              ) {
            _onTapMessage();
            // Navigator.push(context, MaterialPageRoute(builder: (context)=>SendMessage()));
          }, icon: Icon(Icons.notifications_active)),
          IconButton(onPressed: onTapSignOut
          , icon: Icon(Icons.logout)),
          SizedBox(width: 8),
        ],
      ),
      drawer: AppDrawer(),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                color: Colors.green,
                child: SizedBox(
                  height: 80,
                  width: size.width / 3.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Total Meal",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      Text('${widget.messInfoModel!.totalMeal}'),
                    ],
                  ),
                ),
              ),
              Card(
                color: Colors.green,
                child: SizedBox(
                  height: 80,
                  width: size.width / 3.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Total Cost",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      Text('${widget.messInfoModel!.totalCost}'),
                    ],
                  ),
                ),
              ),
              Card(
                color: Colors.green,
                child: SizedBox(
                  height: 80,
                  width: size.width / 3.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Meal Rate",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      Text('${widget.messInfoModel!.mealRate}'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: 20,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.teal,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SizedBox(
                      width: size.width * .95,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Member $index'),
                          Text('Meal: 20'),
                          Text('Balance : 100'),
                        ],
                      ),
                    ),
                  ),
                );
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
            FloatingActionButton(
              heroTag: 'SendMessage',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SendMessage()));
              },
              mini: true,
              backgroundColor: Colors.cyan,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(Icons.send),
            ),
            FloatingActionButton(
              heroTag: 'addCostMeal',
              key: _addFabKey,
              onPressed: () {
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
                    ),
                  ],
                ).then((value) {
                  if (value == 'cost') {
                    Get.to(()=>AddCost());
                  }else if(value=='meal'){
                    Get.to(()=>AddMeal());
                  }
                });

              },
              mini: true,
              backgroundColor: Colors.cyan,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
  
  Future<void> onTapSignOut() async {
    FirebaseAuth.instance.signOut();
    final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    sharedPreferences.remove('isLoggedIn');
    Get.offAll(SignIn());
  }
}


