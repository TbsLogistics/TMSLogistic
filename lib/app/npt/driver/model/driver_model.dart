class DriverModel {
  int? maTaixe;
  String? madoixe;
  String? usernameAccount;
  String? email;
  bool? status;
  String? maKhachHang;
  String? tenTaixe;
  String? diaChi;
  String? phone;
  String? cCCD;

  DriverModel(
      {this.maTaixe,
      this.madoixe,
      this.usernameAccount,
      this.email,
      this.status,
      this.maKhachHang,
      this.tenTaixe,
      this.diaChi,
      this.phone,
      this.cCCD});

  DriverModel.fromJson(Map<String, dynamic> json) {
    maTaixe = json['maTaixe'];
    madoixe = json['madoixe'];
    usernameAccount = json['usernameAccount'];
    email = json['email'];
    status = json['status'];
    maKhachHang = json['maKhachHang'];
    tenTaixe = json['tenTaixe'];
    diaChi = json['diaChi'];
    phone = json['phone'];
    cCCD = json['CCCD'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maTaixe'] = maTaixe;
    data['madoixe'] = madoixe;
    data['usernameAccount'] = usernameAccount;
    data['email'] = email;
    data['status'] = status;
    data['maKhachHang'] = maKhachHang;
    data['tenTaixe'] = tenTaixe;
    data['diaChi'] = diaChi;
    data['phone'] = phone;
    data['CCCD'] = cCCD;
    return data;
  }
}
