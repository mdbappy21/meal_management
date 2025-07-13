import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_management/Data/models/previous_month_data_model.dart';
import 'package:meal_management/Presentation/state_holder/add_deposit_previous_month_controller.dart';
import 'package:meal_management/Presentation/ui/widgets/reuse_alert_dialog.dart';

class PreviousMonthDataScreen extends StatefulWidget {
  const PreviousMonthDataScreen(
      {super.key, required this.previousMonthDataModel});

  final PreviousMonthDataModel previousMonthDataModel;

  @override
  State<PreviousMonthDataScreen> createState() =>
      _PreviousMonthDataScreenState();
}

class _PreviousMonthDataScreenState extends State<PreviousMonthDataScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Previous Month'),
      ),
      body: Column(
        children: [
          _buildBannerItems(size),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: widget.previousMonthDataModel.members?.length ?? 0,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  color: Colors.grey.shade300,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Member: ${widget.previousMonthDataModel
                            .members?[index].email ?? 'N/A'}', style: TextStyle(
                            fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Total Meal: ${widget.previousMonthDataModel
                                        .members?[index].totalMeal}'),
                                Text('Deposit: ${widget.previousMonthDataModel
                                    .members?[index].deposit}'),
                                Text('Balance: ${widget.previousMonthDataModel
                                    .members?[index].balance}'),
                                Text('Due: ${widget.previousMonthDataModel
                                    .members?[index].balance}'),
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(onPressed: () {
                                  _onTapClearDue(index);
                                }, icon: Icon(Icons.remove_done)),
                                Text('Clear Due'),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onTapClearDue(int index) async {
    String email = widget.previousMonthDataModel.members![index].email!;
    ReuseAlertDialog.showAlertDialog(title: 'Due Payment',
      middleText: 'Are you sure $email pay Due Amount ${widget
          .previousMonthDataModel.members![index].balance}',
      onConfirm: () {
        _onTapClearDueConfirm(email);
        Get.close(1);
      },
    );
  }

  Future<void> _onTapClearDueConfirm(String email) async {
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();
    AddDepositPreviousMonthController addDepositPreviousMonthController = Get.find<AddDepositPreviousMonthController>();
    bool success = await addDepositPreviousMonthController.addDeposit(
        email: email, token: token!);
    if (success) {
      Get.snackbar('Success', 'Successfully Pay DUe');
    } else {
      Get.snackbar('Failed', addDepositPreviousMonthController.errorMessage!,
          colorText: Colors.white60, backgroundColor: Colors.black54);
    }
  }

  Widget _buildBannerItems(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildBannerCard(
            size, 'Total Meal', '${widget.previousMonthDataModel.totalMeal}'),
        _buildBannerCard(
            size, 'Total Cost', '${widget.previousMonthDataModel.totalCost}'),
        _buildBannerCard(
            size, 'Meal Rate', '${widget.previousMonthDataModel.mealRate} '),
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
}
