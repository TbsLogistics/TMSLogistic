class LetterManagerApproveModel {
  int? regid;
  String? comment;
  int? state;

  LetterManagerApproveModel({this.regid, this.comment, this.state});

  LetterManagerApproveModel.fromJson(Map<String, dynamic> json) {
    regid = json['regid'];
    comment = json['comment'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['regid'] = regid;
    data['comment'] = comment;
    data['state'] = state;
    return data;
  }
}
