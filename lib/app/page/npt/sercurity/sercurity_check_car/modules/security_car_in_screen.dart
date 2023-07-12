import 'package:flutter/services.dart';
import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/config/data/text_style.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/customer_create_register/model/customer_of_ware_home_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_type_car.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_type_cont_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/sercurity/sercurity_check_car/controller/sercurity_check_car_controller.dart';

class SercurityCarInScreen extends GetView<SercurityCheckCarController> {
  const SercurityCarInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildCustomer(
              context: context,
              size: size,
              textController: controller.idController,
              controller: controller,
              // content: 'Mã phiếu',
              onChanged: (value) {
                if (value != "") {
                  var string = value.split("|");
                  var maPhieu = controller
                      .detailEntryVote.value.pdriverInOutWarehouseCode;

                  if (maPhieu != null) {
                    if (string[0].length == 12) {
                      controller.getDetailEntryVote(
                          maPhieuvao: maPhieu, cccd: string[0]);
                    }
                  } else {
                    if (string[0].length == 12) {
                      controller.getDetailEntryVote(cccd: string[0]);
                    } else {
                      controller.getDetailEntryVote(maPhieuvao: value);
                    }
                  }
                }
                controller.update();
              },
              title: 'Mã phiếu :',
              textFocus: controller.idFocusNode,
            ),
            Obx(
              () => controller.isLoadUser.value
                  ? Column(
                      children: [
                        _buildInfo(
                          title: "Khu vực : ",
                          content:
                              "${controller.detailUser.value.nhanvien!.area!.tenKhuVuc}",
                          size: size,
                          context: context,
                        ),
                        _buildInfo(
                          title: "Cổng : ",
                          content:
                              "${controller.detailUser.value.nhanvien!.gateWithWareHouse![0].tencongBV}",
                          size: size,
                          context: context,
                        ),
                        _buildInfo(
                          title: "Kho : ",
                          content:
                              "${controller.detailUser.value.nhanvien!.maKho}",
                          size: size,
                          context: context,
                        ),
                      ],
                    )
                  : Container(
                      child: CircularProgressIndicator(
                        color: Colors.orangeAccent,
                      ),
                    ),
            ),
            Obx(
              () => _listTypeKH(
                controller: controller,
                onChanged: (CustomerOfWareHomeModel? data) {
                  controller
                      .getCusomter(controller.detailUser.value.nhanvien!.maKho);
                },
                title: controller
                        .detailEntryVote.value.maKhachHang?.tenKhachhang ??
                    "",
              ),
            ),
            _buildCustomer(
              textController: controller.nameDriverController,
              size: size,
              context: context,
              controller: controller,
              title: "Tên tài xế : ",
            ),
            Obx(
              () => controller.isShowCheckCccd.value
                  ? Container(
                      child: Text(
                        controller.checkInvoteCccdModel.value.taixe?.tenTaixe ??
                            "",
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 14,
                        ),
                      ),
                    )
                  : Container(),
            ),
            _buildCustomer(
              textController: controller.cccdController,
              size: size,
              context: context,
              controller: controller,
              title: "CCCD : ",
              textFocus: controller.cccdFocusNode,
              onChanged: (value) {
                controller.getCheckCCCD(CCCD: value);
              },
            ),
            Obx(
              () => controller.isShowCheckCccd.value
                  ? Container(
                      child: Text(
                        controller.checkInvoteCccdModel.value.taixe?.cCCD ?? "",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 14,
                        ),
                      ),
                    )
                  : Container(),
            ),
            _buildCustomer(
              textController: controller.phoneController,
              size: size,
              context: context,
              controller: controller,
              title: "Số điện thoại : ",
            ),
            Obx(
              () => _listTypeCar(
                controller: controller,
                onChanged: (ListTypeCarModel? data) {
                  controller.updateTypeCar(data);
                },
                title: controller.detailEntryVote.value.loaixe?.tenLoaiXe ?? "",
              ),
            ),
            _buildCustomerConvert(
                textController: controller.numberCarController,
                // items: controller.detailEntryVote.value,

                sizeFont: 20,
                size: size,
                context: context,
                controller: controller,
                title: "Số xe : ",
                content: ""
                // content: "${controller.detailEntryVote.value.phieuvao!.soxe}",

                ),
            Obx(() {
              return controller.selectTypeCar.value.maLoaiXe == "tai" ||
                      controller.isShowCar.value
                  ? _buildProductCar(
                      size: size,
                      context: context,
                      sealController: controller.seal11Controller,
                      bkController: controller.bkController,
                      kienController: controller.kienController,
                      CBMController: controller.CBMController,
                      tanController: controller.tanController,
                    )
                  : Container();
            }),
            Obx(
              () => controller.isShowCont1.value
                  ? _buildProductCont(
                      title: "Số Cont 1",
                      size: size,
                      context: context,
                      contController: controller.cont1Controller,
                      seal1Controller: controller.seal11Controller,
                      seal2Controller: controller.seal12Controller,
                      bkController: controller.bkController,
                      CBMController: controller.CBMController,
                      kienController: controller.kienController,
                      tanController: controller.tanController,
                      onChanged: (ListTypeContModel? data) {
                        controller.selectTypeCont1.value.typeContCode =
                            data!.typeContCode;

                        controller.update();
                        print(controller.selectTypeCont1.value.typeContCode);
                      },
                      titleTypeCont: controller
                              .detailEntryVote.value.loaiCont?.typeContCode ??
                          "",
                      controller: controller,
                    )
                  : Container(),
            ),
            Obx(
              () => controller.isShowCont1.value
                  ? Container(
                      child: IconButton(
                        onPressed: () {
                          controller.updateShowCont2();
                        },
                        icon: Obx(
                          () => controller.isShowCont2Local.value
                              ? const Icon(Icons.remove)
                              : const Icon(
                                  Icons.add,
                                ),
                        ),
                      ),
                    )
                  : Container(),
            ),
            Obx(
              () => controller.isShowCont2.value ||
                      controller.isShowCont2Local.value
                  ? _buildProductCont(
                      title: "Số Cont 2",
                      size: size,
                      context: context,
                      contController: controller.cont2Controller,
                      seal1Controller: controller.seal21Controller,
                      seal2Controller: controller.seal22Controller,
                      bkController: controller.bk1Controller,
                      CBMController: controller.CBM1Controller,
                      kienController: controller.kien1Controller,
                      tanController: controller.tan1Controller,
                      controller: controller,
                      onChanged: (ListTypeContModel? data) {
                        controller.selectTypeCont2.value.typeContCode =
                            data!.typeContCode;

                        controller.update();
                        print(controller.selectTypeCont2.value.typeContCode);
                      },
                      titleTypeCont: controller
                              .detailEntryVote.value.loaiCont1?.typeContCode ??
                          "",
                    )
                  : Container(),
            ),
            Row(
              children: [
                inputSubmit(
                  size: size,
                  onPressed: () {
                    if (controller.selectTypeCar.value.maLoaiXe != null) {
                      controller.putInOut(typeInvote: 1);
                    } else {
                      controller.getSnack(messageText: "Trống dữ liệu");
                    }
                  },
                  title: 'Xác nhận vào',
                ),
                inputSubmit(
                  size: size,
                  onPressed: () {
                    if (controller.selectTypeCar.value.maLoaiXe != null) {
                      controller.putInOut(typeInvote: 2);
                    } else {
                      controller.getSnack(messageText: "Trống dữ liệu");
                    }
                  },
                  title: 'Xác nhận ra',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget _buildCustomerConvert({
  // required DetailEntryVoteModel items,
  required String title,
  required String content,
  required Size size,
  required BuildContext context,
  required SercurityCheckCarController controller,
  VoidCallback? onPressed,
  IconData? icon,
  required double sizeFont,
  required TextEditingController textController,
}) {
  return Card(
    // shadowColor: Colors.grey,
    // elevation: 5,
    shape: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: Colors.orangeAccent,
        width: 1,
      ),
    ),
    child: Container(
      height: size.width * 0.1,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.orangeAccent,
        ),
        borderRadius: BorderRadius.circular(15),
        // color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: TextFormField(
                  decoration: const InputDecoration.collapsed(hintText: ""),
                  // textAlign: TextAlign.left,
                  textInputAction: TextInputAction.done,
                  textCapitalization: TextCapitalization.characters,
                  controller: textController,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget _buildInfo({
  // required DetailEntryVoteModel items,
  required String title,
  required String content,
  required Size size,
  required BuildContext context,
}) {
  return Card(
    // shadowColor: Colors.grey,
    // elevation: 5,
    shape: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: Colors.orangeAccent,
        width: 1,
      ),
    ),
    child: Container(
      height: size.width * 0.1,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.orangeAccent,
        ),
        borderRadius: BorderRadius.circular(15),
        // color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                content,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildCustomer({
  // required DetailEntryVoteModel items,
  required String title,
  // required String content,
  required Size size,
  required BuildContext context,
  required SercurityCheckCarController controller,
  required TextEditingController textController,
  TextCapitalization? textCapitalization = TextCapitalization.none,
  FocusNode? textFocus,
  IconData? icon,
  VoidCallback? onPressedIcon,
  Function(String)? onChanged,
  // FocusNode ?focusNode,
}) {
  return Card(
    // shadowColor: Colors.grey,
    // elevation: 5,
    shape: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: Colors.orangeAccent,
        width: 1,
      ),
    ),
    child: Container(
      height: size.width * 0.1,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.orangeAccent,
        ),
        borderRadius: BorderRadius.circular(15),
        // color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
                    border: InputBorder.none,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: IconButton(
                        onPressed: onPressedIcon,
                        icon: Icon(
                          icon,
                          color: Colors.grey,
                        ),
                      ), // icon is 48px widget.
                    ),
                  ),
                  textCapitalization: textCapitalization!,
                  // textAlign: TextAlign.left,
                  textInputAction: TextInputAction.done,
                  controller: textController,
                  focusNode: textFocus,
                  onChanged: onChanged,
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget _buildProductCar({
  required Size size,
  required BuildContext context,
  required TextEditingController sealController,
  required TextEditingController bkController,
  required TextEditingController kienController,
  required TextEditingController CBMController,
  required TextEditingController tanController,
}) {
  return Card(
    shadowColor: Colors.grey,
    elevation: 10,
    shape: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: Colors.orangeAccent,
        width: 1,
      ),
    ),
    child: Container(
      height: size.width * 0.5,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.orangeAccent,
        ),
        borderRadius: BorderRadius.circular(15),
        // color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Số seal",
                        style: CustomTextStyle.titleDetails,
                      ),
                      Container(
                        height: 45,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 24,
                          ),
                          decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                            width: 1,
                            color: Colors.green,
                          ))),
                          // textAlign: TextAlign.left,
                          textCapitalization: TextCapitalization.characters,
                          textInputAction: TextInputAction.done,
                          controller: sealController,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Expanded(
                              flex: 1,
                              child: Text(
                                "Số Book :",
                                style: CustomTextStyle.titleDetails,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  child: TextFormField(
                                    decoration: const InputDecoration.collapsed(
                                        hintText: ""),
                                    // textAlign: TextAlign.left,
                                    textInputAction: TextInputAction.done,

                                    controller: bkController,
                                    textCapitalization:
                                        TextCapitalization.characters,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Expanded(
                              flex: 1,
                              child: Text(
                                "Số Kiện :",
                                style: CustomTextStyle.titleDetails,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  child: TextFormField(
                                    decoration: const InputDecoration.collapsed(
                                        hintText: ""),
                                    // textAlign: TextAlign.left,
                                    textCapitalization:
                                        TextCapitalization.characters,
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.done,
                                    controller: kienController,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Expanded(
                              flex: 1,
                              child: Text(
                                "CBM :",
                                style: CustomTextStyle.titleDetails,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  child: TextFormField(
                                    decoration: const InputDecoration.collapsed(
                                        hintText: ""),
                                    // textAlign: TextAlign.left,
                                    textInputAction: TextInputAction.done,
                                    controller: CBMController,
                                    textCapitalization:
                                        TextCapitalization.characters,
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Expanded(
                              flex: 1,
                              child: Text(
                                "Kg :",
                                style: CustomTextStyle.titleDetails,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  child: TextFormField(
                                    decoration: const InputDecoration.collapsed(
                                        hintText: ""),
                                    // textAlign: TextAlign.left,
                                    textInputAction: TextInputAction.done,
                                    controller: tanController,
                                    textCapitalization:
                                        TextCapitalization.characters,
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildProductCont({
  required TextEditingController contController,
  required TextEditingController seal1Controller,
  required TextEditingController seal2Controller,
  required TextEditingController bkController,
  required TextEditingController kienController,
  required TextEditingController CBMController,
  required TextEditingController tanController,
  required Size size,
  required BuildContext context,
  required String title,
  required SercurityCheckCarController controller,
  required Function(ListTypeContModel?) onChanged,
  required String titleTypeCont,
}) {
  return Card(
    shadowColor: Colors.grey,
    elevation: 10,
    shape: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: Colors.orangeAccent,
        width: 1,
      ),
    ),
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      height: 450,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.orangeAccent,
        ),
        borderRadius: BorderRadius.circular(15),
        // color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _listTypeCont(
                        controller: controller,
                        onChanged: onChanged,
                        title: titleTypeCont,
                      ),
                      Text(
                        title,
                        style: CustomTextStyle.titleDetails,
                      ),
                      Container(
                          height: 45,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 24,
                            ),
                            textInputAction: TextInputAction.done,
                            controller: contController,
                            textCapitalization: TextCapitalization.characters,
                            // inputFormatters: [
                            //   FilteringTextInputFormatter.allow(
                            //       RegExp("[a-zA-Z]"))
                            // ]
                          )),
                      const SizedBox(height: 5),
                      customTextField(
                        textEditingController: seal1Controller,
                        title: "Seal : ",
                        flex: 1,
                        fontSize: 20,
                        color: Colors.red,
                      ),
                      customTextField(
                          textEditingController: seal2Controller,
                          title: "Seal : ",
                          flex: 1,
                          fontSize: 20,
                          color: Colors.red),
                      customTextField(
                        textEditingController: bkController,
                        title: "Booking : ",
                      ),
                      customTextField(
                          textEditingController: kienController,
                          title: "Số kiện : ",
                          keyboardType: TextInputType.number),
                      customTextField(
                          textEditingController: CBMController,
                          title: "CBM : ",
                          keyboardType: TextInputType.number),
                      customTextField(
                          textEditingController: tanController,
                          title: "Kg : ",
                          keyboardType: TextInputType.number),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget customTextField({
  required TextEditingController textEditingController,
  TextCapitalization? textCapitalization = TextCapitalization.characters,
  TextInputType? keyboardType = TextInputType.text,
  required String title,
  double? fontSize = 16.0,
  Color? color = Colors.black,
  int? flex = 1,
}) {
  return Expanded(
    flex: flex!,
    child: Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  title,
                  style: CustomTextStyle.titleDetails,
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: Container(
                      width: 200,
                      height: 15,
                      child: TextFormField(
                        decoration: const InputDecoration(),
                        // textAlign: TextAlign.left,
                        textInputAction: TextInputAction.done,
                        textCapitalization: TextCapitalization.characters,
                        controller: textEditingController,
                        keyboardType: keyboardType,
                        style: TextStyle(color: color, fontSize: fontSize),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [],
          ),
        ],
      ),
    ),
  );
}

Widget inputSubmit(
    {required Size size,
    required VoidCallback onPressed,
    required String title}) {
  return Container(
    margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.05, vertical: size.width * 0.025),
    decoration: BoxDecoration(
      color: Colors.orangeAccent.withOpacity(0.8),
      border: Border.all(
        width: 1,
        color: Colors.orangeAccent.withOpacity(0.4),
      ),
      borderRadius: const BorderRadius.all(
        Radius.circular(20.0),
      ),
    ),
    width: size.width * 0.4,
    height: 60,
    child: TextButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget _listTypeCont(
    {required SercurityCheckCarController controller,
    required Function(ListTypeContModel?) onChanged,
    required String title}) {
  return SizedBox(
    height: 120,
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 5),
          child: const Row(
            children: [
              Text(
                "Loại cont *",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 10),
        FindDropdown<ListTypeContModel>(
          showSearchBox: false,
          onFind: (String filter) => controller.getDataTypeCont(filter),
          onChanged: onChanged,
          dropdownBuilder: (BuildContext context, ListTypeContModel? item) {
            return Card(
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: Colors.orangeAccent,
                ),
              ),
              child: (item?.typeContname == null)
                  ? ListTile(
                      title: Text(
                        title,
                        style: TextStyle(
                          color: Colors.orangeAccent,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                    )
                  : ListTile(
                      title: Text(
                        item!.typeContname!,
                        style: const TextStyle(
                          color: Colors.orangeAccent,
                        ),
                      ),
                    ),
            );
          },
          dropdownItemBuilder:
              (BuildContext context, ListTypeContModel item, bool isSelected) {
            return Container(
              decoration: !isSelected
                  ? null
                  : BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
              child: Card(
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    color: Colors.orangeAccent,
                  ),
                ),
                child: ListTile(
                  selected: isSelected,
                  title: Text(
                    item.typeContname!,
                    style: const TextStyle(
                      color: Colors.orangeAccent,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    ),
  );
}

Widget _listTypeCar(
    {required SercurityCheckCarController controller,
    required Function(ListTypeCarModel?) onChanged,
    required String title}) {
  return Card(
    shape: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: Colors.orangeAccent,
        width: 1,
      ),
    ),
    child: SizedBox(
      height: 80,
      child: Padding(
        padding: EdgeInsets.only(left: 10),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.only(left: 5),
                child: const Row(
                  children: [
                    Text(
                      "Loại xe *",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              flex: 2,
              child: FindDropdown<ListTypeCarModel>(
                showSearchBox: false,
                onFind: (String filter) => controller.getDataTypeCar(filter),
                onChanged: onChanged,
                dropdownBuilder:
                    (BuildContext context, ListTypeCarModel? item) {
                  return Card(
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        color: Colors.orangeAccent,
                      ),
                    ),
                    child: (item?.tenLoaiXe == null)
                        ? ListTile(
                            title: Text(
                              title,
                              style: TextStyle(
                                color: Colors.orangeAccent,
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                            ),
                          )
                        : ListTile(
                            title: Text(
                              item!.tenLoaiXe!,
                              style: const TextStyle(
                                color: Colors.orangeAccent,
                              ),
                            ),
                          ),
                  );
                },
                dropdownItemBuilder: (BuildContext context,
                    ListTypeCarModel item, bool isSelected) {
                  return Container(
                    decoration: !isSelected
                        ? null
                        : BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                    child: Card(
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          color: Colors.orangeAccent,
                        ),
                      ),
                      child: ListTile(
                        selected: isSelected,
                        title: Text(
                          item.tenLoaiXe!,
                          style: const TextStyle(
                            color: Colors.orangeAccent,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _listTypeKH(
    {required SercurityCheckCarController controller,
    required Function(CustomerOfWareHomeModel?) onChanged,
    required String title}) {
  return Card(
    shape: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: Colors.orangeAccent,
        width: 1,
      ),
    ),
    child: SizedBox(
      height: 80,
      child: Padding(
        padding: EdgeInsets.only(left: 10),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.only(left: 5),
                child: const Row(
                  children: [
                    Text(
                      "Khách hàng *",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              flex: 2,
              child: FindDropdown<CustomerOfWareHomeModel>(
                showSearchBox: false,
                onFind: (String filter) => controller.getCusomter(
                    "${controller.detailUser.value.nhanvien!.maKho}"),
                onChanged: onChanged,
                dropdownBuilder:
                    (BuildContext context, CustomerOfWareHomeModel? item) {
                  return Card(
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        color: Colors.orangeAccent,
                      ),
                    ),
                    child: (item?.tenKhachhang == null)
                        ? ListTile(
                            title: Text(
                              title,
                              style: TextStyle(
                                color: Colors.orangeAccent,
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                            ),
                          )
                        : ListTile(
                            title: Text(
                              item!.tenKhachhang!,
                              style: const TextStyle(
                                color: Colors.orangeAccent,
                              ),
                            ),
                          ),
                  );
                },
                dropdownItemBuilder: (BuildContext context,
                    CustomerOfWareHomeModel item, bool isSelected) {
                  return Container(
                    decoration: !isSelected
                        ? null
                        : BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                    child: Card(
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          color: Colors.orangeAccent,
                        ),
                      ),
                      child: ListTile(
                        selected: isSelected,
                        title: Text(
                          item.tenKhachhang!,
                          style: const TextStyle(
                            color: Colors.orangeAccent,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
