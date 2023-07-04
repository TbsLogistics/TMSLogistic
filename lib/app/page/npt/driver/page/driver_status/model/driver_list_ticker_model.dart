// ignore_for_file: prefer_void_to_null, unnecessary_question_mark

class DriverListTickerModel {
  String? pdriverInOutWarehouseCode;
  String? giodukien;
  String? giovao;
  String? soxe;
  String? soReMooc;
  MaKhachHang? maKhachHang;
  MaDoixe? maDoixe;
  MaTaixe? maTaixe;
  KhoRe? khoRe;
  MaloaiHang? maloaiHang;
  Loaixe? loaixe;
  MaTrongTai? maTrongTai;
  String? socont1;
  bool? trangthaicont1;
  LoaiCont? loaiCont;
  String? cont1seal1;
  String? cont1seal2;
  bool? trangthaihang;
  bool? trangthaikhoa;
  double? soKien;
  double? sokhoi;
  String? soBook;
  double? soTan;
  String? socont2;
  bool? trangthaicont2;
  LoaiCont? loaiCont1;
  String? cont2seal1;
  String? cont2seal2;
  bool? trangthaihang1;
  bool? trangthaikhoa1;
  double? sokien1;
  double? sokhoi1;
  String? soBook1;
  double? soTan1;
  String? note;
  int? typeInvote;

  DriverListTickerModel(
      {this.pdriverInOutWarehouseCode,
      this.giodukien,
      this.giovao,
      this.soxe,
      this.soReMooc,
      this.maKhachHang,
      this.maDoixe,
      this.maTaixe,
      this.khoRe,
      this.maloaiHang,
      this.loaixe,
      this.maTrongTai,
      this.socont1,
      this.trangthaicont1,
      this.loaiCont,
      this.cont1seal1,
      this.cont1seal2,
      this.trangthaihang,
      this.trangthaikhoa,
      this.soKien,
      this.sokhoi,
      this.soBook,
      this.soTan,
      this.socont2,
      this.trangthaicont2,
      this.loaiCont1,
      this.cont2seal1,
      this.cont2seal2,
      this.trangthaihang1,
      this.trangthaikhoa1,
      this.sokien1,
      this.sokhoi1,
      this.soBook1,
      this.soTan1,
      this.note,
      this.typeInvote});

  DriverListTickerModel.fromJson(Map<String, dynamic> json) {
    pdriverInOutWarehouseCode = json['pdriverInOutWarehouseCode'];
    giodukien = json['giodukien'];
    giovao = json['giovao'];
    soxe = json['soxe'];
    soReMooc = json['soReMooc'];
    maKhachHang = json['maKhachHang'] != null
        ? MaKhachHang.fromJson(json['maKhachHang'])
        : null;
    maDoixe =
        json['maDoixe'] != null ? MaDoixe.fromJson(json['maDoixe']) : null;
    maTaixe =
        json['maTaixe'] != null ? MaTaixe.fromJson(json['maTaixe']) : null;
    khoRe = json['kho_re'] != null ? KhoRe.fromJson(json['kho_re']) : null;
    maloaiHang = json['maloaiHang'] != null
        ? MaloaiHang.fromJson(json['maloaiHang'])
        : null;
    loaixe = json['loaixe'] != null ? Loaixe.fromJson(json['loaixe']) : null;
    maTrongTai = json['maTrongTai'] != null
        ? MaTrongTai.fromJson(json["maTrongTai"])
        : null;
    socont1 = json['socont1'];
    trangthaicont1 = json['trangthaicont1'];
    loaiCont =
        json['loaiCont'] != null ? LoaiCont.fromJson(json['loaiCont']) : null;
    cont1seal1 = json['cont1seal1'];
    cont1seal2 = json['cont1seal2'];
    trangthaihang = json['trangthaihang'];
    trangthaikhoa = json['trangthaikhoa'];
    soKien = json['SoKien'];
    sokhoi = json['sokhoi'];
    soBook = json['soBook'];
    soTan = json['soTan'];
    socont2 = json['socont2'];
    trangthaicont2 = json['trangthaicont2'];
    loaiCont1 =
        json['loaiCont1'] != null ? LoaiCont.fromJson(json['loaiCont1']) : null;
    cont2seal1 = json['cont2seal1'];
    cont2seal2 = json['cont2seal2'];
    trangthaihang1 = json['trangthaihang1'];
    trangthaikhoa1 = json['trangthaikhoa1'];
    sokien1 = json['Sokien1'];
    sokhoi1 = json['sokhoi1'];
    soBook1 = json['soBook1'];
    soTan1 = json['soTan1'];
    note = json['note'];
    typeInvote = json['typeInvote'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pdriverInOutWarehouseCode'] = pdriverInOutWarehouseCode;
    data['giodukien'] = giodukien;
    data['giovao'] = giovao;
    data['soxe'] = soxe;
    data['soReMooc'] = soReMooc;
    if (maKhachHang != null) {
      data['maKhachHang'] = maKhachHang!.toJson();
    }
    if (maDoixe != null) {
      data['maDoixe'] = maDoixe!.toJson();
    }
    if (maTaixe != null) {
      data['maTaixe'] = maTaixe!.toJson();
    }
    if (khoRe != null) {
      data['kho_re'] = khoRe!.toJson();
    }
    if (maloaiHang != null) {
      data['maloaiHang'] = maloaiHang!.toJson();
    }
    if (loaixe != null) {
      data['loaixe'] = loaixe!.toJson();
    }
    data['maTrongTai'] = maTrongTai;
    data['socont1'] = socont1;
    data['trangthaicont1'] = trangthaicont1;
    if (loaiCont != null) {
      data['loaiCont'] = loaiCont!.toJson();
    }
    data['cont1seal1'] = cont1seal1;
    data['cont1seal2'] = cont1seal2;
    data['trangthaihang'] = trangthaihang;
    data['trangthaikhoa'] = trangthaikhoa;
    data['SoKien'] = soKien;
    data['sokhoi'] = sokhoi;
    data['soBook'] = soBook;
    data['soTan'] = soTan;
    data['socont2'] = socont2;
    data['trangthaicont2'] = trangthaicont2;
    if (loaiCont1 != null) {
      data['loaiCont1'] = loaiCont1!.toJson();
    }
    data['cont2seal1'] = cont2seal1;
    data['cont2seal2'] = cont2seal2;
    data['trangthaihang1'] = trangthaihang1;
    data['trangthaikhoa1'] = trangthaikhoa1;
    data['Sokien1'] = sokien1;
    data['sokhoi1'] = sokhoi1;
    data['soBook1'] = soBook1;
    data['soTan1'] = soTan1;
    data['note'] = note;
    data['typeInvote'] = typeInvote;
    return data;
  }
}

class MaTrongTai {
  bool? status;
  String? tenTrongTai;
  String? maLoaiXe;
  int? stt;
  String? maTrongTai;

