class MealsDates {
  String? date;
  double? meals;

  MealsDates({this.date, this.meals});

  MealsDates.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    meals = json['meals'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['meals'] = meals;
    return data;
  }
}