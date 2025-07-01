import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_management/Data/models/member_model.dart';
import 'package:meal_management/Presentation/state_holder/remove_member_controller.dart';

class RemoveMember extends StatelessWidget {
  RemoveMember({super.key, required this.memberList});
  final List<MemberModel>memberList;
  final RemoveMemberController removeMemberController = Get.find<RemoveMemberController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Remove Member')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: memberList.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.grey.shade200,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Name : ${memberList[index].name}'),
                                Text('Email : ${memberList[index].email}',maxLines: 2,overflow: TextOverflow.visible,softWrap: true,),
                                Text('Balance : ${memberList[index].balance}'),
                              ],
                            ),
                          ),

                          IconButton(onPressed: (){_onTapRemoveMember(index);}, icon: Icon(Icons.remove_circle_outline,color: Colors.red,))
                        ],
                      ),
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
  Future<void>_onTapRemoveMember(int index)async{
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();
    if(memberList[index].balance!=0){
      Get.snackbar("Warning", 'Member Has Due');
      return;
    }
    bool isSuccess= await removeMemberController.removeMember(token!,memberList[index].id!);
    if(isSuccess){
      Get.snackbar('Success', 'Successfully remove member');
    }else{
      // Get.offAll(() => const UserType());
      Get.snackbar('failed', '${removeMemberController.errorMassage}');
    }
  }
}
