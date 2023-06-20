// ignore_for_file: unnecessary_this

class ListTypeProductModel {
  String? tenLoaiHang;
  String? chiTiet;
  String? maloaiHang;

  ListTypeProductModel({this.tenLoaiHang, this.chiTiet, this.maloaiHang});

  ListTypeProductModel.fromJson(Map<String, dynamic> json) {
    tenLoaiHang = json['tenLoaiHang'];
    chiTiet = json['chiTiet'];
    maloaiHang = json['maloaiHang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['tenLoaiHang'] = tenLoaiHang;
    data['chiTiet'] = chiTiet;
    data['maloaiHang'] = maloaiHang;
    return data;
  }

  static List<ListTypeProductModel> fromJsonList(List list) {
    return list.map((item) => ListTypeProductModel.fromJson(item)).toList();
  }

  String userAsString() {
    return "#${this.maloaiHang} ${this.tenLoaiHang}";
  }

  bool isEqual(ListTypeProductModel model) {
    return this.tenLoaiHang == model.tenLoaiHang;
  }

  @override
  String toString() {
    if (tenLoaiHang == null) {
      return tenLoaiHang = "";
    }
    return tenLoaiHang!;
  }
}
