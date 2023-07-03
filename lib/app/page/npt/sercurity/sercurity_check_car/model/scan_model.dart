class ScanModel {
  String? cCCD;
  String? driverInOutWarehouseCode;

  ScanModel({required this.cCCD, required this.driverInOutWarehouseCode});

  ScanModel.fromJson(Map<String, dynamic> json) {
    cCCD = json['CCCD'];
    driverInOutWarehouseCode = json['driverInOutWarehouseCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CCCD'] = cCCD;
    data['driverInOutWarehouseCode'] = driverInOutWarehouseCode;
    return data;
  }
}
