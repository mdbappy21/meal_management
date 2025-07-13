class PendingRequestModel {
  final int id;
  final String userEmail;

  PendingRequestModel({required this.id, required this.userEmail});

  factory PendingRequestModel.fromJson(Map<String, dynamic> json) {
    return PendingRequestModel(
      id: json['id'],
      userEmail: json['user_email'],
    );
  }
}
