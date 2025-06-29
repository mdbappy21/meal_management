import 'package:get/get.dart';
import 'package:meal_management/Data/services/network_caller.dart';
import 'package:meal_management/Presentation/state_holder/auth_controller.dart';
import 'package:meal_management/Presentation/state_holder/mess_info_controller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(NetworkCaller());
    Get.lazyPut(()=>MessInfoController(),fenix: true);
  }
}
