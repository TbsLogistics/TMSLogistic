class RegisterForDriverModel {
  int? maTaixe;
  String? maKhachHang;
  String? maDoixe;
  String? giodukien;
  String? kho;
  String? note;
  String? loaixe;
  String? soxe;
  double? soTan;
  double? soTan1;
  String? loaiCont;
  String? loaiCont1;
  String? maTrongTai;
  String? maloaiHang;
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
  int? taiXeRa;
  String? soXera;

  RegisterForDriverModel(
      {this.maTaixe,
      this.maKhachHang,
      this.maDoixe,
      this.giodukien,
      this.kho,
      this.note,
      this.loaixe,
      this.soxe,
      this.soTan,
      this.soTan1,
      this.loaiCont,
      this.loaiCont1,
      this.maTrongTai,
      this.maloaiHang,
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
      this.taiXeRa,
      this.soXera});

  RegisterForDriverModel.fromJson(Map<String, dynamic> json) {
    maTaixe = json['maTaixe'];
    maKhachHang = json['maKhachHang'];
    maDoixe = json['maDoixe'];
    giodukien = json['giodukien'];
    kho = json['kho'];
    note = json['note'];
    loaixe = json['loaixe'];
    soxe = json['soxe'];
    soTan = json['soTan'];
    soTan1 = json['soTan1'];
    loaiCont = json['loaiCont'];
    loaiCont1 = json['loaiCont1'];
    maTrongTai = json['maTrongTai'];
    maloaiHang = json['maloaiHang'];
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
    taiXeRa = json['taiXeRa'];
    soXera = json['soXera'];
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
    data['soTan'] = soTan;
    data['soTan1'] = soTan1;
    data['loaiCont'] = loaiCont;
    data['loaiCont1'] = loaiCont1;
    data['maTrongTai'] = maTrongTai;
    data['maloaiHang'] = maloaiHang;
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
    data['taiXeRa'] = taiXeRa;
    data['soXera'] = soXera;
    return data;
  }
}
