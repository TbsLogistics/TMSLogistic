class UserHrmModel {
  int? exp;
  String? username;

  UserHrmModel({this.exp, this.username});

  UserHrmModel.fromJson(Map<String, dynamic> json) {
    exp = json['exp'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['exp'] = exp;
    data['username'] = username;
    return data;
  }
}
