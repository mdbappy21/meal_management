import 'package:get/get.dart';
import 'package:meal_management/Data/models/network_response.dart';
import 'package:meal_management/Data/services/network_caller.dart';
import 'package:meal_management/Data/utils/urls.dart';

class AddCostController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> addCost(String token, Map<String, dynamic> body) async {
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().postRequest(
      url: Urls.addCost,
      body: body,
      token: token,
    );

    _inProgress = false;

    if (response.isSuccess) {
      _errorMessage = null;
      update();
      return true;
    } else {
      _errorMessage = response.errorMassage;
      update();
      return false;
    }
  }


}