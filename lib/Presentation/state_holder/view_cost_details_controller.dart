import 'package:get/get.dart';
import 'package:meal_management/Data/models/network_response.dart';
import 'package:meal_management/Data/models/view_cost_model.dart';
import 'package:meal_management/Data/services/network_caller.dart';
import 'package:meal_management/Data/utils/urls.dart';

class ViewCostDetailsController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMassage;
  String? get errorMassage => _errorMassage;

  List<ViewCostModel> viewCostModelList = [];

  Future<bool> viewCostDetails(String token) async {
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.costDetails,
      token: token,
    );

    _inProgress = false;

    if (response.isSuccess) {
      final List<dynamic> responseData = response.responseData;
      viewCostModelList = responseData.map((e) => ViewCostModel.fromJson(e)).toList();
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
