class TmsOrdersModel {
  String? maChuyen;
  String? maPTVC;
  String? loaiPhuongTien;
  String? thoiGianLayRong;
  String? thoiGianTraRong;
  String? thoiGianHaCang;
  String? thoiGianHanLenh;
  List<GetDataHandlingMobiles>? getDataHandlingMobiles;

  TmsOrdersModel(
      {this.maChuyen,
      this.maPTVC,
      this.loaiPhuongTien,
      this.thoiGianLayRong,
      this.thoiGianTraRong,
      this.thoiGianHaCang,
      this.thoiGianHanLenh,
      this.getDataHandlingMobiles});

  TmsOrdersModel.fromJson(Map<String, dynamic> json) {
    maChuyen = json['maChuyen'];
    maPTVC = json['maPTVC'];
    loaiPhuongTien = json['loaiPhuongTien'];
    thoiGianLayRong = json['thoiGianLayRong'];
    thoiGianTraRong = json['thoiGianTraRong'];
    thoiGianHaCang = json['thoiGianHaCang'];
    thoiGianHanLenh = json['thoiGianHanLenh'];
    if (json['getDataHandlingMobiles'] != null) {
      getDataHandlingMobiles = <GetDataHandlingMobiles>[];
      json['getDataHandlingMobiles'].forEach((v) {
        getDataHandlingMobiles!.add(GetDataHandlingMobiles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maChuyen'] = maChuyen;
    data['maPTVC'] = maPTVC;
    data['loaiPhuongTien'] = loaiPhuongTien;
    data['thoiGianLayRong'] = thoiGianLayRong;
    data['thoiGianTraRong'] = thoiGianTraRong;
    data['thoiGianHaCang'] = thoiGianHaCang;
    data['thoiGianHanLenh'] = thoiGianHanLenh;
    if (getDataHandlingMobiles != null) {
      data['getDataHandlingMobiles'] =
          getDataHandlingMobiles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetDataHandlingMobiles {
  int? handlingId;
  int? thuTuGiaoHang;
  String? bookingNo;
  String? maVanDon;
  String? loaiVanDon;
  String? diemLayHang;
  String? diemTraHang;
  String? diemTraRong;
  String? diemLayRong;
  int? maDiemLayHang;
  int? maDiemTraHang;
  int? maDiemTraRong;
  int? maDiemLayRong;
  String? hangTau;
  String? ghiChu;
  String? contNo;
  int? khoiLuong;
  int? theTich;
  int? soKien;
  String? trangThai;
  int? maTrangThai;
  String? thoiGianLayHang;
  String? thoiGianTraHang;
  String? thoiGianCoMat;

  GetDataHandlingMobiles(
      {this.handlingId,
      this.thuTuGiaoHang,
      this.bookingNo,
      this.maVanDon,
      this.loaiVanDon,
      this.diemLayHang,
      this.diemTraHang,
      this.diemTraRong,
      this.diemLayRong,
      this.maDiemLayHang,
      this.maDiemTraHang,
      this.maDiemTraRong,
      this.maDiemLayRong,
      this.hangTau,
      this.ghiChu,
      this.contNo,
      this.khoiLuong,
      this.theTich,
      this.soKien,
      this.trangThai,
      this.maTrangThai,
      this.thoiGianLayHang,
      this.thoiGianTraHang,
      this.thoiGianCoMat});

  GetDataHandlingMobiles.fromJson(Map<String, dynamic> json) {
    handlingId = json['handlingId'];
    thuTuGiaoHang = json['thuTuGiaoHang'];
    bookingNo = json['bookingNo'];
    maVanDon = json['maVanDon'];
    loaiVanDon = json['loaiVanDon'];
    diemLayHang = json['diemLayHang'];
    diemTraHang = json['diemTraHang'];
    diemTraRong = json['diemTraRong'];
    diemLayRong = json['diemLayRong'];
    maDiemLayHang = json['maDiemLayHang'];
    maDiemTraHang = json['maDiemTraHang'];
    maDiemTraRong = json['maDiemTraRong'];
    maDiemLayRong = json['maDiemLayRong'];
    hangTau = json['hangTau'];
    ghiChu = json['ghiChu'];
    contNo = json['contNo'];
    khoiLuong = json['khoiLuong'];
    theTich = json['theTich'];
    soKien = json['soKien'];
    trangThai = json['trangThai'];
    maTrangThai = json['maTrangThai'];
    thoiGianLayHang = json['thoiGianLayHang'];
    thoiGianTraHang = json['thoiGianTraHang'];
    thoiGianCoMat = json['thoiGianCoMat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['handlingId'] = this.handlingId;
    data['thuTuGiaoHang'] = this.thuTuGiaoHang;
    data['bookingNo'] = this.bookingNo;
    data['maVanDon'] = this.maVanDon;
    data['loaiVanDon'] = this.loaiVanDon;
    data['diemLayHang'] = this.diemLayHang;
    data['diemTraHang'] = this.diemTraHang;
    data['diemTraRong'] = this.diemTraRong;
    data['diemLayRong'] = this.diemLayRong;
    data['maDiemLayHang'] = this.maDiemLayHang;
    data['maDiemTraHang'] = this.maDiemTraHang;
    data['maDiemTraRong'] = this.maDiemTraRong;
    data['maDiemLayRong'] = this.maDiemLayRong;
    data['hangTau'] = this.hangTau;
    data['ghiChu'] = this.ghiChu;
    data['contNo'] = this.contNo;
    data['khoiLuong'] = this.khoiLuong;
    data['theTich'] = this.theTich;
    data['soKien'] = this.soKien;
    data['trangThai'] = this.trangThai;
    data['maTrangThai'] = this.maTrangThai;
    data['thoiGianLayHang'] = this.thoiGianLayHang;
    data['thoiGianTraHang'] = this.thoiGianTraHang;
    data['thoiGianCoMat'] = this.thoiGianCoMat;
    return data;
  }
}
