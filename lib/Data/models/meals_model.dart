class Meals {
  String? date;
  double? count;

  Meals({this.date, this.count});

  Meals.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['count'] = count;
    return data;
  }
}