import 'package:get/get.dart';
import 'package:meal_management/Data/models/network_response.dart';
import 'package:meal_management/Data/models/previous_month_data_model.dart';
import 'package:meal_management/Data/services/network_caller.dart';
import 'package:meal_management/Data/utils/urls.dart';

class PreviousMonthController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMassage;
  String? get errorMassage => _errorMassage;

  PreviousMonthDataModel? previousMonthData;

  Future<bool> getMessInfo(String token) async {
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.previousMonth,
      token: token,
    );

    if (response.isSuccess) {
      previousMonthData = PreviousMonthDataModel.fromJson(response.responseData);
      _errorMassage = null;
      _inProgress = false;
      update();
      return true;
    } else {
      _errorMassage = response.errorMassage;
      _inProgress = false;
      update();
      return false;
    }
  }
}
