import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/config/data/color.dart';
import 'package:tbs_logistics_tms/app/config/data/text_style.dart';
import 'package:tbs_logistics_tms/app/page/npt/sercurity/repass_driver/controller/repass_controller.dart';

class SercurityRePassScreen extends GetView<SercurityRePassController> {
  const SercurityRePassScreen({super.key});

  final String routes = "/SERCURITY_RE_PASSWORD";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.backgroundAppbar,
        title: const Text(
          "Cập nhật mật khẩu",
          style: CustomTextStyle.tilteAppbar,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
          ),
        ),
      ),
      body: GetBuilder<SercurityRePassController>(
        init: SercurityRePassController(),
        builder: (controller) => Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              _inputTextForm(
                  size: size,
                  controller: controller.cccdController,
                  focusNode: controller.cccdForcus,
                  title: "CCCD"),
              const SizedBox(height: 10),
              _inputTextForm(
                size: size,
                controller: controller.nameDriverController,
                title: "Tên tài xế",
                focusNode: controller.nameDriverForcus,
              ),
              const SizedBox(height: 10),
              _inputTextForm(
                size: size,
                controller: controller.emailController,
                title: "Email",
                focusNode: controller.emailForcus,
              ),
              const SizedBox(height: 10),
              _inputTextForm(
                size: size,
                controller: controller.phoneController,
                title: "Số điện thoại",
                focusNode: controller.phoneForcus,
              ),
              const SizedBox(height: 20),
              _btnSubmit(
                text: "Đổi mật khẩu",
                onPressed: () {
                  controller.rePassword(id: 0);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _btnSubmit({required String text, required VoidCallback onPressed}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orangeAccent,
        border: Border.all(width: 1, color: Colors.white),
        borderRadius: BorderRadius.circular(15),
      ),
      height: 50,
      width: 200,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _inputTextForm(
      {required Size size,
      required TextEditingController? controller,
      required FocusNode? focusNode,
      required String title}) {
    return SizedBox(
      height: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black.withOpacity(0.7),
            ),
          )),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.orangeAccent),
              borderRadius: BorderRadius.circular(15),
            ),
            height: 50,
            child: TextFormField(
              focusNode: focusNode,
              controller: controller,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(left: 10),
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
                counterText: "",
              ),
              cursorColor: Colors.black,
              textDirection: TextDirection.ltr,
            ),
          ),
        ],
      ),
    );
  }
}
