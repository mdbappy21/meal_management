import 'package:get/get.dart';
import 'package:meal_management/Data/models/network_response.dart';
import 'package:meal_management/Data/services/network_caller.dart';
import 'package:meal_management/Data/utils/urls.dart';

class AddDepositPreviousMonthController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMassage;

  String? get errorMessage => _errorMassage;

  Future<bool> addDeposit({required String token,required String email}) async {
    _inProgress = true;
    update();

    final Map<String, dynamic> body = {
      "email": email,
    };

    final NetworkResponse response = await Get.find<NetworkCaller>().postRequest(
      url: Urls.clearDue,
      token: token,
      body: body
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