class ChangeStatusTrackingInModel {
  int? maPhieuvao;
  String? soxe;
  String? capTrangthai;
  int? maTaiXe;
  int? maCong;
  int? madock;

  ChangeStatusTrackingInModel(
      {this.maPhieuvao,
      this.soxe,
      this.capTrangthai,
      this.maTaiXe,
      this.maCong,
      this.madock});

  ChangeStatusTrackingInModel.fromJson(Map<String, dynamic> json) {
    maPhieuvao = json['maPhieuvao'];
    soxe = json['soxe'];
    capTrangthai = json['capTrangthai'];
    maTaiXe = json['maTaiXe'];
    maCong = json['maCong'];
    madock = json['madock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maPhieuvao'] = maPhieuvao;
    data['soxe'] = soxe;
    data['capTrangthai'] = capTrangthai;
    data['maTaiXe'] = maTaiXe;
    data['maCong'] = maCong;
    data['madock'] = madock;
    return data;
  }
}