  MaTrongTai(
      {this.status,
      this.tenTrongTai,
      this.maLoaiXe,
      this.stt,
      this.maTrongTai});

  MaTrongTai.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    tenTrongTai = json['tenTrongTai'];
    maLoaiXe = json['maLoaiXe'];
    stt = json['stt'];
    maTrongTai = json['maTrongTai'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['tenTrongTai'] = this.tenTrongTai;
    data['maLoaiXe'] = this.maLoaiXe;
    data['stt'] = this.stt;
    data['maTrongTai'] = this.maTrongTai;
    return data;
  }
}

class MaKhachHang {
  String? usernameAccount;
  String? tenKhachhang;
  String? phone;
  String? website;
  String? mota;
  String? createtime;
  String? modifiedDate;
  bool? status;
  String? maKhachHang;
  String? diaChi;
  String? email;
  String? maSothue;
  String? createby;
  String? modifiedBy;
  bool? isDeleted;
  String? type;

  MaKhachHang(
      {this.usernameAccount,
      this.tenKhachhang,
      this.phone,
      this.website,
      this.mota,
      this.createtime,
      this.modifiedDate,
      this.status,
      this.maKhachHang,
      this.diaChi,
      this.email,
      this.maSothue,
      this.createby,
      this.modifiedBy,
      this.isDeleted,
      this.type});

  MaKhachHang.fromJson(Map<String, dynamic> json) {
    usernameAccount = json['usernameAccount'];
    tenKhachhang = json['tenKhachhang'];
    phone = json['phone'];
    website = json['website'];
    mota = json['mota'];
    createtime = json['createtime'];
    modifiedDate = json['ModifiedDate'];
    status = json['status'];
    maKhachHang = json['maKhachHang'];
    diaChi = json['diaChi'];
    email = json['email'];
    maSothue = json['maSothue'];
    createby = json['createby'];
    modifiedBy = json['ModifiedBy'];
    isDeleted = json['IsDeleted'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['usernameAccount'] = usernameAccount;
    data['tenKhachhang'] = tenKhachhang;
    data['phone'] = phone;
    data['website'] = website;
    data['mota'] = mota;
    data['createtime'] = createtime;
    data['ModifiedDate'] = modifiedDate;
    data['status'] = status;
    data['maKhachHang'] = maKhachHang;
    data['diaChi'] = diaChi;
    data['email'] = email;
    data['maSothue'] = maSothue;
    data['createby'] = createby;
    data['ModifiedBy'] = modifiedBy;
    data['IsDeleted'] = isDeleted;
    data['type'] = type;
    return data;
  }
}

class MaDoixe {
  String? usernameAccount;
  String? tenKhachhang;
  String? phone;
  String? website;
  String? mota;
  String? createtime;
  String? modifiedDate;
  String? status;
  String? maKhachHang;
  String? diaChi;
  String? email;
  String? maSothue;
  String? createby;
  String? modifiedBy;
  bool? isDeleted;
  String? type;

