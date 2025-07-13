class MessInfoModel {
  String? messName;
  String? manager;
  bool? isManager;

  MessInfoModel({this.messName, this.manager, this.isManager});

  MessInfoModel.fromJson(Map<String, dynamic> json) {
    messName = json['mess_name'];
    manager = json['manager_email'];
    isManager = json['is_manager'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mess_name'] = messName;
    data['manager'] = manager;
    data['members'] = isManager;
    return data;
  }
}