class ListCustomerForDriverModel {
  String? maKhachHang;
  String? tenKhachhang;

  ListCustomerForDriverModel({this.maKhachHang, this.tenKhachhang});

  ListCustomerForDriverModel.fromJson(Map<String, dynamic> json) {
    maKhachHang = json['maKhachHang'];
    tenKhachhang = json['tenKhachhang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maKhachHang'] = maKhachHang;
    data['tenKhachhang'] = tenKhachhang;
    return data;
  }

  static List<ListCustomerForDriverModel> fromJsonList(List list) {
    return list
        .map((item) => ListCustomerForDriverModel.fromJson(item))
        .toList();
  }

  String userAsString() {
    // ignore: unnecessary_this
    return "#${this.maKhachHang} ${this.tenKhachhang}";
  }

  bool isEqual(ListCustomerForDriverModel model) {
    // ignore: unnecessary_this
    return this.tenKhachhang == model.tenKhachhang;
  }

  @override
  String toString() {
    if (tenKhachhang == null) {
      return tenKhachhang = "";
    }
    return tenKhachhang!;
  }
}
