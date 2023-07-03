// ignore_for_file: unnecessary_question_mark, prefer_void_to_null

class CustomerListRegistedModel {
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

  CustomerListRegistedModel(
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

  CustomerListRegistedModel.fromJson(Map<String, dynamic> json) {
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
        ? MaTrongTai.fromJson(json['maTrongTai'])
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
    if (maTrongTai != null) {
      data['maTrongTai'] = maTrongTai!.toJson();
    }
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

class MaKhachHang {
  String? diaChi;
  String? maKhachHang;
  String? usernameAccount;
  String? email;
  String? maSothue;
  String? createby;
  String? modifiedBy;
  bool? isDeleted;
  String? type;
  String? tenKhachhang;
  String? phone;
  String? website;
  String? mota;
  String? createtime;
  String? modifiedDate;
  bool? status;

  MaKhachHang(
      {this.diaChi,
      this.maKhachHang,
      this.usernameAccount,
      this.email,
      this.maSothue,
      this.createby,
      this.modifiedBy,
      this.isDeleted,
      this.type,
      this.tenKhachhang,
      this.phone,
      this.website,
      this.mota,
      this.createtime,
      this.modifiedDate,
      this.status});

  MaKhachHang.fromJson(Map<String, dynamic> json) {
    diaChi = json['diaChi'];
    maKhachHang = json['maKhachHang'];
    usernameAccount = json['usernameAccount'];
    email = json['email'];
    maSothue = json['maSothue'];
    createby = json['createby'];
    modifiedBy = json['ModifiedBy'];
    isDeleted = json['IsDeleted'];
    type = json['type'];
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
    data['usernameAccount'] = usernameAccount;
    data['email'] = email;
    data['maSothue'] = maSothue;
    data['createby'] = createby;
    data['ModifiedBy'] = modifiedBy;
    data['IsDeleted'] = isDeleted;
    data['type'] = type;
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

class MaDoixe {
  String? diaChi;
  String? maKhachHang;
  String? usernameAccount;
  String? email;
  String? maSothue;
  String? createby;
  String? modifiedBy;
  bool? isDeleted;
  String? type;
  String? tenKhachhang;
  String? phone;
  String? website;
  String? mota;
  String? createtime;
  String? modifiedDate;
  bool? status;

  MaDoixe(
      {this.diaChi,
      this.maKhachHang,
      this.usernameAccount,
      this.email,
      this.maSothue,
      this.createby,
      this.modifiedBy,
      this.isDeleted,
      this.type,
      this.tenKhachhang,
      this.phone,
      this.website,
      this.mota,
      this.createtime,
      this.modifiedDate,
      this.status});

  MaDoixe.fromJson(Map<String, dynamic> json) {
    diaChi = json['diaChi'];
    maKhachHang = json['maKhachHang'];
    usernameAccount = json['usernameAccount'];
    email = json['email'];
    maSothue = json['maSothue'];
    createby = json['createby'];
    modifiedBy = json['ModifiedBy'];
    isDeleted = json['IsDeleted'];
    type = json['type'];
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
    data['usernameAccount'] = usernameAccount;
    data['email'] = email;
    data['maSothue'] = maSothue;
    data['createby'] = createby;
    data['ModifiedBy'] = modifiedBy;
    data['IsDeleted'] = isDeleted;
    data['type'] = type;
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
  String? diaChi;
  String? phone;
  String? cCCD;
  String? maKhachHang;
  String? madoixe;
  String? usernameAccount;
  String? email;
  bool? status;
  bool? isdelete;

  MaTaixe(
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

  MaTaixe.fromJson(Map<String, dynamic> json) {
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

class KhoRe {
  String? maKho;
  String? maKhuVuc;
  String? tenKho;
  bool? status;

  KhoRe({this.maKho, this.maKhuVuc, this.tenKho, this.status});

  KhoRe.fromJson(Map<String, dynamic> json) {
    maKho = json['maKho'];
    maKhuVuc = json['maKhuVuc'];
    tenKho = json['tenKho'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maKho'] = maKho;
    data['maKhuVuc'] = maKhuVuc;
    data['tenKho'] = tenKho;
    data['status'] = status;
    return data;
  }
}

class MaloaiHang {
  String? maloaiHang;
  String? tenLoaiHang;
  Null? chiTiet;

  MaloaiHang({this.maloaiHang, this.tenLoaiHang, this.chiTiet});

  MaloaiHang.fromJson(Map<String, dynamic> json) {
    maloaiHang = json['maloaiHang'];
    tenLoaiHang = json['tenLoaiHang'];
    chiTiet = json['chiTiet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maloaiHang'] = maloaiHang;
    data['tenLoaiHang'] = tenLoaiHang;
    data['chiTiet'] = chiTiet;
    return data;
  }
}

class Loaixe {
  int? stt;
  String? tenLoaiXe;
  String? maLoaiXe;

  Loaixe({this.stt, this.tenLoaiXe, this.maLoaiXe});

  Loaixe.fromJson(Map<String, dynamic> json) {
    stt = json['stt'];
    tenLoaiXe = json['tenLoaiXe'];
    maLoaiXe = json['maLoaiXe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stt'] = stt;
    data['tenLoaiXe'] = tenLoaiXe;
    data['maLoaiXe'] = maLoaiXe;
    return data;
  }
}

class MaTrongTai {
  int? stt;
  String? maTrongTai;
  bool? status;
  String? tenTrongTai;
  String? maLoaiXe;

  MaTrongTai(
      {this.stt,
      this.maTrongTai,
      this.status,
      this.tenTrongTai,
      this.maLoaiXe});

  MaTrongTai.fromJson(Map<String, dynamic> json) {
    stt = json['stt'];
    maTrongTai = json['maTrongTai'];
    status = json['status'];
    tenTrongTai = json['tenTrongTai'];
    maLoaiXe = json['maLoaiXe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stt'] = stt;
    data['maTrongTai'] = maTrongTai;
    data['status'] = status;
    data['tenTrongTai'] = tenTrongTai;
    data['maLoaiXe'] = maLoaiXe;
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
