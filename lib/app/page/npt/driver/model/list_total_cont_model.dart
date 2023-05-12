class ListTotalModel {
  String? number;
  ListTotalModel({this.number});
  ListTotalModel.fromJson(Map<String, dynamic> json) {
    number = json["number"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["number"] = number;
    return data;
  }

  static List<ListTotalModel> fromJsonList(List list) {
    return list.map((item) => ListTotalModel.fromJson(item)).toList();
  }

  String userAsString() {
    return "${this.number}";
  }

  bool isEqual(ListTotalModel model) {
    return this.number == model.number;
  }

  @override
  String toString() => number!;
}
