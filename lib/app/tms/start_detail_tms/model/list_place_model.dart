class ListPlaceModel {
  List<String>? placeReceiveEmpty;
  List<String>? placeReceive;
  List<String>? placeGive;
  List<String>? placeGiveEmpty;

  ListPlaceModel(
      {this.placeReceiveEmpty,
      this.placeReceive,
      this.placeGive,
      this.placeGiveEmpty});

  ListPlaceModel.fromJson(Map<String, dynamic> json) {
    placeReceiveEmpty = json['PlaceReceiveEmpty'].cast<String>();
    placeReceive = json['PlaceReceive'].cast<String>();
    placeGive = json['PlaceGive'].cast<String>();

    placeGiveEmpty = json['PlaceGiveEmpty'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PlaceReceiveEmpty'] = placeReceiveEmpty;
    data['PlaceReceive'] = placeReceive;
    data['PlaceGive'] = placeGive;
    if (placeGiveEmpty != []) {
      data['PlaceGiveEmpty'] = placeGiveEmpty;
    }

    return data;
  }
}
