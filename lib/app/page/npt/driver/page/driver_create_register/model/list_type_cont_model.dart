class ListTypeContModel {
  String? typeContname;
  bool? status;
  String? typeContCode;

  ListTypeContModel({this.typeContname, this.status, this.typeContCode});

  ListTypeContModel.fromJson(Map<String, dynamic> json) {
    typeContname = json['typeContname'];
    status = json['status'];
    typeContCode = json['typeContCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['typeContname'] = typeContname;
    data['status'] = status;
    data['typeContCode'] = typeContCode;
    return data;
  }

  static List<ListTypeContModel> fromJsonList(List list) {
    return list.map((item) => ListTypeContModel.fromJson(item)).toList();
  }

  String userAsString() {
    return "${this.typeContCode} ${this.typeContname}";
  }

  bool isEqual(ListTypeContModel model) {
    return this.typeContname == model.typeContname;
  }

  @override
  String toString() {
    if (typeContname == null) {
      return typeContname = "";
    }
    return typeContname!;
  }
}
