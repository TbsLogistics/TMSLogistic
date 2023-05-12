class LoginHrmModel {
  String? username;
  String? password;
  int? autogen;

  LoginHrmModel({
    required this.username,
    required this.password,
    required this.autogen,
  });
  LoginHrmModel.fromJson(Map<String, dynamic> json) {
    username = json["username"];
    password = json["password"];
    autogen = json["autogen"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["username"] = username;
    data["password"] = password;
    data["autogen"] = autogen;

    return data;
  }
}
