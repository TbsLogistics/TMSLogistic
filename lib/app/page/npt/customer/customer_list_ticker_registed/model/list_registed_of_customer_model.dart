class ListRegisterDriverOfCustomerModel {
  KhuVuc? khuVuc;
  List<CapCong>? capcongs;
  int? maPhieuvao;
  KhachhangRe? khachhangRe;
  TaixeRe? taixeRe;
  LoaixeRe? loaixeRe;
  String? giovao;
  Phieuvao? phieuvao;
  Phieura? phieura;
  String? giora;
  bool? status;
  String? hinhanhminhhoa;
  List<Trackingtime>? trackingtime;
  Loaihang? loaihang;

  ListRegisterDriverOfCustomerModel(
      {this.khuVuc,
      this.capcongs,
      this.maPhieuvao,
      this.khachhangRe,
      this.taixeRe,
      this.loaixeRe,
      this.giovao,
      this.phieuvao,
      this.phieura,
      this.giora,
      this.status,
      this.hinhanhminhhoa,
      this.trackingtime,
      this.loaihang});

  ListRegisterDriverOfCustomerModel.fromJson(Map<String, dynamic> json) {
    khuVuc = json['khuVuc'] != null ? KhuVuc.fromJson(json['khuVuc']) : null;
    if (json['capcongs'] != null) {
      capcongs = <CapCong>[];
      json['capcongs'].forEach((v) {
        capcongs!.add(CapCong.fromJson(v));
      });
    }
    maPhieuvao = json['maPhieuvao'];
    khachhangRe = json['khachhang_re'] != null
        ? KhachhangRe.fromJson(json['khachhang_re'])
        : null;
    taixeRe =
        json['taixe_re'] != null ? TaixeRe.fromJson(json['taixe_re']) : null;
    loaixeRe =
        json['loaixe_re'] != null ? LoaixeRe.fromJson(json['loaixe_re']) : null;
    giovao = json['giovao'];
    phieuvao =
        json['phieuvao'] != null ? Phieuvao.fromJson(json['phieuvao']) : null;
    phieura =
        json['phieura'] != null ? Phieura.fromJson(json['phieura']) : null;
    giora = json['giora'];
    status = json['status'];
    hinhanhminhhoa = json['hinhanhminhhoa'];
    if (json['trackingtime'] != null) {
      trackingtime = <Trackingtime>[];
      json['trackingtime'].forEach((v) {
        trackingtime!.add(Trackingtime.fromJson(v));
      });
    }
    loaihang =
        json['loaihang'] != null ? Loaihang.fromJson(json['loaihang']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (khuVuc != null) {
      data['khuVuc'] = khuVuc!.toJson();
    }
    if (capcongs != null) {
      data['capcongs'] = capcongs!.map((v) => v.toJson()).toList();
    }
    data['maPhieuvao'] = maPhieuvao;
    if (khachhangRe != null) {
      data['khachhang_re'] = khachhangRe!.toJson();
    }
    if (taixeRe != null) {
      data['taixe_re'] = taixeRe!.toJson();
    }
    if (loaixeRe != null) {
      data['loaixe_re'] = loaixeRe!.toJson();
    }
    data['giovao'] = giovao;
    if (phieuvao != null) {
      data['phieuvao'] = phieuvao!.toJson();
    }
    if (phieura != null) {
      data['phieura'] = phieura!.toJson();
    }
    data['giora'] = giora;
    data['status'] = status;
    data['hinhanhminhhoa'] = hinhanhminhhoa;
    if (trackingtime != null) {
      data['trackingtime'] = trackingtime!.map((v) => v.toJson()).toList();
    }
    if (loaihang != null) {
      data['loaihang'] = loaihang!.toJson();
    }
    return data;
  }
}

class CapCong {
  int? capCong;

  CapCong({this.capCong});

  CapCong.fromJson(Map<String, dynamic> json) {
    capCong = json['capCong'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['capCong'] = capCong;
    return data;
  }
}

class KhuVuc {
  String? tenKhuVuc;
  String? maKhuVuc;

  KhuVuc({this.tenKhuVuc, this.maKhuVuc});

  KhuVuc.fromJson(Map<String, dynamic> json) {
    tenKhuVuc = json['tenKhuVuc'];
    maKhuVuc = json['maKhuVuc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tenKhuVuc'] = tenKhuVuc;
    data['maKhuVuc'] = maKhuVuc;
    return data;
  }
}

class KhachhangRe {
  String? maKhachHang;
  String? tenKhachhang;
  String? type;

  KhachhangRe({this.maKhachHang, this.tenKhachhang, this.type});

  KhachhangRe.fromJson(Map<String, dynamic> json) {
    maKhachHang = json['maKhachHang'];
    tenKhachhang = json['tenKhachhang'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maKhachHang'] = maKhachHang;
    data['tenKhachhang'] = tenKhachhang;
    data['type'] = type;
    return data;
  }
}

class TaixeRe {
  int? maTaixe;
  String? tenTaixe;
  String? diaChi;
  String? email;
  String? cCCD;
  String? phone;
  bool? status;

  TaixeRe(
      {this.maTaixe,
      this.tenTaixe,
      this.diaChi,
      this.email,
      this.cCCD,
      this.phone,
      this.status});

  TaixeRe.fromJson(Map<String, dynamic> json) {
    maTaixe = json['maTaixe'];
    tenTaixe = json['tenTaixe'];
    diaChi = json['diaChi'];
    email = json['email'];
    cCCD = json['CCCD'];
    phone = json['phone'];
    status = json['status'];
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
    return data;
  }
}

class LoaixeRe {
  String? maLoaiXe;
  String? tenLoaiXe;

  LoaixeRe({this.maLoaiXe, this.tenLoaiXe});

  LoaixeRe.fromJson(Map<String, dynamic> json) {
    maLoaiXe = json['maLoaiXe'];
    tenLoaiXe = json['tenLoaiXe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maLoaiXe'] = maLoaiXe;
    data['tenLoaiXe'] = tenLoaiXe;
    return data;
  }
}

class Phieuvao {
  String? giodukien;
  String? soxe;
  Kho? kho;
  String? loaiCont;
  String? loaiCont1;
  String? maTrongTai;
  String? socont1;
  String? cont1seal1;
  String? cont1seal2;
  double? soKien;
  double? sokhoi;
  String? soBook;
  String? soReMooc;
  bool? trangthaihang;
  bool? trangthaikhoa;
  String? socont2;
  String? cont2seal1;
  String? cont2seal2;
  double? sokien1;
  double? sokhoi1;
  String? soBook1;
  bool? trangthaihang1;
  bool? trangthaikhoa1;

  Phieuvao(
      {this.giodukien,
      this.soxe,
      this.kho,
      this.loaiCont,
      this.loaiCont1,
      this.maTrongTai,
      this.socont1,
      this.cont1seal1,
      this.cont1seal2,
      this.soKien,
      this.sokhoi,
      this.soBook,
      this.soReMooc,
      this.trangthaihang,
      this.trangthaikhoa,
      this.socont2,
      this.cont2seal1,
      this.cont2seal2,
      this.sokien1,
      this.sokhoi1,
      this.soBook1,
      this.trangthaihang1,
      this.trangthaikhoa1});

  Phieuvao.fromJson(Map<String, dynamic> json) {
    giodukien = json['giodukien'];
    soxe = json['soxe'];
    kho = json['kho'] != null ? Kho.fromJson(json['kho']) : null;
    loaiCont = json['loaiCont'];
    loaiCont1 = json['loaiCont1'];
    maTrongTai = json['maTrongTai'];
    socont1 = json['socont1'];
    cont1seal1 = json['cont1seal1'];
    cont1seal2 = json['cont1seal2'];
    soKien = json['SoKien'];
    sokhoi = json['sokhoi'];
    soBook = json['soBook'];
    soReMooc = json['soReMooc'];
    trangthaihang = json['trangthaihang'];
    trangthaikhoa = json['trangthaikhoa'];
    socont2 = json['socont2'];
    cont2seal1 = json['cont2seal1'];
    cont2seal2 = json['cont2seal2'];
    sokien1 = json['Sokien1'];
    sokhoi1 = json['sokhoi1'];
    soBook1 = json['soBook1'];
    trangthaihang1 = json['trangthaihang1'];
    trangthaikhoa1 = json['trangthaikhoa1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['giodukien'] = giodukien;
    data['soxe'] = soxe;
    if (kho != null) {
      data['kho'] = kho!.toJson();
    }
    data['loaiCont'] = loaiCont;
    data['loaiCont1'] = loaiCont1;
    data['maTrongTai'] = maTrongTai;
    data['socont1'] = socont1;
    data['cont1seal1'] = cont1seal1;
    data['cont1seal2'] = cont1seal2;
    data['SoKien'] = soKien;
    data['sokhoi'] = sokhoi;
    data['soBook'] = soBook;
    data['soReMooc'] = soReMooc;
    data['trangthaihang'] = trangthaihang;
    data['trangthaikhoa'] = trangthaikhoa;
    data['socont2'] = socont2;
    data['cont2seal1'] = cont2seal1;
    data['cont2seal2'] = cont2seal2;
    data['Sokien1'] = sokien1;
    data['sokhoi1'] = sokhoi1;
    data['soBook1'] = soBook1;
    data['trangthaihang1'] = trangthaihang1;
    data['trangthaikhoa1'] = trangthaikhoa1;
    return data;
  }
}

class Kho {
  String? maKho;
  String? tenKho;

  Kho({this.maKho, this.tenKho});

  Kho.fromJson(Map<String, dynamic> json) {
    maKho = json['maKho'];
    tenKho = json['tenKho'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maKho'] = maKho;
    data['tenKho'] = tenKho;
    return data;
  }
}

class Phieura {
  String? soXeRa;
  String? taiXeRa;
  String? soremoocra;
  String? contRa1;
  String? contRa1seal1;
  String? contRa1seal2;
  bool? trangthaihangra;
  bool? trangthaikhoara;
  String? contRa2;
  String? contRa2seal1;
  String? contRa2seal2;
  bool? trangthaihangra1;
  bool? trangthaikhoara1;

  Phieura(
      {this.soXeRa,
      this.taiXeRa,
      this.soremoocra,
      this.contRa1,
      this.contRa1seal1,
      this.contRa1seal2,
      this.trangthaihangra,
      this.trangthaikhoara,
      this.contRa2,
      this.contRa2seal1,
      this.contRa2seal2,
      this.trangthaihangra1,
      this.trangthaikhoara1});

  Phieura.fromJson(Map<String, dynamic> json) {
    soXeRa = json['soXeRa'];
    taiXeRa = json['taiXeRa'];
    soremoocra = json['soremoocra'];
    contRa1 = json['contRa1'];
    contRa1seal1 = json['contRa1seal1'];
    contRa1seal2 = json['contRa1seal2'];
    trangthaihangra = json['trangthaihangra'];
    trangthaikhoara = json['trangthaikhoara'];
    contRa2 = json['contRa2'];
    contRa2seal1 = json['contRa2seal1'];
    contRa2seal2 = json['contRa2seal2'];
    trangthaihangra1 = json['trangthaihangra1'];
    trangthaikhoara1 = json['trangthaikhoara1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['soXeRa'] = soXeRa;
    data['taiXeRa'] = taiXeRa;
    data['soremoocra'] = soremoocra;
    data['contRa1'] = contRa1;
    data['contRa1seal1'] = contRa1seal1;
    data['contRa1seal2'] = contRa1seal2;
    data['trangthaihangra'] = trangthaihangra;
    data['trangthaikhoara'] = trangthaikhoara;
    data['contRa2'] = contRa2;
    data['contRa2seal1'] = contRa2seal1;
    data['contRa2seal2'] = contRa2seal2;
    data['trangthaihangra1'] = trangthaihangra1;
    data['trangthaikhoara1'] = trangthaikhoara1;
    return data;
  }
}

class Trackingtime {
  String? thoigian;
  Statustracking? statustracking;

  Trackingtime({this.thoigian, this.statustracking});

  Trackingtime.fromJson(Map<String, dynamic> json) {
    thoigian = json['thoigian'];
    statustracking = json['Statustracking'] != null
        ? Statustracking.fromJson(json['Statustracking'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['thoigian'] = thoigian;
    if (statustracking != null) {
      data['Statustracking'] = statustracking!.toJson();
    }
    return data;
  }
}

class Statustracking {
  String? name;
  String? matrangthai;
  String? lv;

  Statustracking({this.name, this.matrangthai, this.lv});

  Statustracking.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    matrangthai = json['matrangthai'];
    lv = json['lv'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['matrangthai'] = matrangthai;
    data['lv'] = lv;
    return data;
  }
}

class Loaihang {
  String? tenLoaiHang;
  String? chiTiet;
  String? maloaiHang;

  Loaihang({this.tenLoaiHang, this.chiTiet, this.maloaiHang});

  Loaihang.fromJson(Map<String, dynamic> json) {
    tenLoaiHang = json['tenLoaiHang'];
    chiTiet = json['chiTiet'];
    maloaiHang = json['maloaiHang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tenLoaiHang'] = tenLoaiHang;
    data['chiTiet'] = chiTiet;
    data['maloaiHang'] = maloaiHang;
    return data;
  }
}
