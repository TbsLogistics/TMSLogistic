// ignore_for_file: unnecessary_null_comparison

class ChartModel {
  String? title;
  List<TotalReports>? totalReports;
  List<String>? labels;
  List<DataTotal>? dataTotal;

  ChartModel({this.title, this.totalReports, this.labels, this.dataTotal});

  ChartModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['totalReports'] != null) {
      totalReports = <TotalReports>[];
      json['totalReports'].forEach((v) {
        totalReports!.add(TotalReports.fromJson(v));
      });
    }
    labels = json['labels'].cast<String>();
    if (json['data'] != null) {
      dataTotal = <DataTotal>[];
      json['data'].forEach((v) {
        dataTotal!.add(DataTotal.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    if (totalReports != null) {
      data['totalReports'] = totalReports!.map((v) => v.toJson()).toList();
    }
    data['labels'] = labels;
    if (dataTotal != null) {
      data['data'] = dataTotal!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TotalReports {
  String? title;
  int? totalInt;
  int? totalDouble;

  TotalReports({this.title, this.totalInt, this.totalDouble});

  TotalReports.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    totalInt = json['totalInt'];
    totalDouble = json['totalDouble'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['totalInt'] = totalInt;
    data['totalDouble'] = totalDouble;
    return data;
  }
}

class DataTotal {
  List<DataInt>? dataInt;
  List<DataDouble>? dataDouble;
  String? name;
  String? color;

  DataTotal({this.dataInt, this.dataDouble, this.name, this.color});

  DataTotal.fromJson(Map<String, dynamic> json) {
    if (json['dataInt'] != null) {
      dataInt = <DataInt>[];
      json['dataInt'].forEach((v) {
        dataInt!.add(DataInt.fromJson(v));
      });
    }
    dataDouble = json['dataDouble'];
    name = json['name'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (dataInt != null) {
      data['dataInt'] = dataInt!.map((v) => v.toJson()).toList();
    }
    data['dataDouble'] = dataDouble;
    data['name'] = name;
    data['color'] = color;
    return data;
  }
}

class DataInt {
  int? count;
  String? date;

  DataInt({this.count, this.date});

  DataInt.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['date'] = date;
    return data;
  }
}

class DataDouble {
  int? value;
  String? date;

  DataDouble({this.value, this.date});

  DataDouble.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['date'] = date;
    return data;
  }
}
