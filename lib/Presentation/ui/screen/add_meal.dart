import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_management/Data/models/member_model.dart';
import 'package:meal_management/Presentation/state_holder/add_meal_controller.dart';

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
    _mealCounts = List.filled(widget.member.length, 0); // or default to 1/2 if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Meal')),
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
                            width: 160,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${widget.member[index].name}'),
                                Text('${widget.member[index].email}'),
                                Text('Total Meal : ${widget.member[index].name}'),
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
            ElevatedButton(onPressed: (){_onTapAddMeal();}, child: Text('Update'))
          ],
        ),
      ),
    );
  }
  Future<void> _onTapAddMeal() async {
    String formattedDate = DateTime.now().toIso8601String().split("T").first;
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();

    final body = {
      "date": formattedDate,
      "meals": List.generate(widget.member.length, (index) {
        return {
          // "member_id": widget.member[index].id,  // Make sure MemberModel has `id`
          "qty": _mealCounts[index],
        };
      }),
    };


    final bool success = await Get.find<AddMealController>().addMeal(token!, body);

    if (success) {
      Get.snackbar('Success', 'Successfully add meal');
    } else {
      Get.snackbar('Failed', 'Failed to add meal');
    }
  }
}
// OutlinedButton(
//   onPressed: _selectDate,
//   child: Text(selectedDate != null ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}' : 'select a date',
//   ),
// ),
// const SizedBox(height: 8),
// Future<void> _selectDate() async {
//   final DateTime? pickedDate = await showDatePicker(
//     context: context,
//     initialDate: DateTime(2025, 7, 25),
//     firstDate: DateTime(2025, 7, 1),
//     lastDate: DateTime(2025, 7, 30),
//   );
//
//   setState(() {
//     selectedDate = pickedDate;
//   });
// }