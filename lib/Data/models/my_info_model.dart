class MyInfoModel {
  String? name;
  String? email;
  String? phone;
  String? city;
  String? messName;

  MyInfoModel({this.name, this.email, this.phone, this.city, this.messName});

  MyInfoModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    city = json['city'];
    messName = json['mess_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['city'] = city;
    data['mess_name'] = messName;
    return data;
  }
}
