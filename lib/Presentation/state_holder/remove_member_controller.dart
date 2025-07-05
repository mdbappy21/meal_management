import 'package:get/get.dart';
import 'package:meal_management/Data/models/network_response.dart';
import 'package:meal_management/Data/services/network_caller.dart';
import 'package:meal_management/Data/utils/urls.dart';

class RemoveMemberController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMassage;
  String? get errorMassage => _errorMassage;

  Future<bool> removeMember(String token, String email) async {
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().deleteRequest(
      url: Urls.removeMember(email: email),
      token: token,
    );

    _inProgress = false;

    if (response.isSuccess) {
      _errorMassage = null;
      update();
      return true;
    } else {
      _errorMassage = response.errorMassage;
      update();
      return false;
    }
  }
}
