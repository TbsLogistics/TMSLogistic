class LetterManagerApproveAllModel {
  List<int>? regid;
  String? comment;
  int? state;

  LetterManagerApproveAllModel({this.regid, this.comment, this.state});

  LetterManagerApproveAllModel.fromJson(Map<String, dynamic> json) {
    regid = json['regid'].cast<int>();
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
