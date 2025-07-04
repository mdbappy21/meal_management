import 'package:get/get.dart';
import 'package:meal_management/Data/models/network_response.dart';
import 'package:meal_management/Data/services/network_caller.dart';
import 'package:meal_management/Data/utils/urls.dart';

class JoinRequestController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMassage;

  String? get errorMassage => _errorMassage;

  Future<bool> sentJoinRequest(String token,messName) async {
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.joinRequest(messName: messName),
      token: token,
    );

    if (response.isSuccess) {
      print(response.responseData);
      _errorMassage = null;
      _inProgress = false;
      update();
      return true;
    } else {
      print(response.errorMassage);
      _errorMassage = response.errorMassage;
      _inProgress = false;
      update();
      return false;
    }
  }
}
