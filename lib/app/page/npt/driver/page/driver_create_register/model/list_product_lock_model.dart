class ListProductLockModel {
  int? id;
  String? name;
  bool? trangthai;

  ListProductLockModel({this.id, this.name, this.trangthai});

  ListProductLockModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    trangthai = json['trangthai'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['trangthai'] = trangthai;
    return data;
  }

  static List<ListProductLockModel> fromJsonList(List list) {
    return list.map((item) => ListProductLockModel.fromJson(item)).toList();
  }

  String userAsString() {
    return "${this.id} ${this.name} ${this.trangthai}";
  }

  bool isEqual(ListProductLockModel model) {
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
