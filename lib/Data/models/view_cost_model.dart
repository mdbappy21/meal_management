class ViewCostModel {
  String? date;
  double? amount;

  ViewCostModel({this.date, this.amount});

  ViewCostModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['amount'] = amount;
    return data;
  }
}
