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

  List<PendingRequestModel>? pendingRequests;

  Future<bool> pendingRequest(String token) async {
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.pendingJoinRequests,
      token: token,
    );

    _inProgress = false;

    if (response.isSuccess) {
      final data = response.responseData;

      if (data is List) {
        pendingRequests = data
            .map((e) => PendingRequestModel.fromJson(e))
            .toList()
            .cast<PendingRequestModel>();

        _errorMassage = null;
        update();
        return true;
      } else {
        _errorMassage = "Unexpected response format";
        update();
        return false;
      }
    } else {
      _errorMassage = response.errorMassage;
      update();
      return false;
    }
  }
}
