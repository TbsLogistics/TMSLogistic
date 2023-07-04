// ignore_for_file: unnecessary_question_mark, prefer_void_to_null

class DetailUserSercurityModel {
  String? username;
  String? role;
  Nhanvien? nhanvien;
  TaixeModel? taixe;
  KhachHangModel? khachHang;
  Null? doixe;
  int? exp;

  DetailUserSercurityModel(
      {this.username,
      this.role,
      this.nhanvien,
      this.taixe,
      this.khachHang,
      this.doixe,
      this.exp});

  DetailUserSercurityModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    role = json['role'];
    nhanvien =
        json['nhanvien'] != null ? Nhanvien.fromJson(json['nhanvien']) : null;
    taixe = json['taixe'] != null ? TaixeModel.fromJson(json["taixe"]) : null;
    khachHang = json['KhachHang'] != null
        ? KhachHangModel.fromJson(json["KhachHang"])
        : null;
    doixe = json['doixe'];
    exp = json['exp'];
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
    data['doixe'] = doixe;
    data['exp'] = exp;
    return data;
  }
}

class Nhanvien {
  String? maNv;
  String? usernameAccount;
  String? tenNV;
  String? maBoPhan;
  String? maKhuVuc;
  String? maKho;
  bool? status;
  Area? area;
  List<GateWithWareHouse>? gateWithWareHouse;

  Nhanvien(
      {this.maNv,
      this.usernameAccount,
      this.tenNV,
      this.maBoPhan,
      this.maKhuVuc,
      this.maKho,
      this.status,
      this.area,
      this.gateWithWareHouse});

  Nhanvien.fromJson(Map<String, dynamic> json) {
    maNv = json['maNv'];
    usernameAccount = json['usernameAccount'];
    tenNV = json['tenNV'];
    maBoPhan = json['maBoPhan'];
    maKhuVuc = json['maKhuVuc'];
    maKho = json['maKho'];
    status = json['status'];
    area = json['area'] != null ? Area.fromJson(json['area']) : null;
    if (json['gateWithWareHouse'] != null) {
      gateWithWareHouse = <GateWithWareHouse>[];
      json['gateWithWareHouse'].forEach((v) {
        gateWithWareHouse!.add(GateWithWareHouse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maNv'] = maNv;
    data['usernameAccount'] = usernameAccount;
    data['tenNV'] = tenNV;
    data['maBoPhan'] = maBoPhan;
    data['maKhuVuc'] = maKhuVuc;
    data['maKho'] = maKho;
    data['status'] = status;
    if (area != null) {
      data['area'] = area!.toJson();
    }
    if (gateWithWareHouse != null) {
      data['gateWithWareHouse'] =
          gateWithWareHouse!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class KhachHangModel {
  String? maKhachHang;
  String? usernameAccount;
  String? tenKhachhang;
  String? diaChi;
  String? phone;
  String? email;
  String? website;
  String? maSothue;
  String? mota;
  String? type;
  String? reType;
  bool? status;

  KhachHangModel(
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

  KhachHangModel.fromJson(Map<String, dynamic> json) {
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

class TaixeModel {
  int? maTaixe;
  String? tenTaixe;
  String? diaChi;
  String? email;
  String? cCCD;
  String? phone;
  bool? status;
  String? maKhachHang;
  String? madoixe;

  TaixeModel(
      {this.maTaixe,
      this.tenTaixe,
      this.diaChi,
      this.email,
      this.cCCD,
      this.phone,
      this.status,
      this.maKhachHang,
      this.madoixe});

  TaixeModel.fromJson(Map<String, dynamic> json) {
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

class Area {
  bool? status;
  String? maKhuVuc;
  String? tenKhuVuc;

  Area({this.status, this.maKhuVuc, this.tenKhuVuc});

  Area.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    maKhuVuc = json['maKhuVuc'];
    tenKhuVuc = json['tenKhuVuc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['maKhuVuc'] = maKhuVuc;
    data['tenKhuVuc'] = tenKhuVuc;
    return data;
  }
}

class GateWithWareHouse {
  int? maCong;
  String? tenKhoTong;
  String? maKho;
  String? tencongBV;

  GateWithWareHouse({this.maCong, this.tenKhoTong, this.maKho, this.tencongBV});

  GateWithWareHouse.fromJson(Map<String, dynamic> json) {
    maCong = json['maCong'];
    tenKhoTong = json['TenKhoTong'];
    maKho = json['maKho'];
    tencongBV = json['tencongBV'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maCong'] = maCong;
    data['TenKhoTong'] = tenKhoTong;
    data['maKho'] = maKho;
    data['tencongBV'] = tencongBV;
    return data;
  }
}
