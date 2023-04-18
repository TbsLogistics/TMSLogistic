class UserModel {
  String? sub;
  String? jti;
  String? iat;
  String? userId;
  String? userName;
  String? fullName;
  String? department;
  String? accType;
  String? role;
  int? exp;
  String? iss;
  String? aud;

  UserModel(
      {this.sub,
      this.jti,
      this.iat,
      this.userId,
      this.userName,
      this.fullName,
      this.department,
      this.accType,
      this.role,
      this.exp,
      this.iss,
      this.aud});

  UserModel.fromJson(Map<String, dynamic> json) {
    sub = json['sub'];
    jti = json['jti'];
    iat = json['iat'];
    userId = json['UserId'];
    userName = json['UserName'];
    fullName = json['FullName'];
    department = json['Department'];
    accType = json['AccType'];
    role = json['Role'];
    exp = json['exp'];
    iss = json['iss'];
    aud = json['aud'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sub'] = sub;
    data['jti'] = jti;
    data['iat'] = iat;
    data['UserId'] = userId;
    data['UserName'] = userName;
    data['FullName'] = fullName;
    data['Department'] = department;
    data['AccType'] = accType;
    data['Role'] = role;
    data['exp'] = exp;
    data['iss'] = iss;
    data['aud'] = aud;
    return data;
  }
}
