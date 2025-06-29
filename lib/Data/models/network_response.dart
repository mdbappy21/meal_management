class NetworkResponse {
  final int statusCode;
  dynamic responseData;
  String? errorMassage;
  final bool isSuccess;

  NetworkResponse({
    required this.statusCode,
    required this.isSuccess,
    this.responseData,
    this.errorMassage,
  });
}
