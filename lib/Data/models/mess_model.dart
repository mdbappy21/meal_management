import 'package:meal_management/Data/models/member_model.dart';

class MessModel {
  String? monthStart;
  double? totalMeal;
  double? totalCost;
  double? chefBill;
  List<MemberModel>? members;

  MessModel(
      {this.monthStart,
        this.totalMeal,
        this.totalCost,
        this.chefBill,
        this.members});

  MessModel.fromJson(Map<String, dynamic> json) {
    monthStart = json['month_start'];
    totalMeal = json['total_meal'];
    totalCost = json['total_cost'];
    chefBill = json['chef_bill'];
    if (json['members'] != null) {
      members = <MemberModel>[];
      json['members'].forEach((v) {
        members!.add(MemberModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['month_start'] = monthStart;
    data['total_meal'] = totalMeal;
    data['total_cost'] = totalCost;
    data['chef_bill'] = chefBill;
    if (members != null) {
      data['members'] = members!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


