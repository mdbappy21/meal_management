import 'package:get/get.dart';
import 'package:meal_management/Data/models/my_info_model.dart';
import 'package:meal_management/Data/models/network_response.dart';
import 'package:meal_management/Data/services/network_caller.dart';
import 'package:meal_management/Data/utils/urls.dart';

class MyInfoController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  MyInfoModel? myInfoModel;

  Future<bool> getMyInfo(String token) async {
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.myInfo,
      token: token,
    );
    if (response.isSuccess) {
      myInfoModel = MyInfoModel.fromJson(response.responseData);
      _inProgress = false;
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
