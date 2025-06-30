class PendingRequestModel {
  int? requestId;
  int? userId;
  String? userName;
  String? userEmail;
  String? userPhone;
  String? requestedAt;

  PendingRequestModel(
      {this.requestId,
        this.userId,
        this.userName,
        this.userEmail,
        this.userPhone,
        this.requestedAt});

  PendingRequestModel.fromJson(Map<String, dynamic> json) {
    requestId = json['request_id'];
    userId = json['user_id'];
    userName = json['user_name'];
    userEmail = json['user_email'];
    userPhone = json['user_phone'];
    requestedAt = json['requested_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['request_id'] = requestId;
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['user_email'] = userEmail;
    data['user_phone'] = userPhone;
    data['requested_at'] = requestedAt;
    return data;
  }
}
