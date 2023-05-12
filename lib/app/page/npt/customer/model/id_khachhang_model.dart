class IdKhachhangModel {
  String? makhachhang;

  IdKhachhangModel({this.makhachhang});

  IdKhachhangModel.fromJson(Map<String, dynamic> json) {
    makhachhang = json['makhachhang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['makhachhang'] = makhachhang;
    return data;
  }
}
