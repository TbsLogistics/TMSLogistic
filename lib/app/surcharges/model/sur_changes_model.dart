class SurChangesModel {
  int? idTcommand;
  String? transportId;
  int? placeId;
  int? sfId;
  String? sfName;
  int? finalPrice;
  String? note;

  SurChangesModel(
      {this.idTcommand,
      this.transportId,
      this.placeId,
      this.sfId,
      this.finalPrice,
      this.note,
      this.sfName});

  SurChangesModel.fromJson(Map<String, dynamic> json) {
    idTcommand = json['idTcommand'];
    transportId = json['transportId'];
    placeId = json['placeId'];
    sfId = json['sfId'];
    sfName = json['sfName'];
    finalPrice = json['finalPrice'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idTcommand'] = idTcommand;
    data['transportId'] = transportId;
    data['placeId'] = placeId;
    data['sfId'] = sfId;
    data['sfName'] = sfName;
    data['finalPrice'] = finalPrice;
    data['note'] = note;
    return data;
  }
}
