import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_management/Data/models/mess_info_model.dart';
import 'package:meal_management/Data/models/month_model.dart';
import 'package:meal_management/Data/services/wrapper.dart';
import 'package:meal_management/Presentation/state_holder/delete_mess_controller.dart';
import 'package:meal_management/Presentation/state_holder/previous_month_controller.dart';
import 'package:meal_management/Presentation/state_holder/start_new_month_controller.dart';
import 'package:meal_management/Presentation/ui/screen/add_cost.dart';
import 'package:meal_management/Presentation/ui/screen/add_meal.dart';
import 'package:meal_management/Presentation/ui/screen/add_member.dart';
import 'package:meal_management/Presentation/ui/screen/auth/sign_in.dart';
import 'package:meal_management/Presentation/ui/screen/change_manager.dart';
import 'package:meal_management/Presentation/ui/screen/deposit_screen.dart';
import 'package:meal_management/Presentation/ui/screen/previous_month_data_screen.dart';
import 'package:meal_management/Presentation/ui/screen/profile.dart';
import 'package:meal_management/Presentation/ui/screen/remove_member.dart';
import 'package:meal_management/Presentation/ui/screen/user_type.dart';
import 'package:meal_management/Presentation/ui/widgets/reuse_alert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key, required this.monthModel, required this.messInfoModel});
  final MonthModel monthModel;
  final MessInfoModel messInfoModel;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          _buildDrawerHeader(),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    title: const Text("Profile"),
                    leading: const Icon(Icons.person),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));
                    },
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Text("Chef's Bill : ${monthModel.chefBill}"),
                      ],
                    ),
                    leading: const Icon(Icons.cookie),
                    onTap: () {},
                  ),
                  // ListTile(
                  //   title: Row(
                  //     children: [
                  //       const Text("Fridge Bill :"),
                  //       Expanded(child: TextFormField())
                  //     ],
                  //   ),
                  //   leading: const Icon(Icons.shop),
                  //   onTap: () {},
                  // ),
                  ListTile(
                    title: const Text("Add Members"),
                    leading: const Icon(Icons.people),
                    trailing: Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddMember()));
                    },
                  ),
                  ListTile(
                    title: const Text("Remove Members"),
                    leading: const Icon(Icons.people),
                    trailing: Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>RemoveMember(memberList: monthModel.members!,)));
                    },
                  ),
                  ListTile(
                    title: const Text("Add Balance"),
                    leading: const Icon(Icons.money),
                    trailing: Icon(Icons.navigate_next),
                    onTap: () {
                      Get.to(()=>DepositScreen(monthModel: monthModel));
                    },
                  ),
                  ListTile(
                    title: const Text("Add Meal"),
                    leading: const Icon(Icons.add_circle_outline),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddMeal(member: monthModel.members!,)));
                    },
                  ),
                  ListTile(
                    title: const Text("Add Cost"),
                    leading: const Icon(Icons.add_circle_outline),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddCost()));
                    },
                  ),  ListTile(
                    title: const Text("Day left"),
                    leading: const Icon(Icons.date_range),
                    trailing: Text('16'),
                    onTap: () {},
                  ),  ListTile(
                    title: const Text("Change Manager"),
                    leading: const Icon(Icons.person),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {
                      Get.to(()=>ChangeManager(monthModel: monthModel, messInfoModel: messInfoModel));
                    },
                  ),  ListTile(
                    title: const Text("Cost History"),
                    leading: const Icon(Icons.download),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {},
                  ),
                  ListTile(
                    title: const Text("My Meal"),
                    leading: const Icon(Icons.download),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {},
                  ),
                  ListTile(
                    title: const Text("Start New Month"),
                    leading: const Icon(Icons.skip_next),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {
                      ReuseAlertDialog.showAlertDialog(
                          title: 'New Month Starting',
                          middleText: 'Are you sure you Create a new Month?',
                          onConfirm: onTapConfirmStartNewMonth,
                      );
                    },
                  ),
                  ListTile(
                    title: const Text("Previous Month"),
                    leading: const Icon(Icons.skip_previous),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {
                      _onTapPreviousMonthData();
                    },
                  ),
                  ListTile(
                    title: const Text("Dark Mode"),
                    leading: const Icon(Icons.dark_mode),
                    onTap: () {},
                  ),
                  ListTile(
                    title: const Text("Delete mess",style: TextStyle(color: Colors.red),),
                    leading: const Icon(Icons.delete_forever,color: Colors.red,),
                    onTap: (){
                      // _onTapDeleteMess();
                      ReuseAlertDialog.showAlertDialog(title: 'Delete Mess', middleText: 'Are you sure you Want to delete Mess?', onConfirm: _onTapDeleteMess);
                    },
                  ),
                  ListTile(
                    title: const Text("Logout"),
                    leading: const Icon(Icons.logout),
                    onTap: () {
                      ReuseAlertDialog.showAlertDialog(title: 'Logout', middleText: 'Are you sure you want to Logout', onConfirm: onTapSignOut);
                    },
                  ),
                ],
              ),
            ),
          ),

          _buildDeveloperInfo(),
        ],
      ),
    );
  }
  Future<void> onTapSignOut() async {
    FirebaseAuth.instance.signOut();
    final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    sharedPreferences.remove('isLoggedIn');
    Get.offAll(SignIn());
  }

  Future<void>_onTapPreviousMonthData()async{
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();
    PreviousMonthController previousMonthController=Get.find<PreviousMonthController>();
    bool isSuccess = await previousMonthController.getMessInfo(token!);
    if(isSuccess){
      Get.to(()=>PreviousMonthDataScreen(previousMonthDataModel: previousMonthController.previousMonthData!,));
    }else{
      Get.snackbar('Failed', previousMonthController.errorMassage!);
    }
  }

  Future<void>_onTapDeleteMess()async{
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();
    DeleteMessController deleteMessController=Get.find<DeleteMessController>();
    bool isSuccess = await deleteMessController.deleteMess(token!);
    if(isSuccess){
      Get.snackbar('Success', 'Successfully deleted mess');
      Get.offAll(()=>UserType());
    }{
      Get.snackbar('Failed', deleteMessController.errorMassage!);
    }
  }

  Future<void>onTapConfirmStartNewMonth()async{
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();
    StartNewMonthController startNewMonthController=Get.find<StartNewMonthController>();
    bool success = await startNewMonthController.createNewMonth(token!);
    if (success) {
      Get.snackbar('Success','Successfully create new Month');
      Future.delayed(const Duration(seconds: 1));
      Get.offAll(()=>Wrapper());
    } else {
      Get.snackbar('Failed to Fetch data', startNewMonthController.errorMassage!,colorText: Colors.white60,backgroundColor: Colors.black54);
    }
  }

  Widget _buildDrawerHeader() {
    return DrawerHeader(
      decoration: BoxDecoration(color: Colors.teal),
      child: Row(
        children: [
          Image.asset('assets/images/logo.png', width: 100, height: 100),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('Mess-1'), Text('Month: ${monthModel.name}')],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeveloperInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Column(
        children: [
          const Text(
            "Developer : Md Bappy",
            style: TextStyle(color: Colors.grey),
          ),
          const Text(
            "Contact: mdbappy21.cse@gmail.com",
            style: TextStyle(color: Colors.grey),
          ),
          const Text(
            "Version 1.0.0",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}