import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_finished/model/customer_list_registed_model.dart';

class ListDangTaiModel {
  String? socont1;
  String? cont1seal1;
  String? cont1seal2;
  String? socont2;
  String? cont2seal1;
  String? cont2seal2;
  int? maPhieuvao;
  KhachhangRe? khachhangRe;
  MaTaixe? maTaixe;
  String? giodukien;
  Kho? kho;
  Loaixe? loaixe;
  bool? trangthaihang;
  bool? trangthaikhoa;
  bool? trangthaihang1;
  bool? trangthaikhoa1;
  LoaiCont? loaiCont;
  LoaiCont? loaiCont1;
  MaTrongTai? maTrongTai;
  String? giovao;
  String? soxe;

  ListDangTaiModel(
      {this.socont1,
      this.cont1seal1,
      this.cont1seal2,
      this.socont2,
      this.cont2seal1,
      this.cont2seal2,
      this.maPhieuvao,
      this.khachhangRe,
      this.maTaixe,
      this.giodukien,
      this.kho,
      this.loaixe,
      this.trangthaihang,
      this.trangthaikhoa,
      this.trangthaihang1,
      this.trangthaikhoa1,
      this.loaiCont,
      this.loaiCont1,
      this.maTrongTai,
      this.giovao,
      this.soxe});

  ListDangTaiModel.fromJson(Map<String, dynamic> json) {
    socont1 = json['socont1'];
    cont1seal1 = json['cont1seal1'];
    cont1seal2 = json['cont1seal2'];
    socont2 = json['socont2'];
    cont2seal1 = json['cont2seal1'];
    cont2seal2 = json['cont2seal2'];
    maPhieuvao = json['maPhieuvao'];
    khachhangRe = json['khachhang_re'] != null
        ? KhachhangRe.fromJson(json['khachhang_re'])
        : null;
    maTaixe =
        json['maTaixe'] != null ? MaTaixe.fromJson(json['maTaixe']) : null;
    giodukien = json['giodukien'];
    kho = json['kho'] != null ? Kho.fromJson(json['kho']) : null;
    loaixe = json['loaixe'] != null ? Loaixe.fromJson(json['loaixe']) : null;
    trangthaihang = json['trangthaihang'];
    trangthaikhoa = json['trangthaikhoa'];
    trangthaihang1 = json['trangthaihang1'];
    trangthaikhoa1 = json['trangthaikhoa1'];
    loaiCont =
        json['loaiCont'] != null ? LoaiCont.fromJson(json['loaiCont']) : null;
    loaiCont1 =
        json['loaiCont1'] != null ? LoaiCont.fromJson(json['loaiCont1']) : null;
    maTrongTai = json['maTrongTai'] != null
        ? MaTrongTai.fromJson(json["maTrongTai"])
        : null;
    giovao = json['giovao'];
    soxe = json['soxe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['socont1'] = socont1;
    data['cont1seal1'] = cont1seal1;
    data['cont1seal2'] = cont1seal2;
    data['socont2'] = socont2;
    data['cont2seal1'] = cont2seal1;
    data['cont2seal2'] = cont2seal2;
    data['maPhieuvao'] = maPhieuvao;
    if (khachhangRe != null) {
      data['khachhang_re'] = khachhangRe!.toJson();
    }
    if (maTaixe != null) {
      data['maTaixe'] = maTaixe!.toJson();
    }
    data['giodukien'] = giodukien;
    if (kho != null) {
      data['kho'] = kho!.toJson();
    }
    if (loaixe != null) {
      data['loaixe'] = loaixe!.toJson();
    }
    data['trangthaihang'] = trangthaihang;
    data['trangthaikhoa'] = trangthaikhoa;
    data['trangthaihang1'] = trangthaihang1;
    data['trangthaikhoa1'] = trangthaikhoa1;
    if (loaiCont != null) {
      data['loaiCont'] = loaiCont!.toJson();
    }
    if (loaiCont1 != null) {
      data['loaiCont1'] = loaiCont1!.toJson();
    }
    if (maTrongTai != null) {
      data['maTrongTai'] = maTrongTai!.toJson();
    }

    data['giovao'] = giovao;
    data['soxe'] = soxe;
    return data;
  }
}

class KhachhangRe {
  String? diaChi;
  String? maKhachHang;
  String? email;
  String? maSothue;
  String? createby;
  String? modifiedBy;
  bool? isDeleted;
  String? type;
  String? usernameAccount;
  String? tenKhachhang;
  String? phone;
  String? website;
  String? mota;
  String? createtime;
  String? modifiedDate;
  String? status;

