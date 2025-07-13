import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_management/Data/models/member_model.dart';
import 'package:meal_management/Data/models/view_meal_model.dart';
import 'package:meal_management/Presentation/state_holder/add_meal_controller.dart';
import 'package:meal_management/Presentation/state_holder/view_meal_details_controller.dart';
import 'package:meal_management/Presentation/ui/screen/update_meal_screen.dart';
import 'package:meal_management/Presentation/ui/screen/view_meal_details.dart';

class AddMeal extends StatefulWidget {
  const AddMeal({super.key, required this.member});
  final List<MemberModel> member;
  @override
  State<AddMeal> createState() => _AddMealState();
}

class _AddMealState extends State<AddMeal> {
  DateTime? selectedDate=DateTime.now();

  late List<double> _mealCounts;
  @override
  void initState() {
    super.initState();
    _mealCounts = List.filled(widget.member.length, 0);
  }

Future<void>_onTapDetails()async{
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


Future<void>_onTapUpdateMeals()async{
    Get.to(()=>UpdateMealScreen(member: widget.member));
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Meal'),
        actions: [
          IconButton(onPressed: (){
            _onTapDetails();
          }, icon: Icon(Icons.receipt_long)),
          IconButton(onPressed: (){
            _onTapUpdateMeals();
          }, icon: Icon(Icons.update)),
          const SizedBox(width: 16)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.member.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.teal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 170,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${widget.member[index].email?.split('@').first}'),
                                Text('${widget.member[index].email}'),
                                Text('Total Meal : ${widget.member[index].totalMeal}'),
                              ],
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.orange,
                            child: Text('${_mealCounts[index]}'),
                          ),
                          Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    _mealCounts[index]++;
                                  });
                                },
                                icon: Icon(Icons.add),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (_mealCounts[index] > 0) _mealCounts[index]--;
                                  });
                                },
                                icon: Icon(Icons.remove),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(onPressed: (){_onTapAddMeal();}, child: Text('Add Meal'))
          ],
        ),
      ),
    );
  }
  Future<void> _onTapAddMeal() async {
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();

    final today = DateTime.now().toIso8601String().split('T')[0]; // "YYYY-MM-DD"
    final body = List.generate(widget.member.length, (index) {
      return {
        "email": widget.member[index].email,
        "count": _mealCounts[index],
        "date": today,
      };
    });

    final bool success = await Get.find<AddMealController>().addMeal(token!, body);

    if (success) {
      Get.snackbar('Success', 'Successfully add meal');
      for (var i = 0; i < _mealCounts.length; i++) {
        _mealCounts[i] = 0;
      }
      setState(() {});
    } else {
      Get.snackbar('Failed', 'Failed to add meal');
    }
  }
}