class ChangePassHrmModel {
  String? currentPassword;
  String? newPassword;
  String? confirmPass;

  ChangePassHrmModel(
      {this.currentPassword, this.newPassword, this.confirmPass});

  ChangePassHrmModel.fromJson(Map<String, dynamic> json) {
    currentPassword = json['currentPassword'];
    newPassword = json['newPassword'];
    confirmPass = json['confirmPass'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['currentPassword'] = currentPassword;
    data['newPassword'] = newPassword;
    data['confirmPass'] = confirmPass;
    return data;
  }
}
