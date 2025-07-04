class PendingRequestModel {
  List<String>? pendingRequests;

  PendingRequestModel({this.pendingRequests});

  PendingRequestModel.fromJson(Map<String, dynamic> json) {
    pendingRequests = json['pending_requests'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pending_requests'] = pendingRequests;
    return data;
  }
}