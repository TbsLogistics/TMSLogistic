class DetailsUserModel {
  String? role;
  String? userid;

  DetailsUserModel({this.role, this.userid});

  DetailsUserModel.fromJson(Map<String, dynamic> json) {
    role = json['role'];
    userid = json['userid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['role'] = role;
    data['userid'] = userid;
    return data;
  }
}
