class CustomerOfWareHomeModel {
  String? maKhachHang;
  String? tenKhachhang;
  String? maKho;

  CustomerOfWareHomeModel({this.maKhachHang, this.tenKhachhang, this.maKho});

  CustomerOfWareHomeModel.fromJson(Map<String, dynamic> json) {
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
}
