class ChangeStatusTrackingInModel {
  int? maPhieuvao;

  int? maCong;

  ChangeStatusTrackingInModel({
    this.maPhieuvao,
    this.maCong,
  });

  ChangeStatusTrackingInModel.fromJson(Map<String, dynamic> json) {
    maPhieuvao = json['maPhieuvao'];

    maCong = json['maCong'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maPhieuvao'] = maPhieuvao;

    data['maCong'] = maCong;

    return data;
  }
}
