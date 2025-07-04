import 'package:meal_management/Data/models/meals_dates.dart';

class MemberModel {
  String? name;
  String? email;
  double? totalMeal;
  double? deposit;
  double? balance;
  List<MealsDates>? mealsDates;

  MemberModel(
      {this.name,
        this.email,
        this.totalMeal,
        this.deposit,
        this.balance,
        this.mealsDates});

  MemberModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    totalMeal = json['total_meal'];
    deposit = json['deposit'];
    balance = json['balance'];
    if (json['meals_dates'] != null) {
      mealsDates = <MealsDates>[];
      json['meals_dates'].forEach((v) {
        mealsDates!.add(MealsDates.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['total_meal'] = totalMeal;
    data['deposit'] = deposit;
    data['balance'] = balance;
    if (mealsDates != null) {
      data['meals_dates'] = mealsDates!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}