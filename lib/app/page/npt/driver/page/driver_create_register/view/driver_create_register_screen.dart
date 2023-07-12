// ignore_for_file: unrelated_type_equality_checks

import 'package:date_time_picker/date_time_picker.dart';
import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/config/data/validate.dart';
import 'package:tbs_logistics_tms/app/config/widget/button_form_submit.dart';
import 'package:tbs_logistics_tms/app/config/widget/custom_text_form_field.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/customer_create_register/model/customer_of_ware_home_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/controller/driver_create_register_controller.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_customer_for_driver_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_matrongtai_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_product_lock_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_type_car.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_type_cont_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_type_product_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_warehome_model.dart';

class DriverCreateRegisterScreen extends StatefulWidget {
  const DriverCreateRegisterScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DriverCreateRegisterScreenState createState() =>
      _DriverCreateRegisterScreenState();
}

class _DriverCreateRegisterScreenState
    extends State<DriverCreateRegisterScreen> {
  final String routes = "/CREATE_REGISTER_DRIVER";
  final formKey = GlobalKey<FormState>();
  var countriesKey = GlobalKey<FindDropdownState>();
  ListCustomerForDriverModel? selectedKhachhang;
  String? idKhachhang;

  String? selectedNumberCont;
  int numberSelectCont = 0;
  String? selectedProduct;
  bool isCheckProduct = false;
  bool isCheckNotProduct = true;

  bool showDateTime = false;
  bool showDate = false;
  bool showTime = false;
  DateTime dateTime = DateTime.now();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<DriverCreateRegisterController>(
      init: DriverCreateRegisterController(),
      builder: (controller) => GestureDetector(
        onTap: () {
          // FocusScope.of(context).requestFocus(new FocusNode());
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new,
                  size: 25, color: Theme.of(context).primaryColorLight),
              onPressed: () {
                Get.back();
              },
            ),
            title: Text(
              'Đăng ký phiếu vào',
              style: TextStyle(color: Theme.of(context).primaryColorLight),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              // decoration: const BoxDecoration(gradient: CustomColor.gradient),
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    //THoi gian du kien
                    buildDateTime(size, controller),
                    //Nhập số xe
                    CustomFormFiels(
                      forcusNode: controller.numberCarFocus,
                      keyboardType: TextInputType.text,
                      title: "Số xe *",
                      controller: controller.numberCar,
                      hintText: "Nhập số xe",
                      icon: Icons.abc,
                      color: Colors.green,
                    ),
                    //danh sách kho
                    _listWareHome(controller),
                    //Danh sách khách hàng
                    Obx(
                      () => controller.selectWareHome.value.maKho != null
                          ? _listCustomer(controller)
                          : Container(),
                    ),
                    // _listTrongTai(controller),
                    //danh sách loại hàng
                    _listTypeProduct(controller),
                    //danh sách loại xe
                    _listTypeCar(controller),
                    Obx(() {
                      // print(
                      //   [
                      //     controller.selectTypeCar.value.maLoaiXe != "",
                      //     controller.selectTypeCar.value.maLoaiXe,
                      //     controller.selectTypeCar.value.maLoaiXe == ""
                      //   ],
                      // );
                      return controller.selectTypeCar.value.maLoaiXe != null
                          ? controller.selectTypeCar.value.maLoaiXe == "con"
                              ? Column(
                                  children: [
                                    _contFirt(controller),
                                    Center(
                                      child: IconButton(
                                        onPressed: () {
                                          controller.changeHideShowCont2();
                                        },
                                        icon: controller.isShowCont2.value
                                            ? const Icon(
                                                Icons.remove_circle,
                                                size: 30,
                                                color: Colors.red,
                                              )
                                            : const Icon(
                                                Icons.add_circle,
                                                size: 30,
                                                color: Colors.green,
                                              ),
                                      ),
                                    ),
                                    controller.isShowCont2.value
                                        ? _contSecond(controller)
                                        : Container(),
                                  ],
                                )
                              : _formCar(controller)
                          : Container();
                    }),

                    ButtonFormSubmit(
                        onPressed: () {
                          _signUpProcess(context, controller);
                          // print(numberSelectCont);
                        },
                        text: "Đăng ký")
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _listCustomer(DriverCreateRegisterController controller) {
    return SizedBox(
      height: 120,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 5),
            child: const Row(
              children: [
                Text(
                  "Khách hàng *",
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
          FindDropdown<CustomerOfWareHomeModel>(
            showSearchBox: false,
            onFind: (String filter) => controller
                .getCusomter("${controller.selectWareHome.value.maKho}"),
            onChanged: (value) {
              controller.selectCustomer.value.maKhachHang = value!.maKhachHang;
              controller.selectCustomer.value.tenKhachhang = value.tenKhachhang;
            },
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
                    ? const ListTile(
                        title: Text(
                          "Chọn khách hàng",
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
                // height: 100,
                decoration: !isSelected
                    ? null
                    : BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
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
                      style: const TextStyle(color: Colors.orangeAccent),
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

  Widget _listWareHome(DriverCreateRegisterController controller) {
    return SizedBox(
      height: 120,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 5),
            child: const Row(
              children: [
                Text(
                  "Kho *",
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
          FindDropdown<ListWareHomeModel>(
            showSearchBox: false,
            onFind: (String filter) => controller.getDataWareHome(filter),
            onChanged: (ListWareHomeModel? data) {
              setState(() {
                controller.selectWareHome.value.maKho = data!.maKho;
              });
            },
            dropdownBuilder: (BuildContext context, ListWareHomeModel? item) {
              return Card(
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    color: Colors.orangeAccent,
                  ),
                ),
                child: (item?.tenKho == null)
                    ? const ListTile(
                        title: Text(
                          "Chọn kho",
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
                          item!.tenKho!,
                          style: const TextStyle(
                            color: Colors.orangeAccent,
                          ),
                        ),
                      ),
              );
            },
            dropdownItemBuilder: (BuildContext context, ListWareHomeModel item,
                bool isSelected) {
              return Container(
                decoration: !isSelected
                    ? null
                    : BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
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
                      item.tenKho!,
                      style: const TextStyle(
                        color: Colors.orangeAccent,
                        fontSize: 15,
                      ),
                    ),
                    subtitle: Text(
                      item.maKhuVuc!,
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

  Widget _listTrongTai(DriverCreateRegisterController controller) {
    return SizedBox(
      height: 120,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 5),
            child: const Row(
              children: [
                Text(
                  "Trọng tải *",
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
          FindDropdown<ListMaTrongTai>(
            showSearchBox: false,
            onFind: (String filter) => controller.getTrongTai(filter),
            onChanged: (ListMaTrongTai? data) {
              setState(() {
                controller.selectTrongTai.value.maTrongTai = data!.maTrongTai;
              });
            },
            dropdownBuilder: (BuildContext context, ListMaTrongTai? item) {
              return Card(
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    color: Colors.orangeAccent,
                  ),
                ),
                child: (item?.tenTrongTai == null)
                    ? const ListTile(
                        title: Text(
                          "Chọn trọng tải",
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
                          item!.tenTrongTai!,
                          style: const TextStyle(
                            color: Colors.orangeAccent,
                          ),
                        ),
                      ),
              );
            },
            dropdownItemBuilder:
                (BuildContext context, ListMaTrongTai item, bool isSelected) {
              return Container(
                decoration: !isSelected
                    ? null
                    : BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
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
                      item.tenTrongTai!,
                      style: const TextStyle(
                        color: Colors.orangeAccent,
                        fontSize: 15,
                      ),
                    ),
                    subtitle: Text(
                      item.maTrongTai!,
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

  Widget _listTypeProduct(DriverCreateRegisterController controller) {
    return SizedBox(
      height: 120,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 5),
            child: const Row(
              children: [
                Text(
                  "Loại hàng *",
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
          FindDropdown<ListTypeProductModel>(
            // label: "Khách hàng",
            validate: (ListTypeProductModel? value) =>
                Validate().selectCustomer(value: value!.tenLoaiHang),
            showSearchBox: false,
            onFind: (String filter) => controller.getDataTypeProduct(filter),
            onChanged: (ListTypeProductModel? data) {
              controller.selectTypeProduct.value.maloaiHang = data!.maloaiHang;
            },
            dropdownBuilder:
                (BuildContext context, ListTypeProductModel? item) {
              return Card(
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    color: Colors.orangeAccent,
                  ),
                ),
                child: (item?.tenLoaiHang == null)
                    ? const ListTile(
                        title: Text(
                          "Chọn loại hàng",
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
                          item!.tenLoaiHang!,
                          style: const TextStyle(
                            color: Colors.orangeAccent,
                          ),
                        ),
                      ),
              );
            },
            dropdownItemBuilder: (BuildContext context,
                ListTypeProductModel item, bool isSelected) {
              return Container(
                decoration: !isSelected
                    ? null
                    : BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
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
                      item.tenLoaiHang!,
                      style: const TextStyle(
                        color: Colors.orangeAccent,
                        fontSize: 15,
                      ),
                    ),
                    subtitle: Text(
                      item.maloaiHang!,
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

  Widget _listTypeCar(DriverCreateRegisterController controller) {
    return SizedBox(
      height: 120,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 5),
            child: const Row(
              children: [
                Text(
                  "Loại xe *",
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
          FindDropdown<ListTypeCarModel>(
            validate: (ListTypeCarModel? value) =>
                Validate().selectCustomer(value: value!.tenLoaiXe),
            showSearchBox: false,
            onFind: (String filter) => controller.getDataTypeCar(filter),
            onChanged: (ListTypeCarModel? data) {
              setState(() {
                controller.selectTypeCar.value.maLoaiXe = data!.maLoaiXe;
                if (controller.selectTypeCar.value.maLoaiXe == "tai") {
                  numberSelectCont = 0;
                }
              });
            },
            dropdownBuilder: (BuildContext context, ListTypeCarModel? item) {
              return Card(
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    color: Colors.orangeAccent,
                  ),
                ),
                child: (item?.tenLoaiXe == null)
                    ? const ListTile(
                        title: Text(
                          "Chọn xe",
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
            dropdownItemBuilder:
                (BuildContext context, ListTypeCarModel item, bool isSelected) {
              return Container(
                decoration: !isSelected
                    ? null
                    : BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
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
        ],
      ),
    );
  }

  Widget _listhaveProduct1(DriverCreateRegisterController controller) {
    return SizedBox(
      height: 120,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 5),
            child: const Row(
              children: [
                Text(
                  "Chọn trạng thái hàng",
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
          FindDropdown<ListProductLockModel>(
            showSearchBox: false,
            onFind: (String filter) => controller.getDataProductTrue(filter),
            onChanged: (ListProductLockModel? data) {
              setState(() {
                controller.selectHaveProduct1.value.trangthai = data!.trangthai;
              });
              print(
                  "Khoa cont1 : ${controller.selectHaveProduct1.value.trangthai}");
            },
            dropdownBuilder:
                (BuildContext context, ListProductLockModel? item) {
              return Card(
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    color: Colors.orangeAccent,
                  ),
                ),
                child: (item?.name == null)
                    ? const ListTile(
                        title: Text(
                          "Chọn trạng thái hàng *",
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
                          item!.name!,
                          style: const TextStyle(
                            color: Colors.orangeAccent,
                          ),
                        ),
                      ),
              );
            },
            dropdownItemBuilder: (BuildContext context,
                ListProductLockModel item, bool isSelected) {
              return Container(
                decoration: !isSelected
                    ? null
                    : BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
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
                      item.name!,
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

  Widget _listhaveProduct2(DriverCreateRegisterController controller) {
    return SizedBox(
      height: 120,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 5),
            child: const Row(
              children: [
                Text(
                  "Chọn trạng thái hàng",
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
          FindDropdown<ListProductLockModel>(
            showSearchBox: false,
            onFind: (String filter) => controller.getDataProductTrue(filter),
            onChanged: (ListProductLockModel? data) {
              setState(() {
                controller.selectHaveProduct2.value.trangthai = data!.trangthai;
              });
            },
            dropdownBuilder:
                (BuildContext context, ListProductLockModel? item) {
              return Card(
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    color: Colors.orangeAccent,
                  ),
                ),
                child: (item?.name == null)
                    ? const ListTile(
                        title: Text(
                          "Chọn trạng thái hàng *",
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
                          item!.name!,
                          style: const TextStyle(
                            color: Colors.orangeAccent,
                          ),
                        ),
                      ),
              );
            },
            dropdownItemBuilder: (BuildContext context,
                ListProductLockModel item, bool isSelected) {
              return Container(
                decoration: !isSelected
                    ? null
                    : BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
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
                      item.name!,
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

  Widget _listProductLock1(DriverCreateRegisterController controller) {
    return SizedBox(
      height: 120,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 5),
            child: const Row(
              children: [
                Text(
                  "Chọn trạng thái khóa",
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
          FindDropdown<ListProductLockModel>(
            showSearchBox: false,
            onFind: (String filter) =>
                controller.getDataProductLockTrue(filter),
            onChanged: (ListProductLockModel? data) {
              setState(() {
                controller.selectProductLock1.value.trangthai = data!.trangthai;
              });
            },
            dropdownBuilder:
                (BuildContext context, ListProductLockModel? item) {
              return Card(
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    color: Colors.orangeAccent,
                  ),
                ),
                child: (item?.name == null)
                    ? const ListTile(
                        title: Text(
                          "Chọn trạng thái khóa *",
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
                          item!.name!,
                          style: const TextStyle(
                            color: Colors.orangeAccent,
                          ),
                        ),
                      ),
              );
            },
            dropdownItemBuilder: (BuildContext context,
                ListProductLockModel item, bool isSelected) {
              return Container(
                decoration: !isSelected
                    ? null
                    : BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
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
                      item.name!,
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

  Widget _listProductLock2(DriverCreateRegisterController controller) {
    return SizedBox(
      height: 120,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 5),
            child: const Row(
              children: [
                Text(
                  "Chọn trạng thái khóa",
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
          FindDropdown<ListProductLockModel>(
            showSearchBox: false,
            onFind: (String filter) =>
                controller.getDataProductLockTrue(filter),
            onChanged: (ListProductLockModel? data) {
              setState(() {
                controller.selectProductLock2.value.trangthai = data!.trangthai;
              });
            },
            dropdownBuilder:
                (BuildContext context, ListProductLockModel? item) {
              return Card(
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    color: Colors.orangeAccent,
                  ),
                ),
                child: (item?.name == null)
                    ? const ListTile(
                        title: Text(
                          "Chọn trạng thái khóa *",
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
                          item!.name!,
                          style: const TextStyle(
                            color: Colors.orangeAccent,
                          ),
                        ),
                      ),
              );
            },
            dropdownItemBuilder: (BuildContext context,
                ListProductLockModel item, bool isSelected) {
              return Container(
                decoration: !isSelected
                    ? null
                    : BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
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
                      item.name!,
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

  Widget _listTypeCont1(DriverCreateRegisterController controller) {
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
                    color: Colors.red,
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
            onChanged: (ListTypeContModel? data) {
              setState(() {
                controller.selectTypeCont1.value.typeContCode =
                    data!.typeContCode;
                print([
                  controller.selectTypeCont1.value.typeContCode,
                  numberSelectCont,
                ]);
                controller.update();
              });
            },
            dropdownBuilder: (BuildContext context, ListTypeContModel? item) {
              return Card(
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    color: Colors.orangeAccent,
                  ),
                ),
                child: (item?.typeContname == null)
                    ? const ListTile(
                        title: Text(
                          "Chọn loại cont",
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
            dropdownItemBuilder: (BuildContext context, ListTypeContModel item,
                bool isSelected) {
              return Container(
                decoration: !isSelected
                    ? null
                    : BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
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

  Widget _listTypeCont2(DriverCreateRegisterController controller) {
    return SizedBox(
      height: 120,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 5),
            child: const Row(
              children: [
                Text(
                  "Loại cont (Cont 2)*",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.red,
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
            onChanged: (ListTypeContModel? data) {
              setState(() {
                controller.selectTypeCont2.value.typeContCode =
                    data!.typeContCode;
                controller.update();
              });
            },
            dropdownBuilder: (BuildContext context, ListTypeContModel? item) {
              return Card(
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    color: Colors.orangeAccent,
                  ),
                ),
                child: (item?.typeContname == null)
                    ? const ListTile(
                        title: Text(
                          "Chọn loại cont",
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
            dropdownItemBuilder: (BuildContext context, ListTypeContModel item,
                bool isSelected) {
              return Container(
                decoration: !isSelected
                    ? null
                    : BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
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

  Widget buildDateTime(Size size, DriverCreateRegisterController controller) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 5),
          child: const Row(
            children: [
              Text(
                "Thời gian dự kiến *",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              // color: Color(0xFFF3BD60),
              color: Colors.orangeAccent,
            ),
            // color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
          ),
          padding: const EdgeInsets.only(top: 5, left: 10),
          height: 60,
          width: size.width - 10,
          margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
          child: DateTimePicker(
            type: DateTimePickerType.dateTime,
            dateMask: 'dd-MM-yyyy HH:mm',
            controller: controller.dateinput,
            // initialValue: _initialValue,
            firstDate: DateTime.now(),
            lastDate: DateTime(2100),
            decoration: const InputDecoration(
              hintText: "Chọn ngày/ giờ vào",
              hintStyle: TextStyle(
                color: Colors.orangeAccent,
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
              border: InputBorder.none,
              icon: Icon(
                Icons.event,
                size: 30,
              ),
              iconColor: Colors.orangeAccent,
            ),
            style: const TextStyle(
              color: Colors.red,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            // onChanged: (val) {
            //   setState(() => controller.valueDateInput = val);
            // },
          ),
        ),
      ],
    );
  }

  Widget _dateTime(DriverCreateRegisterController controller) {
    return DateTimePicker(
      type: DateTimePickerType.dateTime,
      dateMask: 'dd-MM-yyyy HH:mm',
      controller: controller.dateinput,
      // initialValue: _initialValue,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      icon: Icon(Icons.event),
      dateLabelText: 'Ngày vào',
      timeLabelText: "Giờ vào",
      dateHintText: "dsad",
      // use24Hou rFormat: false,
      // selectableDayPredicate: (date) {
      //   if (date.weekday == 6 || date.weekday == 7) {
      //     return false;
      //   }
      //   return true;
      // },
      onChanged: (val) {
        print(val);
        setState(() => controller.valueDateInput = val);
      },
      // validator: (val) {
      //   setState(() => _valueToValidate1 = val ?? '');
      //   return null;
      // },
      // onSaved: (val) => setState(() => _valueSaved1 = val ?? ''),
    );
  }

  Widget _contFirt(DriverCreateRegisterController controller) {
    return Column(
      children: [
        const Divider(),
        _listTypeCont1(controller),
        CustomFormFiels(
          keyboardType: TextInputType.text,
          title: "Số Cont 1 *",
          controller: controller.numberCont1,
          hintText: "Nhập số cont",
          icon: Icons.abc,
          color: Colors.red,
        ),
        CustomFormFiels(
          keyboardType: TextInputType.text,
          title: "Số seal",
          controller: controller.numberCont1Seal1,
          hintText: "Nhập số seal",
          icon: Icons.abc,
          color: Colors.green,
        ),
        CustomFormFiels(
          keyboardType: TextInputType.text,
          title: "Số seal",
          controller: controller.numberCont1Seal2,
          hintText: "Nhập số seal",
          icon: Icons.abc,
          color: Colors.green,
        ),
        CustomFormFiels(
          keyboardType: TextInputType.text,
          title: "Số book",
          controller: controller.numberBook,
          hintText: "Nhập số book",
          icon: Icons.abc,
          color: Colors.green,
        ),
        CustomFormFiels(
          keyboardType: TextInputType.number,
          title: "Số kiện",
          controller: controller.numberKien,
          hintText: "Nhập số kiện",
          icon: Icons.abc,
          color: Colors.green,
        ),
        CustomFormFiels(
          keyboardType: TextInputType.number,
          title: "Khối lượng (Kg)",
          controller: controller.numberTan,
          hintText: "Nhập Khối lượng (Kg)",
          icon: Icons.abc,
          color: Colors.green,
        ),
        CustomFormFiels(
          keyboardType: TextInputType.number,
          title: "Số Khối (CBM)",
          controller: controller.numberKhoi,
          hintText: "Nhập Số Khối (CBM)",
          icon: Icons.abc,
          color: Colors.green,
        ),
        _listhaveProduct1(controller),
        _listProductLock1(controller),
      ],
    );
  }

  Widget _contSecond(DriverCreateRegisterController controller) {
    return Column(
      children: [
        const Divider(),
        _listTypeCont2(controller),
        CustomFormFiels(
          keyboardType: TextInputType.text,
          title: "Số cont 2 *",
          controller: controller.numberCont2,
          hintText: "Nhập số cont",
          icon: Icons.abc,
          color: Colors.red,
        ),
        CustomFormFiels(
          keyboardType: TextInputType.text,
          title: "Số seal",
          controller: controller.numberCont2Seal1,
          hintText: "Nhập số seal",
          icon: Icons.abc,
          color: Colors.green,
        ),
        CustomFormFiels(
          keyboardType: TextInputType.text,
          title: "Số seal",
          controller: controller.numberCont2Seal2,
          hintText: "Nhập số seal",
          icon: Icons.abc,
          color: Colors.green,
        ),
        CustomFormFiels(
          keyboardType: TextInputType.text,
          title: "Số book",
          controller: controller.numberBook1,
          hintText: "Nhập số book",
          icon: Icons.abc,
          color: Colors.green,
        ),
        CustomFormFiels(
          keyboardType: TextInputType.number,
          title: "Số kiện",
          controller: controller.numberKien1,
          hintText: "Nhập số kiện",
          icon: Icons.abc,
          color: Colors.green,
        ),
        CustomFormFiels(
          keyboardType: TextInputType.number,
          title: "Khối lượng (Kg)",
          controller: controller.numberTan1,
          hintText: "Nhập Khối lượng (Kg)",
          icon: Icons.abc,
          color: Colors.green,
        ),
        CustomFormFiels(
          keyboardType: TextInputType.number,
          title: "Số Khối (CBM)",
          controller: controller.numberKhoi1,
          hintText: "Nhập Số Khối (CBM)",
          icon: Icons.abc,
          color: Colors.green,
        ),
        _listhaveProduct2(controller),
        _listProductLock2(controller),
      ],
    );
  }

  Widget _formCar(DriverCreateRegisterController controller) {
    return Column(
      children: [
        CustomFormFiels(
          keyboardType: TextInputType.text,
          title: "Số seal",
          controller: controller.numberCont1Seal1,
          hintText: "Nhập Số Seal",
          icon: Icons.abc,
          color: Colors.green,
        ),
        CustomFormFiels(
          keyboardType: TextInputType.text,
          title: "Số Book",
          controller: controller.numberBook,
          hintText: "Nhập Số Book",
          icon: Icons.abc,
          color: Colors.green,
        ),
        _listTrongTai(controller),
        CustomFormFiels(
          keyboardType: TextInputType.number,
          title: "Khối lượng (Kg)",
          controller: controller.numberTan,
          hintText: "Nhập Khối lượng (Kg)",
          icon: Icons.abc,
          color: Colors.green,
        ),
        CustomFormFiels(
          keyboardType: TextInputType.number,
          title: "Số Khối (CBM)",
          controller: controller.numberKhoi,
          hintText: "",
          icon: Icons.abc,
          color: Colors.green,
        ),
        CustomFormFiels(
          keyboardType: TextInputType.number,
          title: "Số Kiện",
          controller: controller.numberKien,
          hintText: "",
          icon: Icons.abc,
          color: Colors.green,
        ),
        _listhaveProduct1(controller),
        _listProductLock1(controller),
      ],
    );
  }

  void _signUpProcess(
      BuildContext context, DriverCreateRegisterController controller) {
    if (controller.dateinput.text == "" ||
        controller.numberCar.text == "" ||
        controller.selectCustomer.value.maKhachHang == null ||
        controller.selectWareHome.value.maKho == null ||
        controller.selectTypeProduct.value.maloaiHang == null ||
        controller.selectTypeCar.value.maLoaiXe == null) {
      getSnack(messageText: "Nhập đầy đủ thông tin *");
    } else {
      if (controller.selectTypeCar.value.maLoaiXe == "con") {
        if (controller.isShowCont2.value == false &&
                controller.selectTypeCont1.value.typeContCode != null ||
            controller.isShowCont2.value == true &&
                controller.selectTypeCont1.value.typeContCode != null &&
                controller.selectTypeCont2.value.typeContCode != null) {
          if (controller.numberCont1.text != "") {
            if (controller.selectTypeCont1.value.typeContCode != null &&
                    controller.selectHaveProduct1.value.trangthai != null ||
                controller.selectTypeCont1.value.typeContCode != null &&
                    controller.selectProductLock1.value.trangthai != null ||
                controller.selectTypeCont2.value.typeContCode != null &&
                    controller.selectHaveProduct2.value.trangthai != null ||
                controller.selectTypeCont2.value.typeContCode != null &&
                    controller.selectProductLock2.value.trangthai != null) {
              controller.postRegisterDriver(
                maKhachHang: controller.selectCustomer.value.maKhachHang!,
                time: controller.dateinput.text,
                typeWarehome: controller.selectWareHome.value.maKho,
                typeCar: controller.selectTypeCar.value.maLoaiXe,
                numberCar: controller.numberCar.text,
                numberCont1: controller.numberCont1.text,
                numberCont2: controller.numberCont2.text,
                numberCont1Seal1: controller.numberCont1Seal1.text,
                numberCont1Seal2: controller.numberCont1Seal2.text,
                numberKhoi: double.parse(controller.numberKhoi.text),
                numberKien: double.parse(controller.numberKien.text),
                numberBook: controller.numberBook.text,
                numberTan: double.parse(controller.numberTan.text),
                statusHang1: controller.selectHaveProduct1.value.trangthai,
                statusKhoa1: controller.selectProductLock1.value.trangthai,
                loaiCont: controller.selectTypeCont1.value.typeContCode,
                maTrongTai: controller.selectTrongTai.value.maTrongTai,
                numberCont2Seal1: controller.numberCont2Seal1.text == ""
                    ? null
                    : controller.numberCont2Seal1.text,
                numberCont2Seal2: controller.numberCont2Seal2.text == ""
                    ? null
                    : controller.numberCont2Seal1.text,
                numberKhoi1: double.parse(controller.numberKhoi1.text),
                numberKien1: double.parse(controller.numberKien1.text),
                numberBook1: controller.numberBook1.text,
                numberTan1: double.parse(controller.numberTan1.text),
                statusHang2:
                    controller.selectHaveProduct2.value.trangthai ?? false,
                statusKhoa2:
                    controller.selectProductLock2.value.trangthai ?? false,
                loaiCont1: controller.selectTypeCont2.value.typeContCode,
                typeProduct: controller.selectTypeProduct.value.maloaiHang,
                nameCustomer: controller.selectCustomer.value.tenKhachhang,
              );
            } else {
              getSnack(
                  messageText: "Chọn trạng thái Hàng, trạng thái Khóa * !");
            }
          } else {
            getSnack(messageText: "Nhập số Cont * !");
          }
        } else {
          getSnack(messageText: "Chọn loại cont * !");
        }
      } else {
        controller.postRegisterDriver(
          maKhachHang: controller.selectCustomer.value.maKhachHang,
          time: controller.dateinput.text,
          typeWarehome: controller.selectWareHome.value.maKho,
          typeCar: controller.selectTypeCar.value.maLoaiXe,
          numberCar: controller.numberCar.text,
          numberCont1: controller.numberCont1.text,
          numberCont2: "",
          numberCont1Seal1: controller.numberCont1Seal1.text,
          numberCont1Seal2: controller.numberCont1Seal2.text,
          numberKhoi: double.parse(controller.numberKhoi.text),
          numberKien: double.parse(controller.numberKien.text),
          numberBook: controller.numberBook.text,
          numberTan: double.parse(controller.numberTan.text),
          statusHang1: controller.selectHaveProduct1.value.trangthai,
          statusKhoa1: controller.selectProductLock1.value.trangthai,
          maTrongTai: controller.selectTrongTai.value.maTrongTai,
          loaiCont: null,
          numberCont2Seal1: "",
          numberCont2Seal2: "",
          numberKhoi1: 0.0,
          numberKien1: 0.0,
          numberBook1: "",
          numberTan1: 0.0,
          statusHang2: false,
          statusKhoa2: false,
          loaiCont1: null,
          typeProduct: controller.selectTypeProduct.value.maloaiHang,
          nameCustomer: controller.selectCustomer.value.tenKhachhang,
        );
      }
    }
  }

  void getSnack({required String messageText}) {
    Get.snackbar(
      "",
      "",
      titleText: const Text(
        "Thông báo",
        style: TextStyle(
          color: Colors.red,
          fontSize: 16,
        ),
      ),
      messageText: Text(
        messageText,
        style: const TextStyle(
          color: Colors.green,
        ),
      ),
    );
  }
}
