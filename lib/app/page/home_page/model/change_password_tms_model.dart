class ChangePassTmsModel {
  String? oldPassword;
  String? newPassword;
  String? reNewPassword;

  ChangePassTmsModel({this.oldPassword, this.newPassword, this.reNewPassword});

  ChangePassTmsModel.fromJson(Map<String, dynamic> json) {
    oldPassword = json['oldPassword'];
    newPassword = json['newPassword'];
    reNewPassword = json['reNewPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['oldPassword'] = oldPassword;
    data['newPassword'] = newPassword;
    data['reNewPassword'] = reNewPassword;
    return data;
  }
}
