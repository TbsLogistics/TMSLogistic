// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tbs_logistics_dangtai/app/driver/controller/change_password_controller.dart';

// // ignore: must_be_immutable
// class ChangePasswordDriverScreen
//     extends GetView<ChangePasswordDriverController> {
//   ChangePasswordDriverScreen({super.key});
//   @override
//   var controller = Get.put(ChangePasswordDriverController());

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Thay đổi mật khẩu",
//           style: TextStyle(
//             color: Theme.of(context).primaryColorLight,
//           ),
//         ),
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         centerTitle: true,
//         leading: IconButton(
//           onPressed: () {
//             Get.back();
//           },
//           icon: Icon(
//             Icons.arrow_back_ios_new_rounded,
//             size: 25,
//             color: Theme.of(context).primaryColorLight,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
//           child: Column(
//             children: [
//               TextField(
//                 controller: controller.passwordOld,
//                 decoration: InputDecoration(
//                     focusedBorder: const OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.green, width: 2.0),
//                     ),
//                     enabledBorder: const OutlineInputBorder(
//                       borderSide:
//                           BorderSide(color: Colors.orangeAccent, width: 2.0),
//                     ),
//                     border: const OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.orangeAccent)),
//                     hintText: 'Nhập mật khẩu cũ',
//                     labelText: 'Mật khẩu cũ',
//                     labelStyle: TextStyle(
//                       color: Theme.of(context).primaryColor,
//                     ),
//                     prefixIcon: const Icon(
//                       Icons.lock,
//                       color: Colors.orangeAccent,
//                     ),
//                     prefixText: ' ',
//                     suffixStyle: const TextStyle(color: Colors.green)),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               TextField(
//                 controller: controller.passwordNew,
//                 decoration: InputDecoration(
//                     focusedBorder: const OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.green, width: 2.0),
//                     ),
//                     enabledBorder: const OutlineInputBorder(
//                       borderSide:
//                           BorderSide(color: Colors.orangeAccent, width: 2.0),
//                     ),
//                     border: const OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.teal)),
//                     hintText: 'Nhập mật khẩu mơi',
//                     labelText: 'Mật khẩu mới',
//                     labelStyle: TextStyle(
//                       color: Theme.of(context).primaryColor,
//                     ),
//                     prefixIcon: const Icon(
//                       Icons.lock,
//                       color: Colors.orangeAccent,
//                     ),
//                     prefixText: ' ',
//                     suffixStyle: const TextStyle(color: Colors.green)),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               TextField(
//                 controller: controller.rePasswordNew,
//                 decoration: InputDecoration(
//                     focusedBorder: const OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.green, width: 2.0),
//                     ),
//                     enabledBorder: const OutlineInputBorder(
//                       borderSide:
//                           BorderSide(color: Colors.orangeAccent, width: 2.0),
//                     ),
//                     border: const OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.teal)),
//                     hintText: 'Nhập lại mật khẩu mới',
//                     labelText: 'Mật khẩu mới',
//                     labelStyle: TextStyle(
//                       color: Theme.of(context).primaryColor,
//                     ),
//                     prefixIcon: const Icon(
//                       Icons.lock,
//                       color: Colors.orangeAccent,
//                     ),
//                     prefixText: ' ',
//                     suffixStyle: const TextStyle(color: Colors.green)),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               SizedBox(
//                 height: 60,
//                 width: size.width * 0.6,
//                 child: TextButton(
//                   onPressed: () {
//                     controller.changePassword(
//                       oldPassword: controller.passwordOld.text,
//                       newPassword: controller.passwordNew.text,
//                       confirmPassword: controller.rePasswordNew.text,
//                     );
//                   },
//                   style: ButtonStyle(
//                     shape: MaterialStateProperty.all<BeveledRectangleBorder>(
//                         BeveledRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     )),
//                     backgroundColor: MaterialStateProperty.all<Color>(
//                         Theme.of(context).primaryColorDark),
//                   ),
//                   child: const Text(
//                     'Đổi mật khẩu',
//                     style: TextStyle(
//                       color: Colors.orangeAccent,
//                       fontSize: 18,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
