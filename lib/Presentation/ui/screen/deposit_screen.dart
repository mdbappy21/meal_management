import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_management/Data/models/member_model.dart';
import 'package:meal_management/Presentation/state_holder/add_deposit_controller.dart';

class DepositScreen extends StatefulWidget {
  const DepositScreen({super.key, required this.memberList});

  final List<MemberModel> memberList;

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  final TextEditingController _depositTEController = TextEditingController();
  final GlobalKey _menuKey = GlobalKey();
  MemberModel? selectedMember;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Deposit Money')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            OutlinedButton(
              key: _menuKey,
              onPressed: () {
                _onTapChooseMember(context);
              },
              child: Text(
                selectedMember != null
                    ? selectedMember!.name ?? 'No Name'
                    : 'Choose Member',
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _depositTEController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Deposit Amount',
                labelText: 'Amount',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _onTapAddDeposit();
              },
              child: Text('Add Deposit'),
            ),
          ],
        ),
      ),
    );
  }

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
      items: widget.memberList
          .map(
            (member) => PopupMenuItem(
              value: member,
              child: Text(member.name ?? 'No Name'),
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

  Future<void> _onTapAddDeposit() async {
    AddDepositController addDepositController=Get.find<AddDepositController>();

    double amount=double.tryParse(_depositTEController.text.trim())??0;
    if (selectedMember == null) {
      Get.snackbar('Error', 'Please select a member');
      return;
    }else if(amount==0){
      Get.snackbar('Error', 'Please Enter amount');
      return;
    }else if(amount<0){
      Get.snackbar('Error', 'Please Enter positive amount');
      return;
    }else{
      final token = await FirebaseAuth.instance.currentUser?.getIdToken();
      bool success = await addDepositController.addDeposit(token: token!,amount:amount,  memberId: selectedMember!.id!);
      if (success) {
        Get.snackbar('Success', 'Deposit successfully');
        _depositTEController.clear();
      } else {
        Get.snackbar('Failed',addDepositController.errorMessage!);
      }
    }
  }
}
