import 'package:tbs_logistics_tms/app/page/tms/wait/model/tms_order_model.dart';

class ListDataForPlaceModel {
  String? place;
  List<GetDataHandlingMobiles>? getData;

  ListDataForPlaceModel({this.place, this.getData});

  ListDataForPlaceModel.fromJson(Map<String, dynamic> json) {
    place = json['Place'];
    if (json['getData'] != null) {
      getData = <GetDataHandlingMobiles>[];
      json['getData'].forEach((v) {
        getData!.add(GetDataHandlingMobiles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Place'] = place;
    if (getData != null) {
      data['getData'] = getData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
