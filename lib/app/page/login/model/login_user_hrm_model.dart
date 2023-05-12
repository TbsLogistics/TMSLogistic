class LoginUserHrmModel {
  int? rCode;
  RData? rData;
  String? rMsg;

  LoginUserHrmModel({this.rCode, this.rData, this.rMsg});

  LoginUserHrmModel.fromJson(Map<String, dynamic> json) {
    rCode = json['rCode'];
    rData = json['rData'] != null ? RData.fromJson(json['rData']) : null;
    rMsg = json['rMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rCode'] = rCode;
    if (rData != null) {
      data['rData'] = rData!.toJson();
    }
    data['rMsg'] = rMsg;
    return data;
  }
}

class RData {
  String? token;
  int? empid;

  RData({this.token, this.empid});

  RData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    empid = json['empid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['empid'] = empid;
    return data;
  }
}
