class MemberModel {
  String? email;
  String? name;
  String? phone;
  String? cityName;
  bool? isManager;
  double? totalMeal;
  double? deposit;
  double? balance;

  MemberModel(
      {this.email,
        this.name,
        this.isManager,
        this.totalMeal,
        this.deposit,
        this.balance});

  MemberModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    isManager = json['is_manager'];
    totalMeal = (json['total_meal']as num?)?.toDouble();
    deposit = (json['deposit']as num?)?.toDouble();
    balance = (json['balance']as num?)?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['name'] = name;
    data['is_manager'] = isManager;
    data['total_meal'] = totalMeal;
    data['deposit'] = deposit;
    data['balance'] = balance;
    return data;
  }
}
