import 'package:get/get.dart';
import 'package:meal_management/Data/models/network_response.dart';
import 'package:meal_management/Data/models/pending_request_model.dart';
import 'package:meal_management/Data/services/network_caller.dart';
import 'package:meal_management/Data/utils/urls.dart';

class PendingRequestController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMassage;

  String? get errorMassage => _errorMassage;

  // PendingRequestModel? pendingRequestModel;
  List<PendingRequestModel> pendingRequests = [];

  Future<bool> pendingRequest(String token) async {
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.pendingJoinRequests,
      token: token,
    );

    if (response.isSuccess) {
      final data = response.responseData;
      if (data is List) {
        pendingRequests = data.map((e) => PendingRequestModel.fromJson(e)).toList();
        print(pendingRequests.length);
      } else {
        _errorMassage = "Unexpected response format";
        return false;
      }
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
