// ignore_for_file: unnecessary_this

class ListWareHomeModel {
  String? maKho;
  String? maKhuVuc;
  String? tenKho;
  bool? status;

  ListWareHomeModel({this.maKho, this.maKhuVuc, this.tenKho, this.status});

  ListWareHomeModel.fromJson(Map<String, dynamic> json) {
    maKho = json['maKho'];
    maKhuVuc = json['maKhuVuc'];
    tenKho = json['tenKho'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maKho'] = maKho;
    data['maKhuVuc'] = maKhuVuc;
    data['tenKho'] = tenKho;
    data['status'] = status;
    return data;
  }

  static List<ListWareHomeModel> fromJsonList(List list) {
    return list.map((item) => ListWareHomeModel.fromJson(item)).toList();
  }

  String userAsString() {
    return "#${this.maKho} ${this.maKhuVuc} ${this.tenKho}";
  }

  bool isEqual(ListWareHomeModel model) {
    return this.tenKho == model.tenKho;
  }

  @override
  String toString() {
    if (tenKho == null) {
      return tenKho = "";
    }
    return tenKho!;
  }
}
