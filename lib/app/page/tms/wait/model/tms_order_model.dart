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
        getDataHandlingMobiles?.add(GetDataHandlingMobiles.fromJson(v));
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
  String? maPTVC;
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
  String? khoiLuong;
  String? theTich;
  String? soKien;
  String? trangThai;
  int? maTrangThai;
  String? thoiGianLayHang;
  String? thoiGianTraHang;
  String? thoiGianCoMat;

  GetDataHandlingMobiles(
      {this.handlingId,
      this.thuTuGiaoHang,
      this.bookingNo,
      this.maPTVC,
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
    maPTVC = json['maPTVC'];
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['handlingId'] = handlingId;
    data['thuTuGiaoHang'] = thuTuGiaoHang;
    data['bookingNo'] = bookingNo;
    data['maPTVC'] = maPTVC;
    data['maVanDon'] = maVanDon;
    data['loaiVanDon'] = loaiVanDon;
    data['diemLayHang'] = diemLayHang;
    data['diemTraHang'] = diemTraHang;
    data['diemTraRong'] = diemTraRong;
    data['diemLayRong'] = diemLayRong;
    data['maDiemLayHang'] = maDiemLayHang;
    data['maDiemTraHang'] = maDiemTraHang;
    data['maDiemTraRong'] = maDiemTraRong;
    data['maDiemLayRong'] = maDiemLayRong;
    data['hangTau'] = hangTau;
    data['ghiChu'] = ghiChu;
    data['contNo'] = contNo;
    data['khoiLuong'] = khoiLuong;
    data['theTich'] = theTich;
    data['soKien'] = soKien;
    data['trangThai'] = trangThai;
    data['maTrangThai'] = maTrangThai;
    data['thoiGianLayHang'] = thoiGianLayHang;
    data['thoiGianTraHang'] = thoiGianTraHang;
    data['thoiGianCoMat'] = thoiGianCoMat;
    return data;
  }
}
