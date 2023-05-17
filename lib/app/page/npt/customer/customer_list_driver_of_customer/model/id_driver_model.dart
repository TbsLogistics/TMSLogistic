// ignore: camel_case_types
class idDriverModel {
  int? maTaixe;

  idDriverModel({this.maTaixe});

  idDriverModel.fromJson(Map<String, dynamic> json) {
    maTaixe = json['maTaixe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maTaixe'] = maTaixe;
    return data;
  }
}
