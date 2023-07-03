class RegisterOfSercurityModel {
  String? soxe;
  String? soReMooc;
  String? maKhachHang;
  int? maTaixe;
  String? kho;
  String? loaixe;
  String? maTrongTai;
  String? socont1;
  String? loaiCont;
  String? cont1seal1;
  String? cont1seal2;
  bool? trangthaihang;
  bool? trangthaikhoa;
  String? socont2;
  String? loaiCont1;
  String? cont2seal1;
  String? cont2seal2;
  bool? trangthaihang1;
  bool? trangthaikhoa1;
  String? note;

  RegisterOfSercurityModel(
      {this.soxe,
      this.soReMooc,
      this.maKhachHang,
      this.maTaixe,
      this.kho,
      this.loaixe,
      this.maTrongTai,
      this.socont1,
      this.loaiCont,
      this.cont1seal1,
      this.cont1seal2,
      this.trangthaihang,
      this.trangthaikhoa,
      this.socont2,
      this.loaiCont1,
      this.cont2seal1,
      this.cont2seal2,
      this.trangthaihang1,
      this.trangthaikhoa1,
      this.note});

  RegisterOfSercurityModel.fromJson(Map<String, dynamic> json) {
    soxe = json['soxe'];
    soReMooc = json['soReMooc'];
    maKhachHang = json['maKhachHang'];
    maTaixe = json['maTaixe'];
    kho = json['kho'];
    loaixe = json['loaixe'];
    maTrongTai = json['maTrongTai'];
    socont1 = json['socont1'];
    loaiCont = json['loaiCont'];
    cont1seal1 = json['cont1seal1'];
    cont1seal2 = json['cont1seal2'];
    trangthaihang = json['trangthaihang'];
    trangthaikhoa = json['trangthaikhoa'];
    socont2 = json['socont2'];
    loaiCont1 = json['loaiCont1'];
    cont2seal1 = json['cont2seal1'];
    cont2seal2 = json['cont2seal2'];
    trangthaihang1 = json['trangthaihang1'];
    trangthaikhoa1 = json['trangthaikhoa1'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['soxe'] = soxe;
    data['soReMooc'] = soReMooc;
    data['maKhachHang'] = maKhachHang;
    data['maTaixe'] = maTaixe;
    data['kho'] = kho;
    data['loaixe'] = loaixe;
    data['maTrongTai'] = maTrongTai;
    data['socont1'] = socont1;
    data['loaiCont'] = loaiCont;
    data['cont1seal1'] = cont1seal1;
    data['cont1seal2'] = cont1seal2;
    data['trangthaihang'] = trangthaihang;
    data['trangthaikhoa'] = trangthaikhoa;
    data['socont2'] = socont2;
    data['loaiCont1'] = loaiCont1;
    data['cont2seal1'] = cont2seal1;
    data['cont2seal2'] = cont2seal2;
    data['trangthaihang1'] = trangthaihang1;
    data['trangthaikhoa1'] = trangthaikhoa1;
    data['note'] = note;
    return data;
  }
}
