import 'dart:convert';

import 'package:http/http.dart';
import 'package:meal_management/Data/models/network_response.dart';
import 'package:meal_management/Presentation/state_holder/auth_controller.dart';

class NetworkCaller {
  Future<NetworkResponse> getRequest({required String url,required String token}) async {
    try {
      Uri uri = Uri.parse(url);
      Response response = await get(
        uri,
        headers: { 'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        final decodedBody = jsonDecode(response.body);
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: decodedBody,
        );
      } else {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
        );
      }
    } catch (e) {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMassage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> postRequest({required String url, Map<String, dynamic>? body, required String token}) async {
    try {
      Uri uri = Uri.parse(url);
      Response response = await post(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'content-type': 'Application/json',
        },
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
        );
      } else {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          errorMassage: response.body
        );
      }
    } catch (e) {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMassage: e.toString(),
      );
    }
  }
}
