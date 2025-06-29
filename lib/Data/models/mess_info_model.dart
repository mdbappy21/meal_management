import 'package:meal_management/Data/models/manager.dart';

class MessInfoModel {
  String? messName;
  double? totalMeal;
  double? totalCost;
  double? mealRate;
  double? shafBill;
  double? utilityBill;
  String? currentMonth;
  Manager? manager;

  MessInfoModel(
      {this.messName,
        this.totalMeal,
        this.totalCost,
        this.mealRate,
        this.shafBill,
        this.utilityBill,
        this.currentMonth,
        this.manager});

  MessInfoModel.fromJson(Map<String, dynamic> json) {
    messName = json['mess_name'];
    totalMeal = (json['total_meal'] as num?)?.toDouble();
    totalCost = (json['total_cost'] as num?)?.toDouble();
    mealRate = (json['meal_rate'] as num?)?.toDouble();
    shafBill = (json['shaf_bill'] as num?)?.toDouble();
    utilityBill = (json['utility_bill'] as num?)?.toDouble();
    currentMonth = json['current_month'];
    manager = json['manager'] != null ? Manager.fromJson(json['manager']) : null;
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mess_name'] = messName;
    data['total_meal'] = totalMeal;
    data['total_cost'] = totalCost;
    data['meal_rate'] = mealRate;
    data['shaf_bill'] = shafBill;
    data['utility_bill'] = utilityBill;
    data['current_month'] = currentMonth;
    if (manager != null) {
      data['manager'] = manager!.toJson();
    }
    return data;
  }
}


