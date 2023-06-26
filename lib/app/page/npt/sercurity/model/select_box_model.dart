// ignore_for_file: prefer_void_to_null, unnecessary_question_mark

class SelectBoxModel {
  List<Loaixe>? loaixe;
  List<Loaihang>? loaihang;
  List<Kho>? kho;
  List<Cong>? cong;
  List<Khuvuc>? khuvuc;
  List<TrongTai>? trongTai;
  List<LoaiCont>? loaiCont;

  SelectBoxModel(
      {this.loaixe,
      this.loaihang,
      this.kho,
      this.cong,
      this.khuvuc,
      this.trongTai,
      this.loaiCont});

  SelectBoxModel.fromJson(Map<String, dynamic> json) {
    if (json['loaixe'] != null) {
      loaixe = <Loaixe>[];
      json['loaixe'].forEach((v) {
        loaixe!.add(Loaixe.fromJson(v));
      });
    }
    if (json['loaihang'] != null) {
      loaihang = <Loaihang>[];
      json['loaihang'].forEach((v) {
        loaihang!.add(Loaihang.fromJson(v));
      });
    }
    if (json['kho'] != null) {
      kho = <Kho>[];
      json['kho'].forEach((v) {
        kho!.add(Kho.fromJson(v));
      });
    }
    if (json['cong'] != null) {
      cong = <Cong>[];
      json['cong'].forEach((v) {
        cong!.add(Cong.fromJson(v));
      });
    }
    if (json['khuvuc'] != null) {
      khuvuc = <Khuvuc>[];
      json['khuvuc'].forEach((v) {
        khuvuc!.add(Khuvuc.fromJson(v));
      });
    }
    if (json['trongTai'] != null) {
      trongTai = <TrongTai>[];
      json['trongTai'].forEach((v) {
        trongTai!.add(TrongTai.fromJson(v));
      });
    }
    if (json['loaiCont'] != null) {
      loaiCont = <LoaiCont>[];
      json['loaiCont'].forEach((v) {
        loaiCont!.add(LoaiCont.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (loaixe != null) {
      data['loaixe'] = loaixe!.map((v) => v.toJson()).toList();
    }
    if (loaihang != null) {
      data['loaihang'] = loaihang!.map((v) => v.toJson()).toList();
    }
    if (kho != null) {
      data['kho'] = kho!.map((v) => v.toJson()).toList();
    }
    if (cong != null) {
      data['cong'] = cong!.map((v) => v.toJson()).toList();
    }
    if (khuvuc != null) {
      data['khuvuc'] = khuvuc!.map((v) => v.toJson()).toList();
    }
    if (trongTai != null) {
      data['trongTai'] = trongTai!.map((v) => v.toJson()).toList();
    }
    if (loaiCont != null) {
      data['loaiCont'] = loaiCont!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Loaixe {
  int? stt;
  String? maLoaiXe;
  String? tenLoaiXe;

  Loaixe({this.stt, this.maLoaiXe, this.tenLoaiXe});

  Loaixe.fromJson(Map<String, dynamic> json) {
    stt = json['stt'];
    maLoaiXe = json['maLoaiXe'];
    tenLoaiXe = json['tenLoaiXe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stt'] = stt;
    data['maLoaiXe'] = maLoaiXe;
    data['tenLoaiXe'] = tenLoaiXe;
    return data;
  }
}

class Loaihang {
  String? maloaiHang;
  String? tenLoaiHang;
  Null? chiTiet;

  Loaihang({this.maloaiHang, this.tenLoaiHang, this.chiTiet});

  Loaihang.fromJson(Map<String, dynamic> json) {
    maloaiHang = json['maloaiHang'];
    tenLoaiHang = json['tenLoaiHang'];
    chiTiet = json['chiTiet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maloaiHang'] = maloaiHang;
    data['tenLoaiHang'] = tenLoaiHang;
    data['chiTiet'] = chiTiet;
    return data;
  }
}

class Kho {
  String? maKho;
  String? maKhuVuc;
  bool? status;
  String? tenKho;

  Kho({this.maKho, this.maKhuVuc, this.status, this.tenKho});

  Kho.fromJson(Map<String, dynamic> json) {
    maKho = json['maKho'];
    maKhuVuc = json['maKhuVuc'];
    status = json['status'];
    tenKho = json['tenKho'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maKho'] = maKho;
    data['maKhuVuc'] = maKhuVuc;
    data['status'] = status;
    data['tenKho'] = tenKho;
    return data;
  }
}

class Cong {
  String? tenKhoTong;
  String? tencongBV;
  int? zone;
  int? maCong;

  Cong({this.tenKhoTong, this.tencongBV, this.zone, this.maCong});

  Cong.fromJson(Map<String, dynamic> json) {
    tenKhoTong = json['TenKhoTong'];
    tencongBV = json['tencongBV'];
    zone = json['Zone'];
    maCong = json['maCong'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TenKhoTong'] = tenKhoTong;
    data['tencongBV'] = tencongBV;
    data['Zone'] = zone;
    data['maCong'] = maCong;
    return data;
  }
}

class Khuvuc {
  String? tenKhoTong;

  Khuvuc({this.tenKhoTong});

  Khuvuc.fromJson(Map<String, dynamic> json) {
    tenKhoTong = json['TenKhoTong'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TenKhoTong'] = tenKhoTong;
    return data;
  }
}

class TrongTai {
  String? maLoaiXe;
  bool? status;
  String? tenTrongTai;
  int? stt;
  String? maTrongTai;

  TrongTai(
      {this.maLoaiXe,
      this.status,
      this.tenTrongTai,
      this.stt,
      this.maTrongTai});

  TrongTai.fromJson(Map<String, dynamic> json) {
    maLoaiXe = json['maLoaiXe'];
    status = json['status'];
    tenTrongTai = json['tenTrongTai'];
    stt = json['stt'];
    maTrongTai = json['maTrongTai'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maLoaiXe'] = maLoaiXe;
    data['status'] = status;
    data['tenTrongTai'] = tenTrongTai;
    data['stt'] = stt;
    data['maTrongTai'] = maTrongTai;
    return data;
  }
}

class LoaiCont {
  String? typeContCode;
  String? typeContname;
  bool? status;

  LoaiCont({this.typeContCode, this.typeContname, this.status});

  LoaiCont.fromJson(Map<String, dynamic> json) {
    typeContCode = json['typeContCode'];
    typeContname = json['typeContname'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['typeContCode'] = typeContCode;
    data['typeContname'] = typeContname;
    data['status'] = status;
    return data;
  }
}
