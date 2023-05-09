// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tbs_logistics_tms/app/npt/driver/controller/setting_driver_controller.dart';
// import 'package:tbs_logistics_tms/app/npt/driver/view/change_password_/change_password_screen.dart';
// import 'package:tbs_logistics_tms/config/core/data/color.dart';

// class DriverSettings extends GetView<SettingDriverController> {
//   const DriverSettings({super.key});

//   final String routes = "/DRIVER_SETTINGS";

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return GetBuilder<SettingDriverController>(
//       init: SettingDriverController(),
//       builder: (controller) {
//         return Scaffold(
//           appBar: AppBar(
//             title: Text(
//               "Cài đặt",
//               style: TextStyle(
//                 color: Theme.of(context).primaryColorLight,
//               ),
//             ),
//             centerTitle: true,
//             backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//             leading: IconButton(
//               onPressed: () {
//                 Get.back();
//               },
//               icon: Icon(
//                 Icons.arrow_back_ios_new_outlined,
//                 size: 25,
//                 color: Theme.of(context).primaryColorLight,
//               ),
//             ),
//           ),
//           body: SingleChildScrollView(
//             child: SizedBox(
//               height: size.height,
//               width: size.width,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   ListTile(
//                     leading: Text(
//                       "Hồ sơ",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                         color: Theme.of(context).primaryColor,
//                       ),
//                     ),
//                   ),
//                   Obx(
//                     () => Column(
//                       children: [
//                         Card(
//                           shape: const RoundedRectangleBorder(
//                             side: BorderSide(
//                               color: Colors.orangeAccent,
//                             ),
//                           ),
//                           child: ListTile(
//                             leading: const Icon(Icons.person),
//                             title: const Text("Thông tin cá nhân"),
//                             trailing: IconButton(
//                                 onPressed: () {
//                                   controller.switchHideShow();
//                                 },
//                                 icon: Icon(
//                                   controller.hideShowMode.isFalse
//                                       ? Icons.keyboard_arrow_down_rounded
//                                       : Icons.keyboard_arrow_up_rounded,
//                                   size: 25,
//                                   color: Colors.orangeAccent,
//                                 )),
//                           ),
//                         ),
//                         controller.hideShowMode.isFalse
//                             ? Container()
//                             : Card(
//                                 shape: const RoundedRectangleBorder(
//                                     // borderRadius: BorderRadius.circular(80),
//                                     side: BorderSide(
//                                         color: CustomColor.backgroundAppbar)
//                                     //set border radius more than 50% of height and width to make circle
//                                     ),
//                                 child: Column(
//                                   children: [
//                                     ListTile(
//                                       leading: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: const [
//                                           Text(
//                                             "Họ và tên",
//                                             style: TextStyle(
//                                               color: Colors.orangeAccent,
//                                               fontSize: 15,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       title: Text(
//                                         "${controller.user.value.tenTaixe}",
//                                         style: TextStyle(
//                                           color: Theme.of(context).primaryColor,
//                                           fontSize: 14,
//                                         ),
//                                       ),
//                                     ),
//                                     ListTile(
//                                       leading: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: const [
//                                           Text(
//                                             "Số điện thoại",
//                                             style: TextStyle(
//                                               color: Colors.orangeAccent,
//                                               fontSize: 15,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       title: Text(
//                                         "${controller.user.value.phone}",
//                                         style: TextStyle(
//                                           color: Theme.of(context).primaryColor,
//                                           fontSize: 14,
//                                         ),
//                                       ),
//                                     ),
//                                     ListTile(
//                                       leading: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: const [
//                                           Text(
//                                             "CCCD",
//                                             style: TextStyle(
//                                               color: Colors.orangeAccent,
//                                               fontSize: 15,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       title: Text(
//                                         "${controller.user.value.cCCD}",
//                                         style: TextStyle(
//                                           color: Theme.of(context).primaryColor,
//                                           fontSize: 14,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               )
//                       ],
//                     ),
//                   ),
//                   ListTile(
//                     leading: Text(
//                       "Chức năng",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                         color: Theme.of(context).primaryColor,
//                       ),
//                     ),
//                   ),
//                   Card(
//                     shape: const RoundedRectangleBorder(
//                       side: BorderSide(
//                         color: Colors.orangeAccent,
//                       ),
//                     ),
//                     child: ListTile(
//                       leading: const Icon(Icons.light_mode),
//                       title: const Text("Chế độ tối"),
//                       trailing: CupertinoSwitch(
//                         activeColor: Colors.amber,
//                         value: controller.switchValue.value,
//                         onChanged: (value) {
//                           controller.switchValue.value = value;
//                           controller.switchLight(value);
//                           // print(value);
//                         },
//                       ),
//                     ),
//                   ),
//                   // Card(
//                   //   shape: const RoundedRectangleBorder(
//                   //     side: BorderSide(
//                   //       color: Colors.orangeAccent,
//                   //     ),
//                   //   ),
//                   //   child: ListTile(
//                   //     leading: const Icon(Icons.language),
//                   //     title: const Text("Change language"),
//                   //     trailing: CupertinoSwitch(
//                   //       activeColor: Colors.amber,
//                   //       value: controller.switchLanguage.value,
//                   //       onChanged: (value) {
//                   //         controller.switchLanguage.value = value;
//                   //         controller.switchLanguag();
//                   //       },
//                   //     ),
//                   //   ),
//                   // ),
//                   Card(
//                     shape: const RoundedRectangleBorder(
//                       side: BorderSide(
//                         color: Colors.orangeAccent,
//                       ),
//                     ),
//                     child: ListTile(
//                       onTap: () {
//                         Get.to(() => ChangePasswordDriverScreen());
//                       },
//                       leading: const Icon(Icons.lock),
//                       title: const Text("Đổi mật khẩu"),
//                     ),
//                   ),
//                   const Divider(
//                     height: 1,
//                     indent: 10,
//                     endIndent: 10,
//                     color: Colors.orangeAccent,
//                     thickness: 1,
//                   ),
//                   ListTile(
//                     onTap: () {},
//                     leading: const Icon(
//                       Icons.logout,
//                       color: Colors.redAccent,
//                     ),
//                     title: const Text(
//                       "Đăng xuất",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                         color: Colors.redAccent,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
