class CustomerRegisterForDriverModel {
  int? maTaixe;
  String? maKhachHang;
  String? maDoixe;
  String? giodukien;
  String? kho;
  String? note;
  String? loaixe;
  String? soxe;
  String? soReMooc;
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
  int? taiXeRa;
  String? soXera;
  CapCong? capCong;

  CustomerRegisterForDriverModel(
      {this.maTaixe,
      this.maKhachHang,
      this.maDoixe,
      this.giodukien,
      this.kho,
      this.note,
      this.loaixe,
      this.soxe,
      this.soReMooc,
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
      this.taiXeRa,
      this.soXera,
      this.capCong});

  CustomerRegisterForDriverModel.fromJson(Map<String, dynamic> json) {
    maTaixe = json['maTaixe'];
    maKhachHang = json['maKhachHang'];
    maDoixe = json['maDoixe'];
    giodukien = json['giodukien'];
    kho = json['kho'];
    note = json['note'];
    loaixe = json['loaixe'];
    soxe = json['soxe'];
    soReMooc = json['soReMooc'];
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
    taiXeRa = json['taiXeRa'];
    soXera = json['soXera'];
    capCong =
        json['capCong'] != null ? new CapCong.fromJson(json['capCong']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maTaixe'] = maTaixe;
    data['maKhachHang'] = maKhachHang;
    data['maDoixe'] = maDoixe;
    data['giodukien'] = giodukien;
    data['kho'] = kho;
    data['note'] = note;
    data['loaixe'] = loaixe;
    data['soxe'] = soxe;
    data['soReMooc'] = soReMooc;
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
    data['taiXeRa'] = taiXeRa;
    data['soXera'] = soXera;
    if (capCong != null) {
      data['capCong'] = capCong!.toJson();
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
