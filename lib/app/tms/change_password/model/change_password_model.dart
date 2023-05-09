class ChangePasswordModel {
  String? oldPassword;
  String? newPassword;
  String? reNewPassword;

  ChangePasswordModel({this.oldPassword, this.newPassword, this.reNewPassword});

  ChangePasswordModel.fromJson(Map<String, dynamic> json) {
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
