import 'dart:collection';

class RegisterModel {
  String? giodukien;
  String? soxe;
  String? soReMooc;
  String? maKhachHang;
  String? maDoixe;
  int? maTaixe;
  String? kho;
  String? maloaiHang;
  String? loaixe;
  String? maTrongTai;
  String? socont1;
  String? loaiCont;
  String? cont1seal1;
  String? cont1seal2;
  bool? trangthaihang;
  bool? trangthaikhoa;
  double? soKien;
  double? sokhoi;
  String? soBook;
  double? soTan;
  String? socont2;
  String? loaiCont1;
  String? cont2seal1;
  String? cont2seal2;
  bool? trangthaihang1;
  bool? trangthaikhoa1;
  double? sokien1;
  double? sokhoi1;
  String? soBook1;
  double? soTan1;
  int? typeInvote;
  String? note;

  RegisterModel(
      {this.giodukien,
      this.soxe,
      this.soReMooc,
      this.maKhachHang,
      this.maDoixe,
      this.maTaixe,
      this.kho,
      this.maloaiHang,
      this.loaixe,
      this.maTrongTai,
      this.socont1,
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
      this.loaiCont1,
      this.cont2seal1,
      this.cont2seal2,
      this.trangthaihang1,
      this.trangthaikhoa1,
      this.sokien1,
      this.sokhoi1,
      this.soBook1,
      this.soTan1,
      this.typeInvote,
      this.note});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    giodukien = json['giodukien'];
    soxe = json['soxe'];
    soReMooc = json['soReMooc'];
    maKhachHang = json['maKhachHang'];
    maDoixe = json['maDoixe'];
    maTaixe = json['maTaixe'];
    kho = json['kho'];
    maloaiHang = json['maloaiHang'];
    loaixe = json['loaixe'];
    maTrongTai = json['maTrongTai'];
    socont1 = json['socont1'];
    loaiCont = json['loaiCont'];
    cont1seal1 = json['cont1seal1'];
    cont1seal2 = json['cont1seal2'];
    trangthaihang = json['trangthaihang'];
    trangthaikhoa = json['trangthaikhoa'];
    soKien = json['SoKien'];
    sokhoi = json['sokhoi'];
    soBook = json['soBook'];
    soTan = json['soTan'];
    socont2 = json['socont2'];
    loaiCont1 = json['loaiCont1'];
    cont2seal1 = json['cont2seal1'];
    cont2seal2 = json['cont2seal2'];
    trangthaihang1 = json['trangthaihang1'];
    trangthaikhoa1 = json['trangthaikhoa1'];
    sokien1 = json['Sokien1'];
    sokhoi1 = json['sokhoi1'];
    soBook1 = json['soBook1'];
    soTan1 = json['soTan1'];
    typeInvote = json['typeInvote'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['giodukien'] = giodukien;
    data['soxe'] = soxe;
    data['soReMooc'] = soReMooc;
    data['maKhachHang'] = maKhachHang;
    data['maDoixe'] = maDoixe;
    data['maTaixe'] = maTaixe;
    data['kho'] = kho;
    data['maloaiHang'] = maloaiHang;
    data['loaixe'] = loaixe;
    data['maTrongTai'] = maTrongTai;
    data['socont1'] = socont1;
    data['loaiCont'] = loaiCont;
    data['cont1seal1'] = cont1seal1;
    data['cont1seal2'] = cont1seal2;
    data['trangthaihang'] = trangthaihang;
    data['trangthaikhoa'] = trangthaikhoa;
    data['SoKien'] = soKien;
    data['sokhoi'] = sokhoi;
    data['soBook'] = soBook;
    data['soTan'] = soTan;
    data['socont2'] = socont2;
    data['loaiCont1'] = loaiCont1;
    data['cont2seal1'] = cont2seal1;
    data['cont2seal2'] = cont2seal2;
    data['trangthaihang1'] = trangthaihang1;
    data['trangthaikhoa1'] = trangthaikhoa1;
    data['Sokien1'] = sokien1;
    data['sokhoi1'] = sokhoi1;
    data['soBook1'] = soBook1;
    data['soTan1'] = soTan1;
    data['typeInvote'] = typeInvote;
    data['note'] = note;
    return data;
  }
}
