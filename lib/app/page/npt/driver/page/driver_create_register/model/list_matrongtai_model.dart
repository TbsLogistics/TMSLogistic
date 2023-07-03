class ListMaTrongTai {
  int? stt;
  String? maTrongTai;
  bool? status;
  String? tenTrongTai;
  String? maLoaiXe;

  ListMaTrongTai(
      {this.stt,
      this.maTrongTai,
      this.status,
      this.tenTrongTai,
      this.maLoaiXe});

  ListMaTrongTai.fromJson(Map<String, dynamic> json) {
    stt = json['stt'];
    maTrongTai = json['maTrongTai'];
    status = json['status'];
    tenTrongTai = json['tenTrongTai'];
    maLoaiXe = json['maLoaiXe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stt'] = stt;
    data['maTrongTai'] = maTrongTai;
    data['status'] = status;
    data['tenTrongTai'] = tenTrongTai;
    data['maLoaiXe'] = maLoaiXe;
    return data;
  }

  static List<ListMaTrongTai> fromJsonList(List list) {
    return list.map((item) => ListMaTrongTai.fromJson(item)).toList();
  }

  String userAsString() {
    return "#${this.maTrongTai} ${this.maLoaiXe} ${this.tenTrongTai}";
  }

  bool isEqual(ListMaTrongTai model) {
    return this.tenTrongTai == model.tenTrongTai;
  }

  @override
  String toString() {
    if (tenTrongTai == null) {
      return tenTrongTai = "";
    }
    return tenTrongTai!;
  }
}
