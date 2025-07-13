import 'package:meal_management/Data/models/meals_model.dart';

class ViewMealModel {
  String? email;
  List<Meals>? meals;

  ViewMealModel({this.email, this.meals});

  ViewMealModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    if (json['meals'] != null) {
      meals = <Meals>[];
      json['meals'].forEach((v) {
        meals!.add(Meals.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    if (meals != null) {
      data['meals'] = meals!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


