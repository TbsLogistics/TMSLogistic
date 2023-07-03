// ignore_for_file: unnecessary_this, unnecessary_question_mark, prefer_void_to_null

class ListRegisterDriverOfCustomerModel {
  int? maTaixe;
  String? tenTaixe;
  String? diaChi;
  String? email;
  String? cCCD;
  String? phone;
  Null? phieuvaoRe;
  bool? status;

  ListRegisterDriverOfCustomerModel(
      {this.maTaixe,
      this.tenTaixe,
      this.diaChi,
      this.email,
      this.cCCD,
      this.phone,
      this.phieuvaoRe,
      this.status});

  ListRegisterDriverOfCustomerModel.fromJson(Map<String, dynamic> json) {
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

  static List<ListRegisterDriverOfCustomerModel> fromJsonList(List list) {
    return list
        .map((item) => ListRegisterDriverOfCustomerModel.fromJson(item))
        .toList();
  }

  String userAsString() {
    return "#${this.maTaixe} ${this.tenTaixe}";
  }

  bool isEqual(ListRegisterDriverOfCustomerModel model) {
    return this.maTaixe == model.maTaixe;
  }

  @override
  String toString() => tenTaixe!;
}
