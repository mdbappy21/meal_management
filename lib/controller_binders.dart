import 'package:get/get.dart';
import 'package:meal_management/Data/services/network_caller.dart';
import 'package:meal_management/Presentation/state_holder/add_member_controller.dart';
import 'package:meal_management/Presentation/state_holder/approve_request_controller.dart';
import 'package:meal_management/Presentation/state_holder/auth_controller.dart';
import 'package:meal_management/Presentation/state_holder/leave_mess_controller.dart';
import 'package:meal_management/Presentation/state_holder/mess_info_controller.dart';
import 'package:meal_management/Presentation/state_holder/previous_month_controller.dart';
import 'package:meal_management/Presentation/state_holder/remove_member_controller.dart';
import 'Presentation/state_holder/add_cost_controller.dart';
import 'Presentation/state_holder/add_deposit_controller.dart';
import 'Presentation/state_holder/add_deposit_previous_month_controller.dart';
import 'Presentation/state_holder/add_meal_controller.dart';
import 'Presentation/state_holder/change_manager_controller.dart';
import 'Presentation/state_holder/create_mess_controller.dart';
import 'Presentation/state_holder/delete_mess_controller.dart';
import 'Presentation/state_holder/join_request_controller.dart';
import 'Presentation/state_holder/mess_members_info_controller.dart';
import 'Presentation/state_holder/pending_request_controller.dart';
import 'Presentation/state_holder/reject_request_controller.dart';
import 'Presentation/state_holder/start_new_month_controller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(NetworkCaller());
    Get.lazyPut(()=>MessInfoController(),fenix: true);
    Get.lazyPut(()=>JoinRequestController(),fenix: true);
    Get.lazyPut(()=>PendingRequestController(),fenix: true);
    Get.lazyPut(()=>ApproveRequestController(),fenix: true);
    Get.lazyPut(()=>RejectRequestController(),fenix: true);
    Get.lazyPut(()=>MessMembersInfoController(),fenix: true);
    Get.lazyPut(()=>RemoveMemberController(),fenix: true);
    Get.lazyPut(()=>LeaveMessController(),fenix: true);
    Get.lazyPut(()=>AddMemberController(),fenix: true);
    Get.lazyPut(()=>AddMealController(),fenix: true);
    Get.lazyPut(()=>AddDepositController(),fenix: true);
    Get.lazyPut(()=>AddCostController(),fenix: true);
    Get.lazyPut(()=>CreateMessController(),fenix: true);
    Get.lazyPut(()=>DeleteMessController(),fenix: true);
    Get.lazyPut(()=>ChangeManagerController(),fenix: true);
    Get.lazyPut(()=>StartNewMonthController(),fenix: true);
    Get.lazyPut(()=>PreviousMonthController(),fenix: true);
    Get.lazyPut(()=>AddDepositPreviousMonthController(),fenix: true);
  }
}
