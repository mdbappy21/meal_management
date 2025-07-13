import 'package:meal_management/Data/models/member_model.dart';

class MonthModel {
  String? name;
  double? totalMeal;
  double? totalCost;
  double? mealRate;
  double? totalDeposit;
  double? availableBalance;
  double? chefBill;
  int? availableDays;
  List<MemberModel>? members;

  MonthModel(
      {this.name,
        this.totalMeal,
        this.totalCost,
        this.mealRate,
        this.totalDeposit,
        this.availableBalance,
        this.chefBill,
        this.availableDays,
        this.members});

  MonthModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    totalMeal = (json['total_meal'] as num?)?.toDouble();
    totalCost = (json['total_cost'] as num?)?.toDouble();
    mealRate = (json['meal_rate']as num?)?.toDouble();
    totalDeposit = (json['total_deposit']as num?)?.toDouble();
    availableBalance = (json['available_balance']as num?)?.toDouble();
    chefBill = (json['chef_bill']as num?)?.toDouble();
    availableDays = json['available_days'];
    if (json['members'] != null) {
      members = <MemberModel>[];
      json['members'].forEach((v) {
        members!.add(MemberModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['total_meal'] = totalMeal;
    data['total_cost'] = totalCost;
    data['meal_rate'] = mealRate;
    data['total_deposit'] = totalDeposit;
    data['available_balance'] = availableBalance;
    data['chef_bill'] = chefBill;
    data['available_days'] = availableDays;
    if (members != null) {
      data['members'] = members!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

