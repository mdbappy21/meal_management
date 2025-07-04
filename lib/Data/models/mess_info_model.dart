class MessInfoModel {
  String? messName;
  String? manager;
  List<String>? members;

  MessInfoModel({this.messName, this.manager, this.members});

  MessInfoModel.fromJson(Map<String, dynamic> json) {
    messName = json['mess_name'];
    manager = json['manager'];
    members = json['members'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mess_name'] = messName;
    data['manager'] = manager;
    data['members'] = members;
    return data;
  }
}