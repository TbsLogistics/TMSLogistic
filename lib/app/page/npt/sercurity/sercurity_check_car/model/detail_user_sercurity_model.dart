class DetailUserSercurityModel {
  String? username;
  String? role;
  Nhanvien? nhanvien;
  Null? taixe;
  Null? khachHang;
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
    taixe = json['taixe'];
    khachHang = json['KhachHang'];
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
    data['taixe'] = taixe;
    data['KhachHang'] = khachHang;
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
