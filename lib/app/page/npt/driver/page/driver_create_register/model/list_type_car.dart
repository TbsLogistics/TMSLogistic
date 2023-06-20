// ignore_for_file: unnecessary_this

class ListTypeCarModel {
  String? maLoaiXe;
  String? tenLoaiXe;

  ListTypeCarModel({this.maLoaiXe, this.tenLoaiXe});

  ListTypeCarModel.fromJson(Map<String, dynamic> json) {
    maLoaiXe = json['maLoaiXe'];
    tenLoaiXe = json['tenLoaiXe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maLoaiXe'] = maLoaiXe;
    data['tenLoaiXe'] = tenLoaiXe;
    return data;
  }

  static List<ListTypeCarModel> fromJsonList(List list) {
    return list.map((item) => ListTypeCarModel.fromJson(item)).toList();
  }

  String userAsString() {
    return "${this.maLoaiXe} ${this.tenLoaiXe}";
  }

  bool isEqual(ListTypeCarModel model) {
    return this.tenLoaiXe == model.tenLoaiXe;
  }

  @override
  String toString() {
    if (tenLoaiXe == null) {
      return tenLoaiXe = "";
    }
    return tenLoaiXe!;
  }
}
