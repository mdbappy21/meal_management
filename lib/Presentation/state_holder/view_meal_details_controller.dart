import 'package:get/get.dart';
import 'package:meal_management/Data/models/network_response.dart';
import 'package:meal_management/Data/models/view_meal_model.dart';
import 'package:meal_management/Data/services/network_caller.dart';
import 'package:meal_management/Data/utils/urls.dart';

class ViewMealDetailsController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMassage;
  String? get errorMassage => _errorMassage;

  List<ViewMealModel> viewMealModelList = [];

  Future<bool> viewMealDetails(String token) async {
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.mealDetails,
      token: token,
    );

    _inProgress = false;

    if (response.isSuccess) {
      final List<dynamic> responseData = response.responseData;
      viewMealModelList = responseData.map((e) => ViewMealModel.fromJson(e)).toList();
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
