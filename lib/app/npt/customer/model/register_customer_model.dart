class RegisterForCustomerModel {
  String? maKhachHang;
  String? giodukien;
  String? kho;
  String? loaixe;
  String? soxe;
  String? socont1;
  String? socont2;
  String? cont1seal1;
  String? cont1seal2;
  double? soKien;
  double? sokhoi;
  String? soBook;
  bool? trangthaihang;
  bool? trangthaikhoa;
  String? cont2seal1;
  String? cont2seal2;
  double? sokien1;
  double? sokhoi1;
  String? soBook1;
  bool? trangthaihang1;
  bool? trangthaikhoa1;
  String? maloaiHang;
  int? maTaixe;

  RegisterForCustomerModel(
      {this.maKhachHang,
      this.giodukien,
      this.kho,
      this.loaixe,
      this.soxe,
      this.socont1,
      this.socont2,
      this.cont1seal1,
      this.cont1seal2,
      this.soKien,
      this.sokhoi,
      this.soBook,
      this.trangthaihang,
      this.trangthaikhoa,
      this.cont2seal1,
      this.cont2seal2,
      this.sokien1,
      this.sokhoi1,
      this.soBook1,
      this.trangthaihang1,
      this.trangthaikhoa1,
      this.maloaiHang,
      this.maTaixe});

  RegisterForCustomerModel.fromJson(Map<String, dynamic> json) {
    maKhachHang = json['maKhachHang'];
    giodukien = json['giodukien'];
    kho = json['kho'];
    loaixe = json['loaixe'];
    soxe = json['soxe'];
    socont1 = json['socont1'];
    socont2 = json['socont2'];
    cont1seal1 = json['cont1seal1'];
    cont1seal2 = json['cont1seal2'];
    soKien = json['SoKien'];
    sokhoi = json['sokhoi'];
    soBook = json['soBook'];
    trangthaihang = json['trangthaihang'];
    trangthaikhoa = json['trangthaikhoa'];
    cont2seal1 = json['cont2seal1'];
    cont2seal2 = json['cont2seal2'];
    sokien1 = json['Sokien1'];
    sokhoi1 = json['sokhoi1'];
    soBook1 = json['soBook1'];
    trangthaihang1 = json['trangthaihang1'];
    trangthaikhoa1 = json['trangthaikhoa1'];
    maloaiHang = json['maloaiHang'];
    maTaixe = json['maTaixe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maKhachHang'] = maKhachHang;
    data['giodukien'] = giodukien;
    data['kho'] = kho;
    data['loaixe'] = loaixe;
    data['soxe'] = soxe;
    data['socont1'] = socont1;
    data['socont2'] = socont2;
    data['cont1seal1'] = cont1seal1;
    data['cont1seal2'] = cont1seal2;
    data['SoKien'] = soKien;
    data['sokhoi'] = sokhoi;
    data['soBook'] = soBook;
    data['trangthaihang'] = trangthaihang;
    data['trangthaikhoa'] = trangthaikhoa;
    data['cont2seal1'] = cont2seal1;
    data['cont2seal2'] = cont2seal2;
    data['Sokien1'] = sokien1;
    data['sokhoi1'] = sokhoi1;
    data['soBook1'] = soBook1;
    data['trangthaihang1'] = trangthaihang1;
    data['trangthaikhoa1'] = trangthaikhoa1;
    data['maloaiHang'] = maloaiHang;
    data['maTaixe'] = maTaixe;
    return data;
  }
}
