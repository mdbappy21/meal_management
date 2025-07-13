import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_management/Data/models/view_cost_model.dart';
import 'package:meal_management/Presentation/state_holder/add_cost_controller.dart';
import 'package:meal_management/Presentation/state_holder/view_cost_details_controller.dart';
import 'package:meal_management/Presentation/ui/screen/update_cost_screen.dart';
import 'package:meal_management/Presentation/ui/screen/view_cost_details.dart';

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
        actions: [
          IconButton(onPressed: (){
            _onTapDetails();
          }, icon: Icon(Icons.receipt_long)),
          IconButton(onPressed: (){
            Get.to(()=>UpdateCostScreen());
          }, icon: Icon(Icons.update)),
          const SizedBox(width: 16)
        ],
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
                _onTapAddCost();
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

  // Functions//

  Future<void>_onTapDetails()async{
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

  Future<void> _onTapAddCost() async {
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();
    final date = DateTime.now().toIso8601String().split('T').first;
    final costAmount = double.tryParse(_amountTEController.text)??0;

    final body = {
      'amount': costAmount,
      'date': date,
    };

    final AddCostController addCostController = Get.find<AddCostController>();
    bool success = await addCostController.addCost(token!, body);

    if (success) {
      Get.snackbar('Success', 'Cost added successfully for today');
      _amountTEController.clear();
      if(mounted){
        FocusScope.of(context).unfocus();
      }
    } else {
      Get.snackbar('Failed', addCostController.errorMessage!);
    }
  }

  @override
  void dispose() {
    _amountTEController.dispose();
    super.dispose();
  }
}