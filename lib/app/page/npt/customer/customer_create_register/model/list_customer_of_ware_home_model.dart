class ListCustomerOfWareHomeModel {
  String? maKhachHang;
  String? tenKhachhang;
  String? maKho;

  ListCustomerOfWareHomeModel(
      {this.maKhachHang, this.tenKhachhang, this.maKho});

  ListCustomerOfWareHomeModel.fromJson(Map<String, dynamic> json) {
    maKhachHang = json['maKhachHang'];
    tenKhachhang = json['tenKhachhang'];
    maKho = json['maKho'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maKhachHang'] = maKhachHang;
    data['tenKhachhang'] = tenKhachhang;
    data['maKho'] = maKho;
    return data;
  }

  static List<ListCustomerOfWareHomeModel> fromJsonList(List list) {
    return list
        .map((item) => ListCustomerOfWareHomeModel.fromJson(item))
        .toList();
  }

  String userAsString() {
    // ignore: unnecessary_this
    return "#${this.maKhachHang} ${this.tenKhachhang} ${this.maKho}";
  }

  bool isEqual(ListCustomerOfWareHomeModel model) {
    // ignore: unnecessary_this
    return this.maKhachHang == model.maKhachHang;
  }

  @override
  String toString() {
    if (maKhachHang == null) {
      return maKhachHang = "";
    }
    return maKhachHang!;
  }
}
