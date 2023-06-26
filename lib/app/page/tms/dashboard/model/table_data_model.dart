class TableDataModel {
  List<CustomerReports>? customerReports;
  List<CustomerReports>? supllierReports;

  TableDataModel({this.customerReports, this.supllierReports});

  TableDataModel.fromJson(Map<String, dynamic> json) {
    if (json['customerReports'] != null) {
      customerReports = <CustomerReports>[];
      json['customerReports'].forEach((v) {
        customerReports!.add(CustomerReports.fromJson(v));
      });
    }
    if (json['supllierReports'] != null) {
      supllierReports = <CustomerReports>[];
      json['supllierReports'].forEach((v) {
        supllierReports!.add(CustomerReports.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (customerReports != null) {
      data['customerReports'] =
          customerReports!.map((v) => v.toJson()).toList();
    }
    if (supllierReports != null) {
      data['supllierReports'] =
          supllierReports!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerReports {
  String? customerName;
  int? totalBooking;
  int? total;
  int? totalMoney;
  int? totalSf;
  int? profit;
  int? conT20;
  int? conT40;
  int? conT40RF;
  int? conT45;
  int? trucK1;
  int? trucK15;
  int? trucK17;
  int? trucK10;
  int? trucK150;
  int? trucK2;
  int? trucK25;
  int? trucK3;
  int? trucK35;
  int? trucK5;
  int? trucK7;
  int? trucK8;
  int? trucK9;

  CustomerReports(
      {this.customerName,
      this.totalBooking,
      this.total,
      this.totalMoney,
      this.totalSf,
      this.profit,
      this.conT20,
      this.conT40,
      this.conT40RF,
      this.conT45,
      this.trucK1,
      this.trucK15,
      this.trucK17,
      this.trucK10,
      this.trucK150,
      this.trucK2,
      this.trucK25,
      this.trucK3,
      this.trucK35,
      this.trucK5,
      this.trucK7,
      this.trucK8,
      this.trucK9});

  CustomerReports.fromJson(Map<String, dynamic> json) {
    customerName = json['customerName'];
    totalBooking = json['totalBooking'];
    total = json['total'];
    totalMoney = json['totalMoney'];
    totalSf = json['totalSf'];
    profit = json['profit'];
    conT20 = json['conT20'];
    conT40 = json['conT40'];
    conT40RF = json['conT40RF'];
    conT45 = json['conT45'];
    trucK1 = json['trucK1'];
    trucK15 = json['trucK15'];
    trucK17 = json['trucK17'];
    trucK10 = json['trucK10'];
    trucK150 = json['trucK150'];
    trucK2 = json['trucK2'];
    trucK25 = json['trucK25'];
    trucK3 = json['trucK3'];
    trucK35 = json['trucK35'];
    trucK5 = json['trucK5'];
    trucK7 = json['trucK7'];
    trucK8 = json['trucK8'];
    trucK9 = json['trucK9'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customerName'] = customerName;
    data['totalBooking'] = totalBooking;
    data['total'] = total;
    data['totalMoney'] = totalMoney;
    data['totalSf'] = totalSf;
    data['profit'] = profit;
    data['conT20'] = conT20;
    data['conT40'] = conT40;
    data['conT40RF'] = conT40RF;
    data['conT45'] = conT45;
    data['trucK1'] = trucK1;
    data['trucK15'] = trucK15;
    data['trucK17'] = trucK17;
    data['trucK10'] = trucK10;
    data['trucK150'] = trucK150;
    data['trucK2'] = trucK2;
    data['trucK25'] = trucK25;
    data['trucK3'] = trucK3;
    data['trucK35'] = trucK35;
    data['trucK5'] = trucK5;
    data['trucK7'] = trucK7;
    data['trucK8'] = trucK8;
    data['trucK9'] = trucK9;
    return data;
  }
}
