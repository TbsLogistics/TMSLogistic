import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/npt/sercurity/sercurity_check_car/modules/view_invote_screen.dart';
import 'package:tbs_logistics_tms/app/page/npt/sercurity/sercurity_check_car/widgets/print_table_data.dart';

import 'package:printing/printing.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class SaveBtnBuilder extends StatelessWidget {
  const SaveBtnBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        printDoc();
        // print("oke");
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => const ViewInvoteScreen()),
        // );
      },
      icon: const Icon(Icons.print),
    );
  }

  Future<void> printDoc() async {
    final image = await imageFromAssetBundle(
      "assets/images/appstore.png",
    );
    final font = await PdfGoogleFonts.nunitoExtraBold();
    final doc = pw.Document();
    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return buildPrintableData(image, font);
        }));
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }
}
