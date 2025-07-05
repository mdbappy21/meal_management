class Members {
  String? email;
  double? totalMeal;
  double? deposit;
  double? balance;

  Members({this.email, this.totalMeal, this.deposit, this.balance});

  Members.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    totalMeal = json['total_meal'];
    deposit = json['deposit'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['total_meal'] = totalMeal;
    data['deposit'] = deposit;
    data['balance'] = balance;
    return data;
  }
}