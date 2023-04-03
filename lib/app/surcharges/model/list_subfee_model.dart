class ListSubFeeModel {
  int? subFeeId;
  String? subFeeName;
  String? subFeeTypeName;
  String? subFeeDescription;

  ListSubFeeModel(
      {this.subFeeId,
      this.subFeeName,
      this.subFeeTypeName,
      this.subFeeDescription});

  ListSubFeeModel.fromJson(Map<String, dynamic> json) {
    subFeeId = json['subFeeId'];
    subFeeName = json['subFeeName'];
    subFeeTypeName = json['subFeeTypeName'];
    subFeeDescription = json['subFeeDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subFeeId'] = subFeeId;
    data['subFeeName'] = subFeeName;
    data['subFeeTypeName'] = subFeeTypeName;
    data['subFeeDescription'] = subFeeDescription;
    return data;
  }

  static List<ListSubFeeModel> fromJsonList(List list) {
    return list.map((item) => ListSubFeeModel.fromJson(item)).toList();
  }

  String userAsString() {
    return "#${this.subFeeName} ${subFeeId}";
  }

  bool isEqual(ListSubFeeModel model) {
    return this.subFeeName == model.subFeeName;
  }

  String toString() => subFeeName!;
}
