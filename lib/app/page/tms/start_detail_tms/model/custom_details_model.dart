import 'package:tbs_logistics_tms/app/page/tms/start_detail_tms/model/list_data_for_place_model.dart';

class ListCustomDetailsPlaceModel {
  List<ListDataForPlaceModel>? listDataForReciveEmpty;

  ListCustomDetailsPlaceModel({this.listDataForReciveEmpty});

  ListCustomDetailsPlaceModel.fromJson(Map<String, dynamic> json) {
    if (json['listDataForReciveEmpty'] != null) {
      listDataForReciveEmpty = <ListDataForPlaceModel>[];
      json['listDataForReciveEmpty'].forEach((v) {
        listDataForReciveEmpty!.add(ListDataForPlaceModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (listDataForReciveEmpty != null) {
      data['listDataForReciveEmpty'] =
          listDataForReciveEmpty!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  void add() {}
}
