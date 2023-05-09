class LoginUserNptModel {
  String? accessToken;
  String? tokenType;
  Data? data;

  LoginUserNptModel({this.accessToken, this.tokenType, this.data});

  LoginUserNptModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['token_type'] = tokenType;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? username;
  String? role;
  Nhanvien? nhanvien;
  Taixe? taixe;
  KhachHang? khachHang;
  Doixe? doixe;

  Data(
      {this.username,
      this.role,
      this.nhanvien,
      this.taixe,
      this.khachHang,
      this.doixe});

  Data.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    role = json['role'];
    nhanvien =
        json['nhanvien'] != null ? Nhanvien.fromJson(json['nhanvien']) : null;
    taixe = json['taixe'] != null ? Taixe.fromJson(json['taixe']) : null;
    khachHang = json['KhachHang'] != null
        ? KhachHang.fromJson(json['KhachHang'])
        : null;
    doixe = json['doixe'] != null ? Doixe.fromJson(json['doixe']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['role'] = role;
    if (nhanvien != null) {
      data['nhanvien'] = nhanvien!.toJson();
    }
    if (taixe != null) {
      data['taixe'] = taixe!.toJson();
    }
    if (khachHang != null) {
      data['KhachHang'] = khachHang!.toJson();
    }
    if (doixe != null) {
      data['doixe'] = doixe!.toJson();
    }
    return data;
  }
}

class Nhanvien {
  String? maNv;
  String? usernameAccount;
  String? tenNV;
  String? maBoPhan;
  bool? status;

  Nhanvien(
      {this.maNv,
      this.usernameAccount,
      this.tenNV,
      this.maBoPhan,
      this.status});

  Nhanvien.fromJson(Map<String, dynamic> json) {
    maNv = json['maNv'];
    usernameAccount = json['usernameAccount'];
    tenNV = json['tenNV'];
    maBoPhan = json['maBoPhan'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maNv'] = maNv;
    data['usernameAccount'] = usernameAccount;
    data['tenNV'] = tenNV;
    data['maBoPhan'] = maBoPhan;
    data['status'] = status;
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
  String? tenKhachhang;
  String? diaChi;
  String? phone;
  String? email;
  String? website;
  String? maSothue;
  String? mota;
  bool? status;

  KhachHang(
      {this.maKhachHang,
      this.tenKhachhang,
      this.diaChi,
      this.phone,
      this.email,
      this.website,
      this.maSothue,
      this.mota,
      this.status});

  KhachHang.fromJson(Map<String, dynamic> json) {
    maKhachHang = json['maKhachHang'];
    tenKhachhang = json['tenKhachhang'];
    diaChi = json['diaChi'];
    phone = json['phone'];
    email = json['email'];
    website = json['website'];
    maSothue = json['maSothue'];
    mota = json['mota'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maKhachHang'] = maKhachHang;
    data['tenKhachhang'] = tenKhachhang;
    data['diaChi'] = diaChi;
    data['phone'] = phone;
    data['email'] = email;
    data['website'] = website;
    data['maSothue'] = maSothue;
    data['mota'] = mota;
    data['status'] = status;
    return data;
  }
}

class Doixe {
  String? madoixe;
  String? tendoixe;
  String? diachi;
  String? email;
  String? phone;
  bool? status;

  Doixe(
      {this.madoixe,
      this.tendoixe,
      this.diachi,
      this.email,
      this.phone,
      this.status});

  Doixe.fromJson(Map<String, dynamic> json) {
    madoixe = json['madoixe'];
    tendoixe = json['tendoixe'];
    diachi = json['diachi'];
    email = json['email'];
    phone = json['phone'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['madoixe'] = madoixe;
    data['tendoixe'] = tendoixe;
    data['diachi'] = diachi;
    data['email'] = email;
    data['phone'] = phone;
    data['status'] = status;
    return data;
  }
}
