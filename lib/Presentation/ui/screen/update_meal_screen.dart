import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_management/Data/models/member_model.dart';
import 'package:meal_management/Data/models/view_meal_model.dart';
import 'package:meal_management/Presentation/state_holder/add_meal_controller.dart';
import 'package:meal_management/Presentation/state_holder/update_meals_controller.dart';
import 'package:meal_management/Presentation/state_holder/view_meal_details_controller.dart';
import 'package:meal_management/Presentation/ui/screen/view_meal_details.dart';

class UpdateMealScreen extends StatefulWidget {
  const UpdateMealScreen({super.key, required this.member});

  final List<MemberModel> member;

  @override
  State<UpdateMealScreen> createState() => _UpdateMealScreenState();
}

class _UpdateMealScreenState extends State<UpdateMealScreen> {
  DateTime? selectedDate = DateTime.now();
  final GlobalKey _menuKey = GlobalKey();
  final TextEditingController _dateTEController = TextEditingController();
  final TextEditingController _mealTEController = TextEditingController();
  MemberModel? selectedMember;

  void _onTapChooseMember(BuildContext context) {
    final RenderBox renderBox =
        _menuKey.currentContext?.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + size.height + 4,
        offset.dx + size.width,
        0,
      ),
      color: Colors.grey.shade200,
      items: widget.member
          .map(
            (member) => PopupMenuItem(
              value: member,
              child: Text(member.email ?? 'No Name'),
            ),
          )
          .toList(),
    ).then((value) {
      if (value != null) {
        setState(() {
          selectedMember = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Meal')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            OutlinedButton(
              key: _menuKey,
              onPressed: () {
                _onTapChooseMember(context);
              },
              child: Text(
                selectedMember != null
                    ? selectedMember!.email ?? 'No Name'
                    : 'Choose Member',
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _dateTEController,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                hintText: 'YYYY-MM-DD',
                labelText: 'Enter date',
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _mealTEController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Meal Number',
                labelText: 'Update meal Amount',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _onTapUpdateMeal();
              },
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onTapUpdateMeal() async {
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();
    final today = _dateTEController.text.trim();

    if (selectedMember == null || today.isEmpty) {
      Get.snackbar('Error', 'Please select member and enter date');
      return;
    }

    final int index = widget.member.indexOf(selectedMember!);

    final Map<String, dynamic> body = {
      "email": selectedMember!.email,
      "count": _mealTEController.text,
      "date": today,
    };

    final updateMealsController = Get.find<UpdateMealsController>();
    final bool success = await updateMealsController.updateMeals(token!, body);

    if (success) {
      Get.snackbar('Success', 'Meal successfully updated');
      setState(() {
        _mealTEController.clear();
        _dateTEController.clear();
      });
    } else {
      Get.snackbar('Failed', updateMealsController.errorMessage ?? 'Update failed');
    }
  }
}
