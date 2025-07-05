import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_management/Presentation/state_holder/add_cost_controller.dart';

class AddCost extends StatefulWidget {
  const AddCost({super.key});

  @override
  State<AddCost> createState() => _AddCostState();
}

class _AddCostState extends State<AddCost> {
  DateTime? selectedDate;
  final TextEditingController _amountTEController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Cost'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            TextFormField(
              controller: _amountTEController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Cost',
                labelText: 'Amount',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _onTapConfirm();
              },
              style: ElevatedButton.styleFrom(
                fixedSize:Size(size.width*.6,50)
              ),
              child: Text('Confirm'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void>_onTapConfirm()async{
    AddCostController addCostController=Get.find<AddCostController>();
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();
    double amount=double.tryParse(_amountTEController.text)??0;
    if(amount<=0){
      Get.snackbar('Warning', 'Enter Correct amount and Try again');
      return;
    }

    bool success = await addCostController.addCost(token!,amount);
    if (success) {
      Get.snackbar('success', 'Successfully add cost');
    } else {
      Get.snackbar('Failed', addCostController.errorMessage!);
    }
  }
}