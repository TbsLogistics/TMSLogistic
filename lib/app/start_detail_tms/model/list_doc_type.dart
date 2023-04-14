// ignore_for_file: unnecessary_this, unnecessary_brace_in_string_interps

class ListDocTypeModel {
  int? maLoaiChungTu;
  String? tenLoaiChungTu;
  String? moTa;
  String? maLoaiDiaDiem;
  List<TepChungTu>? tepChungTu;

  ListDocTypeModel(
      {this.maLoaiChungTu,
      this.tenLoaiChungTu,
      this.moTa,
      this.maLoaiDiaDiem,
      this.tepChungTu});

  ListDocTypeModel.fromJson(Map<String?, dynamic> json) {
    maLoaiChungTu = json['maLoaiChungTu'];
    tenLoaiChungTu = json['tenLoaiChungTu'];
    moTa = json['moTa'];
    maLoaiDiaDiem = json['maLoaiDiaDiem'];
    if (json['tepChungTu'] != null) {
      tepChungTu = <TepChungTu>[];
      json['tepChungTu'].forEach((v) {
        tepChungTu!.add(TepChungTu.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maLoaiChungTu'] = maLoaiChungTu;
    data['tenLoaiChungTu'] = tenLoaiChungTu;
    data['moTa'] = moTa;
    data['maLoaiDiaDiem'] = maLoaiDiaDiem;
    if (tepChungTu != null) {
      data['tepChungTu'] = tepChungTu!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static List<ListDocTypeModel> fromJsonList(List list) {
    return list.map((item) => ListDocTypeModel.fromJson(item)).toList();
  }

  String userAsString() {
    return "#${this.tenLoaiChungTu} ${maLoaiChungTu}";
  }

  bool isEqual(ListDocTypeModel model) {
    return this.tenLoaiChungTu == model.tenLoaiChungTu;
  }

  @override
  String toString() => tenLoaiChungTu!;
}

class TepChungTu {
  int? loaiChungTu;
  String? tenChungTu;

  TepChungTu({this.loaiChungTu, this.tenChungTu});

  TepChungTu.fromJson(Map<String, dynamic> json) {
    loaiChungTu = json['loaiChungTu'];
    tenChungTu = json['tenChungTu'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['loaiChungTu'] = loaiChungTu;
    data['tenChungTu'] = tenChungTu;
    return data;
  }
}
