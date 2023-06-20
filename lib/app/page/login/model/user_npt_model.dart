// ignore_for_file: prefer_void_to_null, unnecessary_question_mark

class UserNptModel {
  String? username;
  String? role;
  Null? nhanvien;
  Taixe? taixe;
  KhachHang? khachHang;
  Null? doixe;
  int? exp;

  UserNptModel(
      {this.username,
      this.role,
      this.nhanvien,
      this.taixe,
      this.khachHang,
      this.doixe,
      this.exp});

  UserNptModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    role = json['role'];
    nhanvien = json['nhanvien'];
    taixe = json['taixe'] != null ? Taixe.fromJson(json['taixe']) : null;
    khachHang = json['KhachHang'] != null
        ? KhachHang.fromJson(json['KhachHang'])
        : null;
    doixe = json['doixe'];
    exp = json['exp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['role'] = role;
    data['nhanvien'] = nhanvien;
    if (taixe != null) {
      data['taixe'] = taixe!.toJson();
    }
    if (khachHang != null) {
      data['KhachHang'] = khachHang!.toJson();
    }
    data['doixe'] = doixe;
    data['exp'] = exp;
    return data;
  }
}

class Taixe {
  int? maTaixe;
  String? tenTaixe;
  String? diaChi;
  String? email;
  String? cCCD;
  String? phone;
  bool? status;
  String? maKhachHang;
  String? madoixe;

  Taixe(
      {this.maTaixe,
      this.tenTaixe,
      this.diaChi,
      this.email,
      this.cCCD,
      this.phone,
      this.status,
      this.maKhachHang,
      this.madoixe});

  Taixe.fromJson(Map<String, dynamic> json) {
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
    data['maTaixe'] = maTaixe;
    data['tenTaixe'] = tenTaixe;
    data['diaChi'] = diaChi;
    data['email'] = email;
    data['CCCD'] = cCCD;
    data['phone'] = phone;
    data['status'] = status;
    data['maKhachHang'] = maKhachHang;
    data['madoixe'] = madoixe;
    return data;
  }
}

class KhachHang {
  String? maKhachHang;
  String? usernameAccount;
  String? tenKhachhang;
  String? diaChi;
  int? phone;
  String? email;
  String? website;
  String? maSothue;
  String? mota;
  String? type;
  String? reType;
  bool? status;

  KhachHang(
      {this.maKhachHang,
      this.usernameAccount,
      this.tenKhachhang,
      this.diaChi,
      this.phone,
      this.email,
      this.website,
      this.maSothue,
      this.mota,
      this.type,
      this.reType,
      this.status});

  KhachHang.fromJson(Map<String, dynamic> json) {
    maKhachHang = json['maKhachHang'];
    usernameAccount = json['usernameAccount'];
    tenKhachhang = json['tenKhachhang'];
    diaChi = json['diaChi'];
    phone = json['phone'];
    email = json['email'];
    website = json['website'];
    maSothue = json['maSothue'];
    mota = json['mota'];
    type = json['type'];
    reType = json['re_type'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maKhachHang'] = maKhachHang;
    data['usernameAccount'] = usernameAccount;
    data['tenKhachhang'] = tenKhachhang;
    data['diaChi'] = diaChi;
    data['phone'] = phone;
    data['email'] = email;
    data['website'] = website;
    data['maSothue'] = maSothue;
    data['mota'] = mota;
    data['type'] = type;
    data['re_type'] = reType;
    data['status'] = status;
    return data;
  }
}
