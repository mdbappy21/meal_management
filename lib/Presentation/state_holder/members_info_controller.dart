import 'package:get/get.dart';
import 'package:meal_management/Data/models/network_response.dart';
import 'package:meal_management/Data/models/member_model.dart';
import 'package:meal_management/Data/services/network_caller.dart';
import 'package:meal_management/Data/utils/urls.dart';

class MembersInfoController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<MemberModel> memberList = [];

  Future<bool> fetchMembers(String token) async {
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.members,
      token: token,
    );

    _inProgress = false;

    if (response.isSuccess) {
      final List<dynamic> jsonList = response.responseData;
      memberList = jsonList.map((e) => MemberModel.fromJson(e)).toList();
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
