class ListNumberContModel {
  int? id;
  String? name;

  ListNumberContModel({this.id, this.name});

  ListNumberContModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }

  static List<ListNumberContModel> fromJsonList(List list) {
    return list.map((item) => ListNumberContModel.fromJson(item)).toList();
  }

  String userAsString() {
    return "${this.id} ${this.name}";
  }

  bool isEqual(ListNumberContModel model) {
    return this.name == model.name;
  }

  @override
  String toString() {
    if (name == null) {
      return name = "";
    }
    return name!;
  }
}
