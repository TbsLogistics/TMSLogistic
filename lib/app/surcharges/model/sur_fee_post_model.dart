class SurFeeModel {
  int? placeId;
  int? sfId;
  int? finalPrice;
  String? note;

  SurFeeModel({
    this.placeId,
    this.sfId,
    this.finalPrice,
    this.note,
  });

  SurFeeModel.fromJson(Map<String, dynamic> json) {
    placeId = json['placeId'];
    sfId = json['sfId'];
    finalPrice = json['finalPrice'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['placeId'] = placeId;
    data['sfId'] = sfId;
    data['finalPrice'] = finalPrice;
    data['note'] = note;
    return data;
  }
}
