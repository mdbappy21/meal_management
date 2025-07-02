class MemberModel {
  int? id;
  String? name;
  String? email;
  double? meal;
  double? deposit;
  double? balance;
  bool? isManager;

  MemberModel({
    this.id,
    this.name,
    this.email,
    this.meal,
    this.deposit,
    this.balance,
    this.isManager,
  });

  MemberModel.fromJson(Map<String, dynamic> json) {
    id= json['id'];
    name = json['name'];
    email = json['email'];
    meal = (json['meals'] as num?)?.toDouble();
    deposit = (json['deposit'] as num?)?.toDouble();
    balance = (json['balance'] as num?)?.toDouble();
    isManager = json['is_manager'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'name': name,
      'email': email,
      'meal': meal,
      'deposit': deposit,
      'balance': balance,
      'is_manager': isManager,
    };
  }
}