  KhachhangRe(
      {this.diaChi,
      this.maKhachHang,
      this.email,
      this.maSothue,
      this.createby,
      this.modifiedBy,
      this.isDeleted,
      this.type,
      this.usernameAccount,
      this.tenKhachhang,
      this.phone,
      this.website,
      this.mota,
      this.createtime,
      this.modifiedDate,
      this.status});

  KhachhangRe.fromJson(Map<String, dynamic> json) {
    diaChi = json['diaChi'];
    maKhachHang = json['maKhachHang'];
    email = json['email'];
    maSothue = json['maSothue'];
    createby = json['createby'];
    modifiedBy = json['ModifiedBy'];
    isDeleted = json['IsDeleted'];
    type = json['type'];
    usernameAccount = json['usernameAccount'];
    tenKhachhang = json['tenKhachhang'];
    phone = json['phone'];
    website = json['website'];
    mota = json['mota'];
    createtime = json['createtime'];
    modifiedDate = json['ModifiedDate'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['diaChi'] = diaChi;
    data['maKhachHang'] = maKhachHang;
    data['email'] = email;
    data['maSothue'] = maSothue;
    data['createby'] = createby;
    data['ModifiedBy'] = modifiedBy;
    data['IsDeleted'] = isDeleted;
    data['type'] = type;
    data['usernameAccount'] = usernameAccount;
    data['tenKhachhang'] = tenKhachhang;
    data['phone'] = phone;
    data['website'] = website;
    data['mota'] = mota;
    data['createtime'] = createtime;
    data['ModifiedDate'] = modifiedDate;
    data['status'] = status;
    return data;
  }
}

class MaTaixe {
  int? maTaixe;
  String? tenTaixe;
  String? usernameAccount;
  String? email;
  bool? status;
  bool? isdelete;
  String? maKhachHang;
  String? madoixe;
  String? diaChi;
  String? phone;
  String? cCCD;

  MaTaixe(
      {this.maTaixe,
      this.tenTaixe,
      this.usernameAccount,
      this.email,
      this.status,
      this.isdelete,
      this.maKhachHang,
      this.madoixe,
      this.diaChi,
      this.phone,
      this.cCCD});

  MaTaixe.fromJson(Map<String, dynamic> json) {
    maTaixe = json['maTaixe'];
    tenTaixe = json['tenTaixe'];
    usernameAccount = json['usernameAccount'];
    email = json['email'];
    status = json['status'];
    isdelete = json['isdelete'];
    maKhachHang = json['maKhachHang'];
    madoixe = json['madoixe'];
    diaChi = json['diaChi'];
    phone = json['phone'];
    cCCD = json['CCCD'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maTaixe'] = maTaixe;
    data['tenTaixe'] = tenTaixe;
    data['usernameAccount'] = usernameAccount;
    data['email'] = email;
    data['status'] = status;
    data['isdelete'] = isdelete;
    data['maKhachHang'] = maKhachHang;
    data['madoixe'] = madoixe;
    data['diaChi'] = diaChi;
    data['phone'] = phone;
    data['CCCD'] = cCCD;
    return data;
  }
}

class Kho {
  bool? status;
  String? tenKho;
  String? maKho;
  String? maKhuVuc;

  Kho({this.status, this.tenKho, this.maKho, this.maKhuVuc});

  Kho.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    tenKho = json['tenKho'];
    maKho = json['maKho'];
    maKhuVuc = json['maKhuVuc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['tenKho'] = tenKho;
    data['maKho'] = maKho;
    data['maKhuVuc'] = maKhuVuc;
    return data;
  }
}

class Loaixe {
  int? stt;
  String? maLoaiXe;
  String? tenLoaiXe;

  Loaixe({this.stt, this.maLoaiXe, this.tenLoaiXe});

  Loaixe.fromJson(Map<String, dynamic> json) {
    stt = json['stt'];
    maLoaiXe = json['maLoaiXe'];
    tenLoaiXe = json['tenLoaiXe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stt'] = stt;
    data['maLoaiXe'] = maLoaiXe;
    data['tenLoaiXe'] = tenLoaiXe;
    return data;
  }
}

class LoaiCont {
  String? typeContname;
  bool? status;
  String? typeContCode;

