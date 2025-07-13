import 'package:get/get.dart';
import 'package:meal_management/Data/models/network_response.dart';
import 'package:meal_management/Data/services/network_caller.dart';
import 'package:meal_management/Data/utils/urls.dart';

class CancelRequestController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMassage;

  String? get errorMessage => _errorMassage;

  Future<bool> cancelJoinRequest(String token) async {
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().deleteRequest(
        url: Urls.cancelJoinRequest,
        token: token,
    );

    _inProgress = false;

    if (response.isSuccess) {
      _errorMassage = null;
      update();
      return true;
    } else {
      _errorMassage = response.errorMassage;
      print(_errorMassage);
      update();
      return false;
    }
  }

}