class ListDriverForCustomerModel {
  int? maTaixe;
  String? tenTaixe;
  String? diaChi;
  String? email;
  String? cCCD;
  String? phone;
  Null? phieuvaoRe;
  bool? status;

  ListDriverForCustomerModel(
      {this.maTaixe,
      this.tenTaixe,
      this.diaChi,
      this.email,
      this.cCCD,
      this.phone,
      this.phieuvaoRe,
      this.status});

  ListDriverForCustomerModel.fromJson(Map<String, dynamic> json) {
    maTaixe = json['maTaixe'];
    tenTaixe = json['tenTaixe'];
    diaChi = json['diaChi'];
    email = json['email'];
    cCCD = json['CCCD'];
    phone = json['phone'];
    phieuvaoRe = json['phieuvao_re'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maTaixe'] = maTaixe;
    data['tenTaixe'] = tenTaixe;
    data['diaChi'] = diaChi;
    data['email'] = email;
    data['CCCD'] = cCCD;
    data['phone'] = phone;
    data['phieuvao_re'] = phieuvaoRe;
    data['status'] = status;
    return data;
  }

  static List<ListDriverForCustomerModel> fromJsonList(List list) {
    return list
        .map((item) => ListDriverForCustomerModel.fromJson(item))
        .toList();
  }

  String userAsString() {
    // ignore: unnecessary_this
    return "#${this..maTaixe} ${this.tenTaixe}";
  }

  bool isEqual(ListDriverForCustomerModel model) {
    // ignore: unnecessary_this
    return this.tenTaixe == model.tenTaixe;
  }

  @override
  String toString() {
    if (tenTaixe == null) {
      return tenTaixe = "";
    }
    return tenTaixe!;
  }
}
