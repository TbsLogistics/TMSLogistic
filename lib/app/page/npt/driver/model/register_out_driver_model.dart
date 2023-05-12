class RegisterOutForDriverModel {
  Phieura? phieura;
  Maphieuvao? maphieuvao;

  RegisterOutForDriverModel({this.phieura, this.maphieuvao});

  RegisterOutForDriverModel.fromJson(Map<String, dynamic> json) {
    phieura =
        json['phieura'] != null ? Phieura.fromJson(json['phieura']) : null;
    maphieuvao = json['maphieuvao'] != null
        ? Maphieuvao.fromJson(json['maphieuvao'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (phieura != null) {
      data['phieura'] = phieura!.toJson();
    }
    if (maphieuvao != null) {
      data['maphieuvao'] = maphieuvao!.toJson();
    }
    return data;
  }
}

class Phieura {
  String? contRa1;
  String? contRa2;
  String? contRa1seal1;
  String? contRa1seal2;
  String? contRa2seal1;
  String? contRa2seal2;
  bool? trangthaihangra;
  bool? trangthaikhoara;
  bool? trangthaihangra1;
  bool? trangthaikhoara1;
  int? soKienra;
  int? sokhoira;
  String? soBookra;
  int? soKienra1;
  int? sokhoira1;
  String? soBookra1;

  Phieura(
      {this.contRa1,
      this.contRa2,
      this.contRa1seal1,
      this.contRa1seal2,
      this.contRa2seal1,
      this.contRa2seal2,
      this.trangthaihangra,
      this.trangthaikhoara,
      this.trangthaihangra1,
      this.trangthaikhoara1,
      this.soKienra,
      this.sokhoira,
      this.soBookra,
      this.soKienra1,
      this.sokhoira1,
      this.soBookra1});

  Phieura.fromJson(Map<String, dynamic> json) {
    contRa1 = json['contRa1'];
    contRa2 = json['contRa2'];
    contRa1seal1 = json['contRa1seal1'];
    contRa1seal2 = json['contRa1seal2'];
    contRa2seal1 = json['contRa2seal1'];
    contRa2seal2 = json['contRa2seal2'];
    trangthaihangra = json['trangthaihangra'];
    trangthaikhoara = json['trangthaikhoara'];
    trangthaihangra1 = json['trangthaihangra1'];
    trangthaikhoara1 = json['trangthaikhoara1'];
    soKienra = json['SoKienra'];
    sokhoira = json['sokhoira'];
    soBookra = json['soBookra'];
    soKienra1 = json['SoKienra1'];
    sokhoira1 = json['sokhoira1'];
    soBookra1 = json['soBookra1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['contRa1'] = contRa1;
    data['contRa2'] = contRa2;
    data['contRa1seal1'] = contRa1seal1;
    data['contRa1seal2'] = contRa1seal2;
    data['contRa2seal1'] = contRa2seal1;
    data['contRa2seal2'] = contRa2seal2;
    data['trangthaihangra'] = trangthaihangra;
    data['trangthaikhoara'] = trangthaikhoara;
    data['trangthaihangra1'] = trangthaihangra1;
    data['trangthaikhoara1'] = trangthaikhoara1;
    data['SoKienra'] = soKienra;
    data['sokhoira'] = sokhoira;
    data['soBookra'] = soBookra;
    data['SoKienra1'] = soKienra1;
    data['sokhoira1'] = sokhoira1;
    data['soBookra1'] = soBookra1;
    return data;
  }
}

class Maphieuvao {
  int? maphieuvao;

  Maphieuvao({this.maphieuvao});

  Maphieuvao.fromJson(Map<String, dynamic> json) {
    maphieuvao = json['maphieuvao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maphieuvao'] = maphieuvao;
    return data;
  }
}
