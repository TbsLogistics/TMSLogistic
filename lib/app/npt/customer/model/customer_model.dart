class CustomerModel {
  String? tenKhachhang;
  String? phone;
  String? usernameAccount;
  String? website;
  String? mota;
  String? createtime;
  String? modifiedDate;
  bool? status;
  String? diaChi;
  String? maKhachHang;
  String? email;
  String? maSothue;
  String? createby;
  String? modifiedBy;
  bool? isDeleted;

  CustomerModel(
      {this.tenKhachhang,
      this.phone,
      this.usernameAccount,
      this.website,
      this.mota,
      this.createtime,
      this.modifiedDate,
      this.status,
      this.diaChi,
      this.maKhachHang,
      this.email,
      this.maSothue,
      this.createby,
      this.modifiedBy,
      this.isDeleted});

  CustomerModel.fromJson(Map<String, dynamic> json) {
    tenKhachhang = json['tenKhachhang'];
    phone = json['phone'];
    usernameAccount = json['usernameAccount'];
    website = json['website'];
    mota = json['mota'];
    createtime = json['createtime'];
    modifiedDate = json['ModifiedDate'];
    status = json['status'];
    diaChi = json['diaChi'];
    maKhachHang = json['maKhachHang'];
    email = json['email'];
    maSothue = json['maSothue'];
    createby = json['createby'];
    modifiedBy = json['ModifiedBy'];
    isDeleted = json['IsDeleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tenKhachhang'] = tenKhachhang;
    data['phone'] = phone;
    data['usernameAccount'] = usernameAccount;
    data['website'] = website;
    data['mota'] = mota;
    data['createtime'] = createtime;
    data['ModifiedDate'] = modifiedDate;
    data['status'] = status;
    data['diaChi'] = diaChi;
    data['maKhachHang'] = maKhachHang;
    data['email'] = email;
    data['maSothue'] = maSothue;
    data['createby'] = createby;
    data['ModifiedBy'] = modifiedBy;
    data['IsDeleted'] = isDeleted;
    return data;
  }
}
