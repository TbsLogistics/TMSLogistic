class ListCustomerForCustomerModel {
  String? tenKhachhang;
  String? usernameAccount;
  String? phone;
  String? website;
  String? mota;
  String? createtime;
  String? modifiedDate;
  bool? status;
  String? maKhachHang;
  String? diaChi;
  String? email;
  String? maSothue;
  int? createby;
  int? modifiedBy;
  bool? isDeleted;
  String? type;

  ListCustomerForCustomerModel(
      {this.tenKhachhang,
      this.usernameAccount,
      this.phone,
      this.website,
      this.mota,
      this.createtime,
      this.modifiedDate,
      this.status,
      this.maKhachHang,
      this.diaChi,
      this.email,
      this.maSothue,
      this.createby,
      this.modifiedBy,
      this.isDeleted,
      this.type});

  ListCustomerForCustomerModel.fromJson(Map<String, dynamic> json) {
    tenKhachhang = json['tenKhachhang'];
    usernameAccount = json['usernameAccount'];
    phone = json['phone'];
    website = json['website'];
    mota = json['mota'];
    createtime = json['createtime'];
    modifiedDate = json['ModifiedDate'];
    status = json['status'];
    maKhachHang = json['maKhachHang'];
    diaChi = json['diaChi'];
    email = json['email'];
    maSothue = json['maSothue'];
    createby = json['createby'];
    modifiedBy = json['ModifiedBy'];
    isDeleted = json['IsDeleted'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tenKhachhang'] = tenKhachhang;
    data['usernameAccount'] = usernameAccount;
    data['phone'] = phone;
    data['website'] = website;
    data['mota'] = mota;
    data['createtime'] = createtime;
    data['ModifiedDate'] = modifiedDate;
    data['status'] = status;
    data['maKhachHang'] = maKhachHang;
    data['diaChi'] = diaChi;
    data['email'] = email;
    data['maSothue'] = maSothue;
    data['createby'] = createby;
    data['ModifiedBy'] = modifiedBy;
    data['IsDeleted'] = isDeleted;
    data['type'] = type;
    return data;
  }

  static List<ListCustomerForCustomerModel> fromJsonList(List list) {
    return list
        .map((item) => ListCustomerForCustomerModel.fromJson(item))
        .toList();
  }

  String userAsString() {
    // ignore: unnecessary_this
    return "#${this.maKhachHang} ${this.tenKhachhang}";
  }

  bool isEqual(ListCustomerForCustomerModel model) {
    // ignore: unnecessary_this
    return this.tenKhachhang == model.tenKhachhang;
  }

  @override
  String toString() {
    if (tenKhachhang == null) {
      return tenKhachhang = "";
    }
    return tenKhachhang!;
  }
}
