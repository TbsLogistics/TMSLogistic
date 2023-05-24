class DetailsDriverModel {
  int? maTaixe;
  String? tenTaixe;
  String? diaChi;
  String? phone;
  String? cCCD;
  String? maKhachHang;
  String? madoixe;
  String? usernameAccount;
  String? email;
  bool? status;
  bool? isdelete;

  DetailsDriverModel(
      {this.maTaixe,
      this.tenTaixe,
      this.diaChi,
      this.phone,
      this.cCCD,
      this.maKhachHang,
      this.madoixe,
      this.usernameAccount,
      this.email,
      this.status,
      this.isdelete});

  DetailsDriverModel.fromJson(Map<String, dynamic> json) {
    maTaixe = json['maTaixe'];
    tenTaixe = json['tenTaixe'];
    diaChi = json['diaChi'];
    phone = json['phone'];
    cCCD = json['CCCD'];
    maKhachHang = json['maKhachHang'];
    madoixe = json['madoixe'];
    usernameAccount = json['usernameAccount'];
    email = json['email'];
    status = json['status'];
    isdelete = json['isdelete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maTaixe'] = maTaixe;
    data['tenTaixe'] = tenTaixe;
    data['diaChi'] = diaChi;
    data['phone'] = phone;
    data['CCCD'] = cCCD;
    data['maKhachHang'] = maKhachHang;
    data['madoixe'] = madoixe;
    data['usernameAccount'] = usernameAccount;
    data['email'] = email;
    data['status'] = status;
    data['isdelete'] = isdelete;
    return data;
  }
}
