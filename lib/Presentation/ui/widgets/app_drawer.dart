import 'package:meal_management/Presentation/utils/export_import_drawer.dart';


class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key, required this.monthModel, required this.messInfoModel});
  final MonthModel monthModel;
  final MessInfoModel messInfoModel;

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
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
                    leading: const Icon(Icons.account_circle),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {
                      Get.to(()=>Profile());
                    },
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Text("Chef's Bill : ${widget.monthModel.chefBill}"),
                      ],
                    ),
                    leading: const Icon(Icons.food_bank),
                    onTap: () {},
                  ),
                  if(widget.messInfoModel.isManager!)
                  ListTile(
                    title: const Text("Add Members"),
                    leading: const Icon(Icons.person_add),
                    trailing: Icon(Icons.navigate_next),
                    onTap: () {
                      Get.to(()=>AddMember());
                    },
                  ),
                  if(widget.messInfoModel.isManager!)
                  ListTile(
                    title: const Text("Remove Members"),
                    leading: const Icon(Icons.person_remove),
                    trailing: Icon(Icons.navigate_next),
                    onTap: () {
                      Get.to(()=>RemoveMember(memberList: widget.monthModel.members!));
                    },
                  ),
                  if(widget.messInfoModel.isManager!)
                  ListTile(
                    title: const Text("Add Balance"),
                    leading: const Icon(Icons.add_card),
                    trailing: Icon(Icons.navigate_next),
                    onTap: () {
                      Get.to(()=>DepositScreen(monthModel: widget.monthModel));
                    },
                  ),
                  if(widget.messInfoModel.isManager!)
                  ListTile(
                    title: const Text("Add Meal"),
                    leading: const Icon(Icons.fastfood),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {
                      Get.to(()=>AddMeal(member: widget.monthModel.members!));
                    },
                  ),
                  if(widget.messInfoModel.isManager!)
                  ListTile(
                    title: const Text("Add Cost"),
                    leading: const Icon(Icons.request_page),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {
                      Get.to(()=>AddCost);
                    },
                  ),  ListTile(
                    title: const Text("Day left"),
                    leading: const Icon(Icons.timelapse),
                    trailing: Text('${widget.monthModel.availableDays}'),
                    onTap: () {},
                  ),
                  if(widget.messInfoModel.isManager!)
                  ListTile(
                    title: const Text("Change Manager"),
                    leading: const Icon(Icons.manage_accounts),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {
                      Get.to(()=>ChangeManager(monthModel: widget.monthModel, messInfoModel: widget.messInfoModel));
                    },
                  ),
                  ListTile(
                    title: const Text("Cost History"),
                    leading: const Icon(Icons.attach_money),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: _onTapCostDetails,
                  ),
                  ListTile(
                    title: const Text("Meal History"),
                    leading: const Icon(Icons.local_dining),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: _onTapMealDetails,
                  ),
                  if(widget.messInfoModel.isManager!)
                  ListTile(
                    title: const Text("Start New Month"),
                    leading: const Icon(Icons.skip_next),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {
                      ReuseAlertDialog.showAlertDialog(
                          title: 'New Month Starting',
                          middleText: 'Are you sure you Create a new Month?\nIt will Delete Previous Month',
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

  Future<void>_onTapMealDetails()async{
    final List<ViewMealModel> viewMealModel;
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();
    bool success = await Get.find<ViewMealDetailsController>().viewMealDetails(token!);
    ViewMealDetailsController viewMealDetailsController=Get.find<ViewMealDetailsController>();
    if (success) {
      viewMealModel=viewMealDetailsController.viewMealModelList;
      Get.to(()=>ViewMealDetails(viewMealModel: viewMealModel));
    } else {
      Get.snackbar('Failed to Fetch data', viewMealDetailsController.errorMassage??'missing error message');
    }
  }

  Future<void>_onTapCostDetails()async{
    final  List<ViewCostModel> viewCostModel;
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();
    ViewCostDetailsController viewCostDetailsController=Get.find<ViewCostDetailsController>();
    bool success = await viewCostDetailsController.viewCostDetails(token!);

    if (success) {
      viewCostModel=viewCostDetailsController.viewCostModelList;
      Get.to(()=>ViewCostDetails(viewCostModel:viewCostModel));
    } else {
      Get.snackbar('Failed to Fetch data', viewCostDetailsController.errorMassage??'missing error message');
    }
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

  String monthName() {
    String? temp = widget.monthModel.name?.split('-').last;
    if (temp != null && monthNameMapping.containsKey(temp)) {
      return monthNameMapping[temp]!;
    }
    return 'Unknown';
  }

  Map<String,String> monthNameMapping={
    '01':'January',
    '02':'February',
    '03':'March',
    '04':'April',
    '05':'May',
    '06':'June',
    '07':'July',
    '08':'August',
    '09':'September',
    '10':'October',
    '11':'November',
    '12':'December',
};

  //Widgets //

  Widget _buildDrawerHeader() {
    return DrawerHeader(
      decoration: BoxDecoration(color: Colors.teal),
      child: Row(
        children: [
          Image.asset('assets/images/logo.png', width: 100, height: 100),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('${widget.messInfoModel.messName}'), Text('Month: ${monthName()}')],
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