// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:get/get.dart';
// import 'package:tbs_logistics_tms/app/config/data/text_style.dart';
// import 'package:tbs_logistics_tms/app/page/npt/sercurity/model/detail_entry_vote_model.dart';
// import 'package:tbs_logistics_tms/app/page/npt/sercurity/sercurity_check_car/controller/sercurity_check_car_controller.dart';

// class SercurityCarOutScreen extends GetView<SercurityCheckCarController> {
//   const SercurityCarOutScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//         child: Column(
//       children: [
//         _buildCustomer(
//           // items: controller.detailEntryVote.value,
//           size: size,
//           context: context,
//           controller: controller,
//           title: "Khu vực",
//           content: "${controller.detailEntryVote.value.khuVuc!.tenKhuVuc}",
//         ),
//         _buildCustomer(
//           // items: controller.detailEntryVote.value,
//           size: size,
//           context: context,
//           controller: controller,
//           title: "Cổng",
//           content: "${controller.idDoor.value}",
//         ),
//         _buildCustomer(
//           // items: controller.detailEntryVote.value,
//           size: size,
//           context: context,
//           controller: controller,
//           title: "Kho",
//           content: "${controller.detailEntryVote.value.phieuvao!.kho!.tenKho}",
//         ),
//         _buildCustomer(
//           // items: controller.detailEntryVote.value,
//           size: size,
//           context: context,
//           controller: controller,
//           title: "Khách hàng ",
//           content:
//               "${controller.detailEntryVote.value.khachhangRe!.tenKhachhang}",
//         ),
//         _buildCustomer(
//           // items: controller.detailEntryVote.value,
//           size: size,
//           context: context,
//           controller: controller,
//           title: "Tên tài xế",
//           content: "${controller.detailEntryVote.value.taixeRe!.tenTaixe}",
//         ),
//         _buildCustomer(
//           // items: controller.detailEntryVote.value,
//           size: size,
//           context: context,
//           controller: controller,
//           title: "CCCD",
//           content: "${controller.detailEntryVote.value.taixeRe!.cCCD}",
//           icon: Icons.qr_code_2_outlined,
//           onPressed: () {
//             controller.scanQr(idCode: "CCCD");
//           },
//         ),
//         _buildCustomer(
//           // items: controller.detailEntryVote.value,
//           size: size,
//           context: context,
//           controller: controller,
//           title: "Số điện thoại",
//           content: "${controller.detailEntryVote.value.taixeRe!.phone}",
//         ),
//         _buildCustomer(
//           // items: controller.detailEntryVote.value,
//           size: size,
//           context: context,
//           controller: controller,
//           title: "Loại xe",
//           content: "${controller.detailEntryVote.value.loaixeRe!.tenLoaiXe}",
//         ),
//         _buildCustomerConvert(
//           // items: controller.detailEntryVote.value,
//           sizeFont: 20,
//           size: size,
//           context: context,
//           controller: controller,
//           title: "Số xe",
//           content: "${controller.detailEntryVote.value.phieuvao!.soxe}",
//         ),
//         controller.detailEntryVote.value.loaixeRe!.maLoaiXe == "tai"
//             ? _buildProductCar(
//                 controller.detailEntryVote.value,
//                 size,
//                 context,
//               )
//             : _buildProductCont(
//                 controller.detailEntryVote.value,
//                 size,
//                 context,
//                 controller,
//               ),
//       ],
//     ));
//   }
// }

