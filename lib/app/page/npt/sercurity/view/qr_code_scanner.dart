// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart' hide Response;
// import 'package:qr_code_scanner/qr_code_scanner.dart';


// class QrCodeScannerScreen extends StatefulWidget {
//   const QrCodeScannerScreen({Key? key}) : super(key: key);

//   @override
//   State<StatefulWidget> createState() => _QrCodeScannerScreenState();
// }

// class _QrCodeScannerScreenState extends State<QrCodeScannerScreen> {
//   Barcode? result;
//   QRViewController? controller;
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

//   // In order to get hot reload to work we need to pause the camera if the platform
//   // is android, or resume the camera if the platform is iOS.

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     controller?.resumeCamera();
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: CustomColor.backgroundAppbar,
//         leading: IconButton(
//           onPressed: () {
//             Get.back();
//           },
//           icon: const Icon(
//             Icons.arrow_back_ios_new,
//             size: 25,
//             color: Colors.white,
//           ),
//         ),
//         title: const Text(
//           "Quét mã",
//           style: CustomTextStyle.tilteAppbar,
//         ),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(flex: 3, child: _buildQrView(context, size)),
//           Expanded(flex: 1, child: Container())
//         ],
//       ),
//     );
//   }

//   Widget _buildQrView(BuildContext context, Size size) {
//     return QRView(
//       key: qrKey,
//       onQRViewCreated: _onQRViewCreated,
//       overlay: QrScannerOverlayShape(
//           borderColor: Colors.orangeAccent.shade200,
//           borderRadius: 10,
//           borderLength: 30,
//           borderWidth: 10,
//           cutOutSize: size.width * 0.6),
//     );
//   }

//   void _onQRViewCreated(QRViewController controller) {
//     setState(() {
//       this.controller = controller;
//     });
//     controller.scannedDataStream.listen((scanData) {
//       setState(() {
//         result = scanData;
//       });

//       if (result != null) {
//         // print(
//         //     "Result"); // if you want to do any action with qr result then do code is here
//         // print(result!.code);
//         setState(() {
//           var mataixe = int.parse(result!.code.toString());
//           getModel(mataixe);
//         });
//       }
//     });
//   }

//   Future<void> getModel(int? mataixe) async {
//     var dio = Dio();
//     Response response;
//     const url = "http://192.168.3.59:200/LayThongTinPhieuVaoBangMaTaiXe";
//     var id = idTaixeModel(maTaixe: mataixe);
//     var jsonData = id.toJson();

//     response = await dio.post(url, data: jsonData);
//     if (response.statusCode == 200) {
//       // print("oke");
//       Get.defaultDialog(
//         title: "alo",
//         confirm: TextButton(
//           onPressed: () {},
//           child: const Text("data"),
//         ),
//       );
//       var data = response.data;
//       return data;
//     }
//     return response.data;
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
// }
