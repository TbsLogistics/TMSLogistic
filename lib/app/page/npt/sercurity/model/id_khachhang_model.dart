class StatusLevel {
  int? captrangthai;

  StatusLevel({this.captrangthai});

  StatusLevel.fromJson(Map<String, dynamic> json) {
    captrangthai = json['captrangthai'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['captrangthai'] = captrangthai;
    return data;
  }
}
