import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tbs_logistics_tms/app/page/tms/dashboard/model/table_data_model.dart';

class MySource extends DataTableSource {
  List<CustomerReports> dataTable;
  MySource(this.dataTable);

  @override
  DataRow getRow(int i) {
    return DataRow.byIndex(
      index: i,
      cells: [
        DataCell(Text(dataTable[i].customerName.toString())),
        DataCell(
          Center(
            child: Text(
                "${dataTable[i].totalBooking.toString()}/${dataTable[i].total.toString()}"),
          ),
        ),
        DataCell(Text(
            "${NumberFormat("#,##0", "vi_VN").format(dataTable[i].totalMoney)} VNĐ")),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => dataTable.length;

  @override
  int get selectedRowCount => 0;
}
