import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_management/Data/models/mess_info_model.dart';
import 'package:meal_management/Data/models/month_model.dart';
import 'package:meal_management/Data/services/wrapper.dart';
import 'package:meal_management/Presentation/state_holder/change_manager_controller.dart';

class ChangeManager extends StatelessWidget {
  const ChangeManager({
    super.key,
    required this.monthModel,
    required this.messInfoModel,
  });

  final MonthModel monthModel;
  final MessInfoModel messInfoModel;

  @override
  Widget build(BuildContext context) {
    // Size size=MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(title: Text('Change Manager')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            _buildCurrentManagerSection(),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                primary: true,
                itemCount: monthModel.members?.length ?? 1,
                itemBuilder: (context, index) {
                  final member = monthModel.members![index];
                  if (member.email == messInfoModel.manager) {
                    return const SizedBox.shrink();
                  }
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _buildMemberInfo(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Widgets //

  Widget _buildMemberInfo(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            monthModel.members?[index].email ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
          ),
        ),
        IconButton(
          onPressed: () {
            _onTapChangeManager(
              monthModel.members?[index].email ?? '',
            );
          },
          icon: Icon(Icons.star_border),
        ),
      ],
    );
  }

  Widget _buildCurrentManagerSection() {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.cyan,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Current Manager: '),
          Text('${messInfoModel.manager}'),
        ],
      ),
    );
  }

  // Functions //

  Future<void> _onTapChangeManager(String email) async {
    final ChangeManagerController changeManagerController =
        Get.find<ChangeManagerController>();
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();
    bool success = await changeManagerController.changeManager(token!, email);
    if (success) {
      Get.snackbar('Success', 'Successfully Change manager');
      Get.offAll(() => Wrapper());
    } else {
      Get.snackbar('Failed', changeManagerController.errorMessage!);
    }
  }
}
