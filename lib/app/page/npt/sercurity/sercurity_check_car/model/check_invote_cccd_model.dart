class CheckInvoteCccdModel {
  DetailsInvote? invote;
  CheckTaixe? taixe;

  CheckInvoteCccdModel({this.invote, this.taixe});

  CheckInvoteCccdModel.fromJson(Map<String, dynamic> json) {
    invote =
        json['invote'] != null ? DetailsInvote.fromJson(json['invote']) : null;
    taixe = json['taixe'] != null ? CheckTaixe.fromJson(json['taixe']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (invote != null) {
      data['invote'] = invote!.toJson();
    }
    if (taixe != null) {
      data['taixe'] = taixe!.toJson();
    }
    return data;
  }
}

class DetailsInvote {
  String? driverInOutWarehouseCode;
  String? maDoixe;
  String? loaiCont;
  double? soTan;
  bool? trangthaikhoa1;
  String? timeout2;
  int? driverInOutWarehouseID;
  int? maTaixe;
  String? cont1seal1;
  double? sokien1;
  double? sokhoi1;
  String? createby;
  String? pdriverInOutWarehouseCode;
  String? kho;
  String? cont1seal2;
  String? socont2;
  String? soBook1;
  String? manv;
  String? giodukien;
  String? maloaiHang;
  bool? trangthaihang;
  bool? trangthaicont2;
  double? soTan1;
  bool? status;
  String? loaixe;
  String? giovao;
  bool? trangthaikhoa;
  String? loaiCont1;
  String? note;
  bool? isdelete;
  String? soxe;
  String? maTrongTai;
  double? soKien;
  String? cont2seal1;
  int? typeInvote;
  String? soReMooc;
  String? socont1;
  double? sokhoi;
  String? cont2seal2;
  int? ks;
  String? maKhachHang;
  bool? trangthaicont1;
  String? soBook;
  bool? trangthaihang1;
  String? timeout1;

  DetailsInvote(
      {this.driverInOutWarehouseCode,
      this.maDoixe,
      this.loaiCont,
      this.soTan,
      this.trangthaikhoa1,
      this.timeout2,
      this.driverInOutWarehouseID,
      this.maTaixe,
      this.cont1seal1,
      this.sokien1,
      this.sokhoi1,
      this.createby,
      this.pdriverInOutWarehouseCode,
      this.kho,
      this.cont1seal2,
      this.socont2,
      this.soBook1,
      this.manv,
      this.giodukien,
      this.maloaiHang,
      this.trangthaihang,
      this.trangthaicont2,
      this.soTan1,
      this.status,
      this.loaixe,
      this.giovao,
      this.trangthaikhoa,
      this.loaiCont1,
      this.note,
      this.isdelete,
      this.soxe,
      this.maTrongTai,
      this.soKien,
      this.cont2seal1,
      this.typeInvote,
      this.soReMooc,
      this.socont1,
      this.sokhoi,
      this.cont2seal2,
      this.ks,
      this.maKhachHang,
      this.trangthaicont1,
      this.soBook,
      this.trangthaihang1,
      this.timeout1});

  DetailsInvote.fromJson(Map<String, dynamic> json) {
    driverInOutWarehouseCode = json['driverInOutWarehouseCode'];
    maDoixe = json['maDoixe'];
    loaiCont = json['loaiCont'];
    soTan = json['soTan'];
    trangthaikhoa1 = json['trangthaikhoa1'];
    timeout2 = json['timeout2'];
    driverInOutWarehouseID = json['driverInOutWarehouseID'];
    maTaixe = json['maTaixe'];
    cont1seal1 = json['cont1seal1'];
    sokien1 = json['Sokien1'];
    sokhoi1 = json['sokhoi1'];
    createby = json['createby'];
    pdriverInOutWarehouseCode = json['pdriverInOutWarehouseCode'];
    kho = json['kho'];
    cont1seal2 = json['cont1seal2'];
    socont2 = json['socont2'];
    soBook1 = json['soBook1'];
    manv = json['manv'];
    giodukien = json['giodukien'];
    maloaiHang = json['maloaiHang'];
    trangthaihang = json['trangthaihang'];
    trangthaicont2 = json['trangthaicont2'];
    soTan1 = json['soTan1'];
    status = json['status'];
    loaixe = json['loaixe'];
    giovao = json['giovao'];
    trangthaikhoa = json['trangthaikhoa'];
    loaiCont1 = json['loaiCont1'];
    note = json['note'];
    isdelete = json['isdelete'];
    soxe = json['soxe'];
    maTrongTai = json['maTrongTai'];
    soKien = json['SoKien'];
    cont2seal1 = json['cont2seal1'];
    typeInvote = json['typeInvote'];
    soReMooc = json['soReMooc'];
    socont1 = json['socont1'];
    sokhoi = json['sokhoi'];
    cont2seal2 = json['cont2seal2'];
    ks = json['ks'];
    maKhachHang = json['maKhachHang'];
    trangthaicont1 = json['trangthaicont1'];
    soBook = json['soBook'];
    trangthaihang1 = json['trangthaihang1'];
    timeout1 = json['timeout1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['driverInOutWarehouseCode'] = driverInOutWarehouseCode;
    data['maDoixe'] = maDoixe;
    data['loaiCont'] = loaiCont;
    data['soTan'] = soTan;
    data['trangthaikhoa1'] = trangthaikhoa1;
    data['timeout2'] = timeout2;
    data['driverInOutWarehouseID'] = driverInOutWarehouseID;
    data['maTaixe'] = maTaixe;
    data['cont1seal1'] = cont1seal1;
    data['Sokien1'] = sokien1;
    data['sokhoi1'] = sokhoi1;
    data['createby'] = createby;
    data['pdriverInOutWarehouseCode'] = pdriverInOutWarehouseCode;
    data['kho'] = kho;
    data['cont1seal2'] = cont1seal2;
    data['socont2'] = socont2;
    data['soBook1'] = soBook1;
    data['manv'] = manv;
    data['giodukien'] = giodukien;
    data['maloaiHang'] = maloaiHang;
    data['trangthaihang'] = trangthaihang;
    data['trangthaicont2'] = trangthaicont2;
    data['soTan1'] = soTan1;
    data['status'] = status;
    data['loaixe'] = loaixe;
    data['giovao'] = giovao;
    data['trangthaikhoa'] = trangthaikhoa;
    data['loaiCont1'] = loaiCont1;
    data['note'] = note;
    data['isdelete'] = isdelete;
    data['soxe'] = soxe;
    data['maTrongTai'] = maTrongTai;
    data['SoKien'] = soKien;
    data['cont2seal1'] = cont2seal1;
    data['typeInvote'] = typeInvote;
    data['soReMooc'] = soReMooc;
    data['socont1'] = socont1;
    data['sokhoi'] = sokhoi;
    data['cont2seal2'] = cont2seal2;
    data['ks'] = ks;
    data['maKhachHang'] = maKhachHang;
    data['trangthaicont1'] = trangthaicont1;
    data['soBook'] = soBook;
    data['trangthaihang1'] = trangthaihang1;
    data['timeout1'] = timeout1;
    return data;
  }
}

class CheckTaixe {
  int? maTaixe;
  String? tenTaixe;
  String? diaChi;
  String? email;
  String? cCCD;
  String? phone;
  String? maKhachHang;

  CheckTaixe(
      {this.maTaixe,
      this.tenTaixe,
      this.diaChi,
      this.email,
      this.cCCD,
      this.phone,
      this.maKhachHang});

  CheckTaixe.fromJson(Map<String, dynamic> json) {
    maTaixe = json['maTaixe'];
    tenTaixe = json['tenTaixe'];
    diaChi = json['diaChi'];
    email = json['email'];
    cCCD = json['CCCD'];
    phone = json['phone'];
    maKhachHang = json['maKhachHang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maTaixe'] = maTaixe;
    data['tenTaixe'] = tenTaixe;
    data['diaChi'] = diaChi;
    data['email'] = email;
    data['CCCD'] = cCCD;
    data['phone'] = phone;
    data['maKhachHang'] = maKhachHang;
    return data;
  }
}