  MaDoixe(
      {this.usernameAccount,
      this.tenKhachhang,
      this.phone,
      this.website,
      this.mota,
      this.createtime,
      this.modifiedDate,
      this.status,
      this.maKhachHang,
      this.diaChi,
      this.email,
      this.maSothue,
      this.createby,
      this.modifiedBy,
      this.isDeleted,
      this.type});

  MaDoixe.fromJson(Map<String, dynamic> json) {
    usernameAccount = json['usernameAccount'];
    tenKhachhang = json['tenKhachhang'];
    phone = json['phone'];
    website = json['website'];
    mota = json['mota'];
    createtime = json['createtime'];
    modifiedDate = json['ModifiedDate'];
    status = json['status'];
    maKhachHang = json['maKhachHang'];
    diaChi = json['diaChi'];
    email = json['email'];
    maSothue = json['maSothue'];
    createby = json['createby'];
    modifiedBy = json['ModifiedBy'];
    isDeleted = json['IsDeleted'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['usernameAccount'] = usernameAccount;
    data['tenKhachhang'] = tenKhachhang;
    data['phone'] = phone;
    data['website'] = website;
    data['mota'] = mota;
    data['createtime'] = createtime;
    data['ModifiedDate'] = modifiedDate;
    data['status'] = status;
    data['maKhachHang'] = maKhachHang;
    data['diaChi'] = diaChi;
    data['email'] = email;
    data['maSothue'] = maSothue;
    data['createby'] = createby;
    data['ModifiedBy'] = modifiedBy;
    data['IsDeleted'] = isDeleted;
    data['type'] = type;
    return data;
  }
}

class MaTaixe {
  String? maKhachHang;
  String? madoixe;
  String? usernameAccount;
  String? email;
  bool? status;
  bool? isdelete;
  int? maTaixe;
  String? tenTaixe;
  String? diaChi;
  String? phone;
  String? cCCD;

  MaTaixe(
      {this.maKhachHang,
      this.madoixe,
      this.usernameAccount,
      this.email,
      this.status,
      this.isdelete,
      this.maTaixe,
      this.tenTaixe,
      this.diaChi,
      this.phone,
      this.cCCD});

  MaTaixe.fromJson(Map<String, dynamic> json) {
    maKhachHang = json['maKhachHang'];
    madoixe = json['madoixe'];
    usernameAccount = json['usernameAccount'];
    email = json['email'];
    status = json['status'];
    isdelete = json['isdelete'];
    maTaixe = json['maTaixe'];
    tenTaixe = json['tenTaixe'];
    diaChi = json['diaChi'];
    phone = json['phone'];
    cCCD = json['CCCD'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maKhachHang'] = maKhachHang;
    data['madoixe'] = madoixe;
    data['usernameAccount'] = usernameAccount;
    data['email'] = email;
    data['status'] = status;
    data['isdelete'] = isdelete;
    data['maTaixe'] = maTaixe;
    data['tenTaixe'] = tenTaixe;
    data['diaChi'] = diaChi;
    data['phone'] = phone;
    data['CCCD'] = cCCD;
    return data;
  }
}

class KhoRe {
  String? maKhuVuc;
  String? maKho;
  bool? status;
  String? tenKho;

  KhoRe({this.maKhuVuc, this.maKho, this.status, this.tenKho});

  KhoRe.fromJson(Map<String, dynamic> json) {
    maKhuVuc = json['maKhuVuc'];
    maKho = json['maKho'];
    status = json['status'];
    tenKho = json['tenKho'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maKhuVuc'] = maKhuVuc;
    data['maKho'] = maKho;
    data['status'] = status;
    data['tenKho'] = tenKho;
    return data;
  }
}

class MaloaiHang {
  String? tenLoaiHang;
  Null? chiTiet;
  String? maloaiHang;

  MaloaiHang({this.tenLoaiHang, this.chiTiet, this.maloaiHang});

  MaloaiHang.fromJson(Map<String, dynamic> json) {
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

class Loaixe {
  String? tenLoaiXe;
  int? stt;
  String? maLoaiXe;

  Loaixe({this.tenLoaiXe, this.stt, this.maLoaiXe});

  Loaixe.fromJson(Map<String, dynamic> json) {
    tenLoaiXe = json['tenLoaiXe'];
    stt = json['stt'];
    maLoaiXe = json['maLoaiXe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tenLoaiXe'] = tenLoaiXe;
    data['stt'] = stt;
    data['maLoaiXe'] = maLoaiXe;
    return data;
  }
}

class LoaiCont {
  String? typeContCode;
  bool? status;
  String? typeContname;

  LoaiCont({this.typeContCode, this.status, this.typeContname});

  LoaiCont.fromJson(Map<String, dynamic> json) {
    typeContCode = json['typeContCode'];
    status = json['status'];
    typeContname = json['typeContname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['typeContCode'] = typeContCode;
    data['status'] = status;
    data['typeContname'] = typeContname;
    return data;
  }
}