// Widget _buildCustomerConvert({
//   // required DetailEntryVoteModel items,
//   required String title,
//   required String content,
//   required Size size,
//   required BuildContext context,
//   required SercurityCheckCarController controller,
//   VoidCallback? onPressed,
//   IconData? icon,
//   required double sizeFont,
// }) {
//   return Card(
//     shadowColor: Colors.grey,
//     elevation: 10,
//     shape: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(15),
//       borderSide: const BorderSide(
//         color: Colors.orangeAccent,
//         width: 1,
//       ),
//     ),
//     child: Container(
//       height: size.width * 0.1,
//       decoration: BoxDecoration(
//         border: Border.all(
//           width: 1,
//           color: Colors.orangeAccent,
//         ),
//         borderRadius: BorderRadius.circular(15),
//         // color: Colors.white,
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Expanded(
//             flex: 1,
//             child: Padding(
//               padding: const EdgeInsets.only(left: 10),
//               child: Text(
//                 title,
//                 style: const TextStyle(
//                   color: Colors.green,
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 2,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(left: 10),
//                   child: Text(
//                     content,
//                     style: TextStyle(
//                       fontSize: sizeFont,
//                       color: Colors.red,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: onPressed,
//                   icon: Icon(icon),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     ),
//   );
// }

// Widget _buildCustomer({
//   // required DetailEntryVoteModel items,
//   required String title,
//   required String content,
//   required Size size,
//   required BuildContext context,
//   required SercurityCheckCarController controller,
//   VoidCallback? onPressed,
//   IconData? icon,
// }) {
//   return Card(
//     shadowColor: Colors.grey,
//     elevation: 10,
//     shape: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(15),
//       borderSide: const BorderSide(
//         color: Colors.orangeAccent,
//         width: 1,
//       ),
//     ),
//     child: Container(
//       height: size.width * 0.1,
//       decoration: BoxDecoration(
//         border: Border.all(
//           width: 1,
//           color: Colors.orangeAccent,
//         ),
//         borderRadius: BorderRadius.circular(15),
//         // color: Colors.white,
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Expanded(
//             flex: 1,
//             child: Padding(
//               padding: const EdgeInsets.only(left: 10),
//               child: Text(
//                 title,
//                 style: const TextStyle(
//                   color: Colors.green,
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 2,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(left: 10),
//                   child: Text(
//                     content,
//                     style: TextStyle(
//                         fontSize: 16,
//                         color: Theme.of(context).primaryColorLight),
//                   ),
//                 ),
//                 IconButton(onPressed: onPressed, icon: Icon(icon))
//               ],
//             ),
//           )
//         ],
//       ),
//     ),
//   );
// }

// Widget _buildProductCar(
//     DetailEntryVoteModel items, Size size, BuildContext context) {
//   return Card(
//     shadowColor: Colors.grey,
//     elevation: 10,
//     shape: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(15),
//       borderSide: const BorderSide(
//         color: Colors.orangeAccent,
//         width: 1,
//       ),
//     ),
//     child: Container(
//       height: size.width * 0.4,
//       decoration: BoxDecoration(
//         border: Border.all(
//           width: 1,
//           color: Colors.orangeAccent,
//         ),
//         borderRadius: BorderRadius.circular(15),
//         // color: Colors.white,
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Expanded(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Expanded(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       const Text(
//                         "Số seal",
//                         style: CustomTextStyle.titleDetails,
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Text(
//                         "${items.phieuvao!.cont1seal1}",
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Theme.of(context).primaryColorLight,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 10),
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             const Text(
//                               "Số Book : ",
//                               style: CustomTextStyle.titleDetails,
//                             ),
//                             Text(
//                               "${items.phieuvao!.soBook}",
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 color: Theme.of(context).primaryColorLight,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 10),
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             const Text(
//                               "Kg/ CBM/ Số Kiện :",
//                               style: CustomTextStyle.titleDetails,
//                             ),
//                             Expanded(
//                               child: Text(
//                                 " ${items.phieuvao!.soTan}/ ${items.phieuvao!.sokhoi}/ ${items.phieuvao!.soKien}",
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   color: Theme.of(context).primaryColorLight,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

// Widget _buildProductCont(DetailEntryVoteModel items, Size size,
//     BuildContext context, SercurityCheckCarController controller) {
//   return Card(
//     shadowColor: Colors.grey,
//     elevation: 10,
//     shape: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(15),
//       borderSide: const BorderSide(
//         color: Colors.orangeAccent,
//         width: 1,
//       ),
//     ),
//     child: Container(
//       height: size.width * 0.7,
//       decoration: BoxDecoration(
//         border: Border.all(
//           width: 1,
//           color: Colors.orangeAccent,
//         ),
//         borderRadius: BorderRadius.circular(15),
//         // color: Colors.white,
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Expanded(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Expanded(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       const Text(
//                         "Số cont 1",
//                         style: CustomTextStyle.titleDetails,
//                       ),
//                       Text(
//                         "${items.phieuvao!.socont1}",
//                         style: CustomTextStyle.contentDetailsCont,
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 10),
//                     child: Column(
//                       children: [
//                         const Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Số seal 1",
//                               style: CustomTextStyle.titleDetails,
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 5),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text(
//                               "${items.phieuvao!.cont1seal1}",
//                               style: CustomTextStyle.contentDetailsCont,
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 10),
//                     child: Column(
//                       children: [
//                         const Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Số seal 2",
//                               style: CustomTextStyle.titleDetails,
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 5),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text(
//                               "${items.phieuvao!.cont1seal2}",
//                               style: CustomTextStyle.contentDetailsCont,
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 10),
//                     child: Column(
//                       children: [
//                         const Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Số Book",
//                               style: CustomTextStyle.titleDetails,
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 5),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text(
//                               "${items.phieuvao!.soBook}",
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 color: Theme.of(context).primaryColorLight,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 10),
//                     child: Column(
//                       children: [
//                         const Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Kg/ CBM/ Số Kiện",
//                               style: CustomTextStyle.titleDetails,
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 5),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               child: Text(
//                                 "${items.phieuvao!.soTan}/${items.phieuvao!.sokhoi}/${items.phieuvao!.soKien}",
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   color: Theme.of(context).primaryColorLight,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const VerticalDivider(
//             width: 1,
//             indent: 15,
//             endIndent: 15,
//             color: Colors.orangeAccent,
//             thickness: 1,
//           ),
//           Expanded(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Expanded(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       const Text(
//                         "Số cont 2",
//                         style: CustomTextStyle.titleDetails,
//                       ),
//                       Text(
//                         "${items.phieuvao!.socont2}",
//                         style: CustomTextStyle.contentDetailsCont,
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 10),
//                     child: Column(
//                       children: [
//                         const Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Số seal 1",
//                               style: CustomTextStyle.titleDetails,
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 5),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text(
//                               "${items.phieuvao!.cont2seal1}",
//                               style: CustomTextStyle.contentDetailsCont,
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 10),
//                     child: Column(
//                       children: [
//                         const Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Số seal 2",
//                               style: CustomTextStyle.titleDetails,
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 5),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text(
//                               "${items.phieuvao!.cont2seal2}",
//                               style: CustomTextStyle.contentDetailsCont,
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 10),
//                     child: Column(
//                       children: [
//                         const Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Số Book",
//                               style: CustomTextStyle.titleDetails,
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 5),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text(
//                               "${items.phieuvao!.soBook1}",
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 color: Theme.of(context).primaryColorLight,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 10),
//                     child: Column(
//                       children: [
//                         const Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Kg/ CBM/ Số Kiện",
//                               style: CustomTextStyle.titleDetails,
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 5),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               child: Text(
//                                 "${items.phieuvao!.soTan1}/${items.phieuvao!.sokhoi1}/${items.phieuvao!.sokien1}",
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   color: Theme.of(context).primaryColorLight,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     ),
//   );
// }

// void getDialogMessage(String messageText, VoidCallback onPressedConfirm) {
//   Get.defaultDialog(
//     backgroundColor: Colors.white,
//     title: "Thông báo",
//     titleStyle: const TextStyle(
//         color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
//     content: SizedBox(
//       height: 60,
//       width: 220,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Expanded(
//                 child: Text(
//                   messageText,
//                   style: const TextStyle(
//                     color: Colors.orangeAccent,
//                     fontSize: 16,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     ),
//     cancel: Container(
//       height: 40,
//       width: 120,
//       decoration: BoxDecoration(
//         color: Colors.orangeAccent,
//         borderRadius: BorderRadius.circular(15),
//         border: Border.all(
//           color: Colors.white,
//           width: 1,
//         ),
//       ),
//       child: TextButton(
//         onPressed: () {
//           Get.back();
//         },
//         child: const Text(
//           "Trở về",
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 14,
//           ),
//         ),
//       ),
//     ),
//     confirm: Container(
//       height: 40,
//       width: 120,
//       decoration: BoxDecoration(
//         color: Colors.orangeAccent,
//         borderRadius: BorderRadius.circular(15),
//         border: Border.all(
//           color: Colors.white,
//           width: 1,
//         ),
//       ),
//       child: TextButton(
//         onPressed: onPressedConfirm,
//         child: const Text(
//           "Xác nhận",
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 14,
//           ),
//         ),
//       ),
//     ),
//   );
// }

// Widget inputSubmit(Size size, VoidCallback onPressed) {
//   return Container(
//     margin: EdgeInsets.symmetric(
//         horizontal: size.width * 0.05, vertical: size.width * 0.025),
//     decoration: BoxDecoration(
//       color: Colors.orangeAccent.withOpacity(0.8),
//       border: Border.all(
//         width: 1,
//         color: Colors.orangeAccent.withOpacity(0.4),
//       ),
//       borderRadius: const BorderRadius.all(
//         Radius.circular(20.0),
//       ),
//     ),
//     width: size.width * 0.8,
//     height: 60,
//     child: TextButton(
//       onPressed: onPressed,
//       child: const Text(
//         "Xác nhận ra",
//         style: TextStyle(
//           color: Colors.white,
//           fontSize: 18,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     ),
//   );
// }
