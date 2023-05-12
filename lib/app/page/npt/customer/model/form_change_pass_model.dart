class FormChangePasswordModel {
  String? oldPassword;
  String? confirmPassword;
  String? newPassword;

  FormChangePasswordModel(
      {this.oldPassword, this.confirmPassword, this.newPassword});

  FormChangePasswordModel.fromJson(Map<String, dynamic> json) {
    oldPassword = json['oldPassword'];
    confirmPassword = json['confirmPassword'];
    newPassword = json['newPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['oldPassword'] = oldPassword;
    data['confirmPassword'] = confirmPassword;
    data['newPassword'] = newPassword;
    return data;
  }
}
