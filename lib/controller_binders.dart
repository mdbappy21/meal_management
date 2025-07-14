import 'package:meal_management/Presentation/utils/export_controller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.put(NetworkCaller());
    Get.lazyPut(()=>MessInfoController(),fenix: true);
    Get.lazyPut(()=>JoinRequestController(),fenix: true);
    Get.lazyPut(()=>PendingRequestController(),fenix: true);
    Get.lazyPut(()=>ApproveRequestController(),fenix: true);
    Get.lazyPut(()=>RejectRequestController(),fenix: true);
    Get.lazyPut(()=>MonthMembersInfoController(),fenix: true);
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
    Get.lazyPut(()=>CancelRequestController(),fenix: true);
    Get.lazyPut(()=>ViewMealDetailsController(),fenix: true);
    Get.lazyPut(()=>UpdateMealsController(),fenix: true);
    Get.lazyPut(()=>ViewCostDetailsController(),fenix: true);
    Get.lazyPut(()=>UpdateCostController(),fenix: true);
    Get.lazyPut(()=>MyInfoController(),fenix: true);
    Get.lazyPut(()=>UpdateInfoController(),fenix: true);
  }
}
