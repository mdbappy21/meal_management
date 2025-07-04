import 'package:get/get.dart';
import 'package:meal_management/Data/models/mess_model.dart';
import 'package:meal_management/Data/models/network_response.dart';
import 'package:meal_management/Data/services/network_caller.dart';
import 'package:meal_management/Data/utils/urls.dart';

class MessMembersInfoController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  MessModel? messModel;

  Future<bool> getMessDetails(String token) async {
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.messMemberDetails,
      token: token,
    );

    _inProgress = false;

    if (response.isSuccess) {
      messModel = MessModel.fromJson(response.responseData);
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