  LoaiCont({this.typeContname, this.status, this.typeContCode});

  LoaiCont.fromJson(Map<String, dynamic> json) {
    typeContname = json['typeContname'];
    status = json['status'];
    typeContCode = json['typeContCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['typeContname'] = typeContname;
    data['status'] = status;
    data['typeContCode'] = typeContCode;
    return data;
  }
}

class Data {
  String? socont1;
  String? cont1seal1;
  String? cont1seal2;
  String? socont2;
  String? cont2seal1;
  String? cont2seal2;
  int? maPhieuvao;
  KhachhangRe? khachhangRe;
  MaTaixe? maTaixe;
  String? giodukien;
  Kho? kho;
  Loaixe? loaixe;
  bool? trangthaihang;
  bool? trangthaikhoa;
  bool? trangthaihang1;
  bool? trangthaikhoa1;
  LoaiCont? loaiCont;
  LoaiCont? loaiCont1;
  String? maTrongTai;
  String? giovao;
  String? soxe;

  Data(
      {this.socont1,
      this.cont1seal1,
      this.cont1seal2,
      this.socont2,
      this.cont2seal1,
      this.cont2seal2,
      this.maPhieuvao,
      this.khachhangRe,
      this.maTaixe,
      this.giodukien,
      this.kho,
      this.loaixe,
      this.trangthaihang,
      this.trangthaikhoa,
      this.trangthaihang1,
      this.trangthaikhoa1,
      this.loaiCont,
      this.loaiCont1,
      this.maTrongTai,
      this.giovao,
      this.soxe});

  Data.fromJson(Map<String, dynamic> json) {
    socont1 = json['socont1'];
    cont1seal1 = json['cont1seal1'];
    cont1seal2 = json['cont1seal2'];
    socont2 = json['socont2'];
    cont2seal1 = json['cont2seal1'];
    cont2seal2 = json['cont2seal2'];
    maPhieuvao = json['maPhieuvao'];
    khachhangRe = json['khachhang_re'] != null
        ? KhachhangRe.fromJson(json['khachhang_re'])
        : null;
    maTaixe =
        json['maTaixe'] != null ? MaTaixe.fromJson(json['maTaixe']) : null;
    giodukien = json['giodukien'];
    kho = json['kho'] != null ? Kho.fromJson(json['kho']) : null;
    loaixe = json['loaixe'] != null ? Loaixe.fromJson(json['loaixe']) : null;
    trangthaihang = json['trangthaihang'];
    trangthaikhoa = json['trangthaikhoa'];
    trangthaihang1 = json['trangthaihang1'];
    trangthaikhoa1 = json['trangthaikhoa1'];
    loaiCont =
        json['loaiCont'] != null ? LoaiCont.fromJson(json['loaiCont']) : null;
    loaiCont1 =
        json['loaiCont1'] != null ? LoaiCont.fromJson(json['loaiCont1']) : null;
    maTrongTai = json['maTrongTai'];
    giovao = json['giovao'];
    soxe = json['soxe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['socont1'] = socont1;
    data['cont1seal1'] = cont1seal1;
    data['cont1seal2'] = cont1seal2;
    data['socont2'] = socont2;
    data['cont2seal1'] = cont2seal1;
    data['cont2seal2'] = cont2seal2;
    data['maPhieuvao'] = maPhieuvao;
    if (khachhangRe != null) {
      data['khachhang_re'] = khachhangRe!.toJson();
    }
    if (maTaixe != null) {
      data['maTaixe'] = maTaixe!.toJson();
    }
    data['giodukien'] = giodukien;
    if (kho != null) {
      data['kho'] = kho!.toJson();
    }
    if (loaixe != null) {
      data['loaixe'] = loaixe!.toJson();
    }
    data['trangthaihang'] = trangthaihang;
    data['trangthaikhoa'] = trangthaikhoa;
    data['trangthaihang1'] = trangthaihang1;
    data['trangthaikhoa1'] = trangthaikhoa1;
    if (loaiCont != null) {
      data['loaiCont'] = loaiCont!.toJson();
    }
    if (loaiCont1 != null) {
      data['loaiCont1'] = loaiCont1!.toJson();
    }
    data['maTrongTai'] = maTrongTai;
    data['giovao'] = giovao;
    data['soxe'] = soxe;
    return data;
  }
}
