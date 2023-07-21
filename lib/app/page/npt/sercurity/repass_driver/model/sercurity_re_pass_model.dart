class SercurityRePassModel {
  String? cCCD;
  String? tenTaixe;
  String? email;
  String? phone;

  SercurityRePassModel({this.cCCD, this.tenTaixe, this.email, this.phone});

  SercurityRePassModel.fromJson(Map<String, dynamic> json) {
    cCCD = json['CCCD'];
    tenTaixe = json['tenTaixe'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CCCD'] = cCCD;
    data['tenTaixe'] = tenTaixe;
    data['email'] = email;
    data['phone'] = phone;
    return data;
  }
}
