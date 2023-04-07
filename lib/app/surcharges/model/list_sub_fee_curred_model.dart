class ListSubFeeIncurredModel {
  int? id;
  String? diaDiem;
  String? maVanDon;
  String? maSoXe;
  String? taiXe;
  String? subFee;
  int? price;
  String? type;
  String? trangThai;
  String? approvedDate;
  String? createdDate;

  ListSubFeeIncurredModel(
      {this.id,
      this.diaDiem,
      this.maVanDon,
      this.maSoXe,
      this.taiXe,
      this.subFee,
      this.price,
      this.type,
      this.trangThai,
      this.approvedDate,
      this.createdDate});

  ListSubFeeIncurredModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    diaDiem = json['diaDiem'];
    maVanDon = json['maVanDon'];
    maSoXe = json['maSoXe'];
    taiXe = json['taiXe'];
    subFee = json['subFee'];
    price = json['price'];
    type = json['type'];
    trangThai = json['trangThai'];
    approvedDate = json['approvedDate'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['diaDiem'] = diaDiem;
    data['maVanDon'] = maVanDon;
    data['maSoXe'] = maSoXe;
    data['taiXe'] = taiXe;
    data['subFee'] = subFee;
    data['price'] = price;
    data['type'] = type;
    data['trangThai'] = trangThai;
    data['approvedDate'] = approvedDate;
    data['createdDate'] = createdDate;
    return data;
  }
}
