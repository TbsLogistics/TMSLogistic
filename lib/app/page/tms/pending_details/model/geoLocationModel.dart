class GeoLocationModel {
  int? placeId;
  String? gps;

  GeoLocationModel({this.placeId, this.gps});

  GeoLocationModel.fromJson(Map<String, dynamic> json) {
    placeId = json['placeId'];
    gps = json['gps'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['placeId'] = placeId;
    data['gps'] = gps;
    return data;
  }
}
