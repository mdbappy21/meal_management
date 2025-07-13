import 'package:get/get.dart';
import 'package:meal_management/Data/models/month_model.dart';
import 'package:meal_management/Data/models/network_response.dart';
import 'package:meal_management/Data/services/network_caller.dart';
import 'package:meal_management/Data/utils/urls.dart';

class MonthMembersInfoController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  MonthModel? monthModel;

  Future<bool> getMessDetails(String token) async {
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.monthDetails,
      token: token,
    );

    _inProgress = false;

    if (response.isSuccess) {
      monthModel = MonthModel.fromJson(response.responseData);
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
