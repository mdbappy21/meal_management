import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_management/Data/models/member_model.dart';
import 'package:meal_management/Presentation/state_holder/update_cost_controller.dart';


class UpdateCostScreen extends StatefulWidget {
  const UpdateCostScreen({super.key});

  @override
  State<UpdateCostScreen> createState() => _UpdateCostScreenState();
}

class _UpdateCostScreenState extends State<UpdateCostScreen> {
  DateTime? selectedDate = DateTime.now();
  final TextEditingController _dateTEController = TextEditingController();
  final TextEditingController _costTEController = TextEditingController();
  final GlobalKey<FormState>_globalKey=GlobalKey<FormState>();
  MemberModel? selectedMember;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Cost')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Form(
          key: _globalKey,
          child: Column(
            children: [
              const SizedBox(height: 16),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _dateTEController,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  hintText: 'YYYY-MM-DD',
                  labelText: 'Enter date',
                ),
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'Enter Date';
                  } else if (value?.length!=10) {
                    return 'Enter a valid Format YYYY-MM-DD';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _costTEController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Cost Amount',
                  labelText: 'Update Cost Amount',
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
      ),
    );
  }

  Future<void> _onTapUpdateMeal() async {
    if(!_globalKey.currentState!.validate()){
      return;
    }
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();
    final today = _dateTEController.text.trim();
    final amount=double.tryParse(_costTEController.text)??0;

    if (amount == 0 || today.isEmpty) {
      Get.snackbar('Error', 'Please select member and enter date');
      return;
    }

    final Map<String, dynamic> body = {
      "amount": amount,
      "date": today,
    };

    final updateCostController = Get.find<UpdateCostController>();
    final bool success = await updateCostController.updateCost(token!, body);

    if (success) {
      Get.snackbar('Success', 'Meal successfully updated');
      setState(() {
        _costTEController.clear();
        _dateTEController.clear();
      });
    } else {
      Get.snackbar('Failed', updateCostController.errorMessage ?? 'Update failed');
    }
  }
}
