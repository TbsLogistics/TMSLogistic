// ignore_for_file: unnecessary_this

class ListDriverByCustomerModel {
  int? maTaixe;
  String? tenTaixe;
  String? diaChi;
  String? email;
  String? cCCD;
  String? phone;
  bool? status;
  String? maKhachHang;
  String? madoixe;

  ListDriverByCustomerModel(
      {this.maTaixe,
      this.tenTaixe,
      this.diaChi,
      this.email,
      this.cCCD,
      this.phone,
      this.status,
      this.maKhachHang,
      this.madoixe});

  ListDriverByCustomerModel.fromJson(Map<String, dynamic> json) {
    maTaixe = json['maTaixe'];
    tenTaixe = json['tenTaixe'];
    diaChi = json['diaChi'];
    email = json['email'];
    cCCD = json['CCCD'];
    phone = json['phone'];
    status = json['status'];
    maKhachHang = json['maKhachHang'];
    madoixe = json['madoixe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maTaixe'] = this.maTaixe;
    data['tenTaixe'] = this.tenTaixe;
    data['diaChi'] = this.diaChi;
    data['email'] = this.email;
    data['CCCD'] = this.cCCD;
    data['phone'] = this.phone;
    data['status'] = this.status;
    data['maKhachHang'] = this.maKhachHang;
    data['madoixe'] = this.madoixe;
    return data;
  }

  static List<ListDriverByCustomerModel> fromJsonList(List list) {
    return list
        .map((item) => ListDriverByCustomerModel.fromJson(item))
        .toList();
  }

  String userAsString() {
    return "#${this.maTaixe} ${this.tenTaixe}";
  }

  bool isEqual(ListDriverByCustomerModel model) {
    return this.maTaixe == model.maTaixe;
  }

  @override
  String toString() => tenTaixe!;
}
