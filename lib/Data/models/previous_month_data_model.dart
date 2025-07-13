import 'package:meal_management/Data/models/previous_month_member_model.dart';

class PreviousMonthDataModel {
  String? month;
  double? mealRate;
  double? totalMeal;
  double? totalCost;
  List<Members>? members;

  PreviousMonthDataModel(
      {this.month,
        this.mealRate,
        this.totalMeal,
        this.totalCost,
        this.members});

  PreviousMonthDataModel.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    mealRate = (json['meal_rate'] as num?)?.toDouble();
    totalMeal = (json['total_meal'] as num?)?.toDouble();
    totalCost = (json['total_cost'] as num?)?.toDouble();
    if (json['members'] != null) {
      members = <Members>[];
      json['members'].forEach((v) {
        members!.add(Members.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['month'] = month;
    data['meal_rate'] = mealRate;
    data['total_meal'] = totalMeal;
    data['total_cost'] = totalCost;
    if (members != null) {
      data['members'] = members!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


