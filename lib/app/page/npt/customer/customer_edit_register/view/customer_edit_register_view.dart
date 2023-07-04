// ignore_for_file: unrelated_type_equality_checks

import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tbs_logistics_tms/app/config/data/validate.dart';
import 'package:tbs_logistics_tms/app/config/widget/button_form_submit.dart';
import 'package:tbs_logistics_tms/app/config/widget/custom_text_form_field.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/customer_create_register/model/customer_of_ware_home_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/customer_edit_register/controller/customer_edit_register_controller.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_customer_for_driver_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_matrongtai_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_number_cont_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_type_car.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_type_cont_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_type_product_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_type_vote_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_warehome_model.dart';

class CustomerEditRegisterPage extends StatefulWidget {
  const CustomerEditRegisterPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CustomerEditRegisterPageState createState() =>
      _CustomerEditRegisterPageState();
}

class _CustomerEditRegisterPageState extends State<CustomerEditRegisterPage> {
  final String routes = "/CREATE_EDIT_REGISTER_CUSTOMER";
  final formKey = GlobalKey<FormState>();
  var countriesKey = GlobalKey<FindDropdownState>();
  ListCustomerForDriverModel? selectedKhachhang;
  String? idKhachhang;

  CustomerEditRegisterController controller =
      Get.put(CustomerEditRegisterController());
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

  Future<DateTime> _selectDate(BuildContext context) async {
    final selected = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogBackgroundColor: Colors.white,
            colorScheme: const ColorScheme.light(
              primary: Colors.orangeAccent,
              onPrimary: Colors.white,
              onSurface: Colors.blueAccent,
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
    return selectedDate;
  }

  Future<TimeOfDay> _selectTime(BuildContext context) async {
    final selected = await showTimePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.orangeAccent,
              onPrimary: Colors.white,
              onSurface: Colors.blueAccent,
              onBackground: Colors.orangeAccent,
              onSurfaceVariant: Colors.black,
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialTime: selectedTime,
    );
    if (selected != null && selected != selectedTime) {
      setState(() {
        selectedTime = selected;
      });
    }
    return selectedTime;
  }

  Future _selectDateTime(BuildContext context) async {
    final date = await _selectDate(context);
    // ignore: unnecessary_null_comparison
    if (date == null) return;

    // ignore: use_build_context_synchronously
    final time = await _selectTime(context);

    // ignore: unnecessary_null_comparison
    if (time == null) return;
    setState(() {
      dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
      // ignore: unnecessary_string_interpolations
      controller.dateinput.text = "${getDateTime()}";
      // print(controller.dateinput.text);
    });
  }

  String getDate() {
    // ignore: unnecessary_null_comparison
    if (selectedDate == null) {
      return 'select date';
    } else {
      return DateFormat('MMM d, yyyy').format(selectedDate);
    }
  }

  String getDateTime() {
    // ignore: unnecessary_null_comparison
    if (dateTime == null) {
      return 'select date timer';
    } else {
      return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<CustomerEditRegisterController>(
      init: CustomerEditRegisterController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new,
                size: 25, color: Theme.of(context).primaryColorLight),
            onPressed: () {
              Get.back(result: true);
            },
          ),
          title: Text(
            'Chỉnh sửa phiếu',
            style: TextStyle(color: Theme.of(context).primaryColorLight),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              top: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 10,
              right: 10,
            ),
            // decoration: const BoxDecoration(gradient: CustomColor.gradient),
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  // //Loai phieu
                  // _listTypeVote(controller),
                  //THoi gian du kien
                  buildDateTime(size, controller),
                  // _listDriver(controller),
                  //Nhập số xe
                  CustomFormFiels(
                    keyboardType: TextInputType.text,
                    title: "Số xe *",
                    controller: controller.numberCar,
                    hintText: controller.getDriverFinishedScreen.value.soxe,
                    icon: Icons.abc,
                    color: Colors.green,
                  ),
                  //danh sách kho
                  _listWareHome(controller),
                  //Danh sách khách hàng
                  Obx(
                    () => controller
                                .getDriverFinishedScreen.value.khoRe!.tenKho !=
                            null
                        ? _listCustomer(controller)
                        : Container(),
                  ),

                  //danh sách loại hàng
                  _listTypeProduct(controller),
                  //danh sách loại xe
                  _listTypeCar(controller),
                  Obx(
                    () => controller.selectTypeCar.value != "" &&
                            controller.selectTypeCar.value.maLoaiXe == "tai"
                        ? _inputCar()
                        : Column(
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
                          ),
                  ),
                  ButtonFormSubmit(
                      onPressed: () {
                        _signUpProcess(context, controller);
                        // print(numberSelectCont);
                      },
                      text: "Thay đổi")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputCar() {
    return Column(
      children: [
        _listTrongTai(controller),
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
      ],
    );
  }

  Widget _listTrongTai(CustomerEditRegisterController controller) {
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
                    ? ListTile(
                        title: Text(
                          controller.getDriverFinishedScreen.value.maTrongTai !=
                                  null
                              ? controller.getDriverFinishedScreen.value
                                  .maTrongTai!.tenTrongTai!
                              : "Chọn trọng tải ",
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

  Widget _listCustomer(CustomerEditRegisterController controller) {
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
              print(controller.selectCustomer.value.tenKhachhang);
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
                    ? ListTile(
                        title: Text(
                          controller.getDriverFinishedScreen.value.maKhachHang!
                              .tenKhachhang!,
                          style: const TextStyle(
                            color: Colors.orangeAccent,
                          ),
                        ),
                        trailing: const Icon(
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

  Widget _listWareHome(CustomerEditRegisterController controller) {
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
                    ? ListTile(
                        title: Text(
                          controller
                              .getDriverFinishedScreen.value.khoRe!.tenKho!,
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

  Widget _listTypeProduct(CustomerEditRegisterController controller) {
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
                    ? ListTile(
                        title: Text(
                          controller.getDriverFinishedScreen.value.maloaiHang!
                              .tenLoaiHang!,
                          style: const TextStyle(
                            color: Colors.orangeAccent,
                          ),
                        ),
                        trailing: const Icon(
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

  Widget _listTypeCar(CustomerEditRegisterController controller) {
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
                  controller.selectTypeCont1.value.typeContCode = null;
                  controller.selectTypeCont2.value.typeContCode = null;
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
                    ? ListTile(
                        title: Text(
                          controller
                              .getDriverFinishedScreen.value.loaixe!.tenLoaiXe!,
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

  Widget _listTypeVote(CustomerEditRegisterController controller) {
    return SizedBox(
      height: 120,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 5),
            child: const Row(
              children: [
                Text(
                  "Loại phiếu *",
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
          FindDropdown<ListTypeVoteModel>(
            showSearchBox: false,
            onFind: (String filter) => controller.getDataTypeVote(filter),
            onChanged: (ListTypeVoteModel? data) {
              setState(() {
                controller.selectTypeVote.value.id = data!.id;
                controller.update();
              });
            },
            dropdownBuilder: (BuildContext context, ListTypeVoteModel? item) {
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
                          "Chọn loại phiếu",
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
            dropdownItemBuilder: (BuildContext context, ListTypeVoteModel item,
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

  Widget _listNumberCont(CustomerEditRegisterController controller) {
    return SizedBox(
      height: 120,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 5),
            child: const Row(
              children: [
                Text(
                  "Số lượng con *",
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
          FindDropdown<ListNumberContModel>(
            showSearchBox: false,
            onFind: (String filter) => controller.getNumberCont(filter),
            onChanged: (ListNumberContModel? data) {
              setState(() {
                controller.selectNumberCont.value.id = data!.id;
                print(controller.selectNumberCont.value.id);
                if (controller.selectNumberCont.value.id == 1) {
                  controller.selectTypeCont2.value.typeContCode = null;
                }
                controller.update();
              });
            },
            dropdownBuilder: (BuildContext context, ListNumberContModel? item) {
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
                          "Chọn số lượng Cont",
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
                ListNumberContModel item, bool isSelected) {
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

  Widget _listTypeCont1(CustomerEditRegisterController controller) {
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
            onChanged: (ListTypeContModel? data) {
              setState(() {
                controller.selectTypeCont1.value.typeContCode =
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
                    ? ListTile(
                        title: Text(
                          controller.getDriverFinishedScreen.value.loaiCont!
                                      .typeContCode !=
                                  null
                              ? "${controller.getDriverFinishedScreen.value.loaiCont!.typeContname}"
                              : "Chọn loại Cont",
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

  Widget _listTypeCont2(CustomerEditRegisterController controller) {
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
                    ? ListTile(
                        title: Text(
                          controller.getDriverFinishedScreen.value.loaiCont1!
                                  .typeContname ??
                              "",
                          style: const TextStyle(
                            color: Colors.orangeAccent,
                          ),
                        ),
                        trailing: const Icon(
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

  Widget buildDateTime(Size size, CustomerEditRegisterController controller) {
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
          padding: const EdgeInsets.only(top: 10, left: 10),
          height: 60,
          width: size.width - 10,
          margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
          child: TextFormField(
            onTap: () {
              _selectDateTime(context);
              showDateTime = true;
            },
            controller: controller.dateinput,
            decoration: InputDecoration(
              hintText: DateFormat('yyyy-MM-dd HH:mm').format(
                DateTime.parse(
                  controller.getDriverFinishedScreen.value.giodukien.toString(),
                ),
              ),
              hintStyle: TextStyle(
                color: Theme.of(context).primaryColorLight,
              ),
              border: InputBorder.none,
              icon: const Icon(
                Icons.calendar_month,
                size: 26,
              ),
              isDense: true,
            ),
          ),
        ),
      ],
    );
  }

  Widget _contFirt(CustomerEditRegisterController controller) {
    return Column(
      children: [
        const Divider(),
        _listTypeCont1(controller),
        CustomFormFiels(
          keyboardType: TextInputType.text,
          title: "Số cont 1",
          controller: controller.numberCont1,
          hintText: controller.getDriverFinishedScreen.value.socont1,
          icon: Icons.abc,
          color: Colors.green,
        ),
        CustomFormFiels(
          keyboardType: TextInputType.text,
          title: "Số seal",
          controller: controller.numberCont1Seal1,
          hintText: controller.getDriverFinishedScreen.value.cont1seal1,
          icon: Icons.abc,
          color: Colors.green,
        ),
        CustomFormFiels(
          keyboardType: TextInputType.text,
          title: "Số seal",
          controller: controller.numberCont1Seal2,
          hintText: controller.getDriverFinishedScreen.value.cont1seal2,
          icon: Icons.abc,
          color: Colors.green,
        ),
        CustomFormFiels(
          keyboardType: TextInputType.text,
          title: "Số book",
          controller: controller.numberBook,
          hintText: controller.getDriverFinishedScreen.value.soBook,
          icon: Icons.abc,
          color: Colors.green,
        ),
        CustomFormFiels(
          keyboardType: TextInputType.number,
          title: "Số kiện",
          controller: controller.numberKien,
          hintText: controller.getDriverFinishedScreen.value.soKien.toString(),
          icon: Icons.abc,
          color: Colors.green,
        ),
        CustomFormFiels(
          keyboardType: TextInputType.number,
          title: "Khối lượng (Kg)",
          controller: controller.numberTan,
          hintText: controller.getDriverFinishedScreen.value.soTan.toString(),
          icon: Icons.abc,
          color: Colors.green,
        ),
        CustomFormFiels(
          keyboardType: TextInputType.number,
          title: "Số Khối (CBM)",
          controller: controller.numberKhoi,
          hintText: controller.getDriverFinishedScreen.value.sokhoi.toString(),
          icon: Icons.abc,
          color: Colors.green,
        ),
      ],
    );
  }

  Widget _contSecond(CustomerEditRegisterController controller) {
    return Column(
      children: [
        const Divider(),
        _listTypeCont2(controller),
        CustomFormFiels(
          keyboardType: TextInputType.text,
          title: "Số cont 2",
          controller: controller.numberCont2,
          hintText: controller.getDriverFinishedScreen.value.socont2,
          icon: Icons.abc,
          color: Colors.green,
        ),
        CustomFormFiels(
          keyboardType: TextInputType.text,
          title: "Số seal",
          controller: controller.numberCont2Seal1,
          hintText: controller.getDriverFinishedScreen.value.cont2seal1,
          icon: Icons.abc,
          color: Colors.green,
        ),
        CustomFormFiels(
          keyboardType: TextInputType.text,
          title: "Số seal",
          controller: controller.numberCont2Seal2,
          hintText: controller.getDriverFinishedScreen.value.cont2seal2,
          icon: Icons.abc,
          color: Colors.green,
        ),
        CustomFormFiels(
          keyboardType: TextInputType.text,
          title: "Số book",
          controller: controller.numberBook1,
          hintText: controller.getDriverFinishedScreen.value.soBook1,
          icon: Icons.abc,
          color: Colors.green,
        ),
        CustomFormFiels(
          keyboardType: TextInputType.number,
          title: "Số kiện",
          controller: controller.numberKien1,
          hintText: controller.getDriverFinishedScreen.value.sokien1.toString(),
          icon: Icons.abc,
          color: Colors.green,
        ),
        CustomFormFiels(
          keyboardType: TextInputType.number,
          title: "Khối lượng (Kg)",
          controller: controller.numberTan1,
          hintText: controller.getDriverFinishedScreen.value.soTan1.toString(),
          icon: Icons.abc,
          color: Colors.green,
        ),
        CustomFormFiels(
          keyboardType: TextInputType.number,
          title: "Số Khối (CBM)",
          controller: controller.numberKhoi1,
          hintText: controller.getDriverFinishedScreen.value.sokhoi1.toString(),
          icon: Icons.abc,
          color: Colors.green,
        ),
      ],
    );
  }

  // void _signUpProcess(
  //     BuildContext context, CustomerEditRegisterController controller) {
  //   if (controller.dateinput.text == "" ||
  //       controller.numberCar.text == "" ||
  //       controller.selectCustomer.value == "" ||
  //       controller.selectWareHome.value == "" ||
  //       controller.selectTypeProduct.value == "" ||
  //       controller.selectTypeCar.value == "" ||
  //       controller.selectTypeVote.value == "") {
  //     getSnack(messageText: "Nhập đầy đủ thông tin *");
  //   } else {
  //     if (controller.selectTypeCar.value.maLoaiXe == "con") {
  //       if (controller.selectItems != null) {
  //         if (numberSelectCont == 1 &&
  //                 controller.selectTypeCont1.value.typeContCode != null ||
  //             numberSelectCont == 2 &&
  //                 controller.selectTypeCont1.value.typeContCode != null &&
  //                 controller.selectTypeCont2.value.typeContCode != null) {
  //           controller.puttRegisterDriver(
  //             maKhachHang: controller.selectCustomer.value.maKhachHang!,
  //             time: controller.dateinput.text,
  //             typeWarehome: controller.selectWareHome.value.maKho,
  //             typeCar: controller.selectTypeCar.value.maLoaiXe,
  //             numberCar: controller.numberCar.text,
  //             numberCont1: controller.numberCont1.text,
  //             numberCont2: controller.numberCont2.text,
  //             numberCont1Seal1: controller.numberCont1Seal1.text,
  //             numberCont1Seal2: controller.numberCont1Seal2.text,
  //             numberKhoi: double.parse(controller.numberKhoi.text),
  //             numberKien: double.parse(controller.numberKien.text),
  //             numberBook: controller.numberBook.text,
  //             numberTan: double.parse(controller.numberTan.text),
  //             loaiCont: controller.selectTypeCont1.value.typeContCode!,
  //             numberCont2Seal1: controller.numberCont2Seal1.text == ""
  //                 ? null
  //                 : controller.numberCont2Seal1.text,
  //             numberCont2Seal2: controller.numberCont2Seal2.text == ""
  //                 ? null
  //                 : controller.numberCont2Seal1.text,
  //             numberKhoi1: double.parse(controller.numberKhoi1.text),
  //             numberKien1: double.parse(controller.numberKien1.text),
  //             numberBook1: controller.numberBook1.text,
  //             numberTan1: double.parse(controller.numberTan1.text),
  //             loaiCont1: controller.selectTypeCont2.value.typeContCode,
  //             typeProduct: controller.selectTypeProduct.value.maloaiHang,
  //             numberCont: numberSelectCont,
  //             nameCustomer: controller.selectCustomer.value.tenKhachhang,
  //             typeInvote: controller.selectTypeVote.value.id,
  //           );
  //         } else {
  //           getSnack(messageText: "Chọn loại cont * !");
  //         }
  //       } else {
  //         getSnack(messageText: "Chọn số lượng cont * !");
  //       }
  //     } else {
  //       controller.puttRegisterDriver(
  //         maKhachHang: controller.selectCustomer.value.maKhachHang!,
  //         time: controller.dateinput.text,
  //         typeWarehome: controller.selectWareHome.value.maKho,
  //         typeCar: controller.selectTypeCar.value.maLoaiXe,
  //         numberCar: controller.numberCar.text,
  //         numberCont1: controller.numberCont1.text,
  //         numberCont2: controller.numberCont2.text,
  //         numberCont1Seal1: controller.numberCont1Seal1.text,
  //         numberCont1Seal2: controller.numberCont1Seal2.text,
  //         numberKhoi: double.parse(controller.numberKhoi.text),
  //         numberKien: double.parse(controller.numberKien.text),
  //         numberBook: controller.numberBook.text,
  //         numberTan: double.parse(controller.numberTan.text),
  //         loaiCont: controller.selectTypeCont1.value.typeContCode!,
  //         numberCont2Seal1: controller.numberCont2Seal1.text,
  //         numberCont2Seal2: controller.numberCont2Seal2.text,
  //         numberKhoi1: double.parse(controller.numberKhoi1.text),
  //         numberKien1: double.parse(controller.numberKien1.text),
  //         numberBook1: controller.numberBook1.text,
  //         numberTan1: double.parse(controller.numberTan1.text),
  //         loaiCont1: controller.selectTypeCont2.value.typeContCode!,
  //         typeProduct: controller.selectTypeProduct.value.maloaiHang,
  //         numberCont: numberSelectCont,
  //         nameCustomer: controller.selectCustomer.value.tenKhachhang,
  //         typeInvote: controller.selectTypeVote.value.id,
  //       );
  //     }
  //   }
  // }
  void _signUpProcess(
    BuildContext context,
    CustomerEditRegisterController controller,
  ) {
    if (controller.selectTypeCont1.value.typeContCode == null &&
        controller.getDriverFinishedScreen.value.loaiCont!.status != null) {
      controller.getDriverFinishedScreen.value.loaiCont!.typeContCode;
    } else {
      controller.selectTypeCont1.value.typeContCode;
    }
    controller.puttRegisterDriver(
      maKhachHang: controller.selectCustomer.value.maKhachHang ??
          controller.getDriverFinishedScreen.value.maKhachHang!.maKhachHang,
      time: controller.dateinput.text == ""
          ? controller.getDriverFinishedScreen.value.giodukien
          : controller.dateinput.text,
      maTrongTai: controller.selectTrongTai.value.maTrongTai,
      typeWarehome: controller.selectWareHome.value.maKho ??
          controller.getDriverFinishedScreen.value.khoRe!.maKho,
      typeCar: controller.selectTypeCar.value.maLoaiXe ??
          controller.getDriverFinishedScreen.value.loaixe!.maLoaiXe,
      numberCar: controller.numberCar.text == ""
          ? controller.getDriverFinishedScreen.value.soxe
          : controller.numberCar.text,
      numberCont1: controller.numberCont1.text == ""
          ? controller.getDriverFinishedScreen.value.socont1
          : controller.numberCont1.text,
      numberCont2: controller.numberCont2.text == ""
          ? controller.getDriverFinishedScreen.value.socont2
          : controller.numberCont2.text,
      numberCont1Seal1: controller.numberCont1Seal1.text == ""
          ? controller.getDriverFinishedScreen.value.cont1seal1
          : controller.numberCont1Seal1.text,
      numberCont1Seal2: controller.numberCont1Seal2.text == ""
          ? controller.getDriverFinishedScreen.value.cont1seal2
          : controller.numberCont1Seal2.text,
      numberKhoi: controller.numberKhoi.text == ""
          ? controller.getDriverFinishedScreen.value.sokhoi.toString()
          : controller.numberKhoi.text,
      numberKien: controller.numberKien.text == ""
          ? controller.getDriverFinishedScreen.value.soKien.toString()
          : controller.numberKien.text,
      numberBook: controller.numberBook.text == ""
          ? controller.getDriverFinishedScreen.value.soBook
          : controller.numberBook.text,
      numberTan: controller.numberTan.text == ""
          ? controller.getDriverFinishedScreen.value.soTan.toString()
          : controller.numberTan.text,
      loaiCont: controller.selectTypeCont1.value.typeContCode ??
          controller.getDriverFinishedScreen.value.loaiCont!.typeContCode,
      numberCont2Seal1: controller.numberCont2Seal1.text == ""
          ? controller.getDriverFinishedScreen.value.cont2seal1
          : controller.numberCont2Seal1.text,
      numberCont2Seal2: controller.numberCont2Seal2.text == ""
          ? controller.getDriverFinishedScreen.value.cont2seal2
          : controller.numberCont2Seal2.text,
      numberKhoi1: controller.numberKhoi1.text == ""
          ? controller.getDriverFinishedScreen.value.sokhoi1.toString()
          : controller.numberKhoi1.text,
      numberKien1: controller.numberKien1.text == ""
          ? controller.getDriverFinishedScreen.value.sokien1.toString()
          : controller.numberKien1.text,
      numberBook1: controller.numberBook1.text == ""
          ? controller.getDriverFinishedScreen.value.soBook1
          : controller.numberBook1.text,
      numberTan1: controller.numberTan1.text == ""
          ? controller.getDriverFinishedScreen.value.soTan1.toString()
          : controller.numberTan1.text,
      loaiCont1: controller.selectTypeCont2.value.typeContCode ??
          controller.getDriverFinishedScreen.value.loaiCont1!.typeContCode,
      typeProduct: controller.selectTypeProduct.value.maloaiHang ??
          controller.getDriverFinishedScreen.value.maloaiHang!.maloaiHang,
      nameCustomer: controller.selectCustomer.value.tenKhachhang ??
          controller.getDriverFinishedScreen.value.maKhachHang!.tenKhachhang,
    );
    // }
    // Widget _listDriver(CustomerEditRegisterController controller) {
    //   return SizedBox(
    //     height: 120,
    //     child: Column(
    //       children: [
    //         Container(
    //           padding: const EdgeInsets.only(left: 5),
    //           child: const Row(
    //             children: [
    //               Text(
    //                 "Tài xế *",
    //                 textAlign: TextAlign.left,
    //                 style: TextStyle(
    //                   color: Colors.green,
    //                   fontSize: 16,
    //                 ),
    //               )
    //             ],
    //           ),
    //         ),
    //         const SizedBox(height: 10),
    //         FindDropdown<ListDriverByCustomerModel>(
    //           showSearchBox: false,
    //           onFind: (String filter) => controller.getDataDriver(filter),
    //           onChanged: (value) {
    //             controller.selectDriver.value.maTaixe = value!.maTaixe;
    //           },
    //           dropdownBuilder:
    //               (BuildContext context, ListDriverByCustomerModel? item) {
    //             return Card(
    //               shape: OutlineInputBorder(
    //                 borderRadius: BorderRadius.circular(5),
    //                 borderSide: const BorderSide(
    //                   color: Colors.orangeAccent,
    //                 ),
    //               ),
    //               child: (item?.tenTaixe == null)
    //                   ? const ListTile(
    //                       title: Text(
    //                         "Chọn tài xế",
    //                         style: TextStyle(
    //                           color: Colors.orangeAccent,
    //                         ),
    //                       ),
    //                       trailing: Icon(
    //                         Icons.arrow_drop_down,
    //                         color: Colors.black,
    //                       ),
    //                     )
    //                   : ListTile(
    //                       title: Text(
    //                         item!.tenTaixe!,
    //                         style: const TextStyle(
    //                           color: Colors.orangeAccent,
    //                         ),
    //                       ),
    //                     ),
    //             );
    //           },
    //           dropdownItemBuilder: (BuildContext context,
    //               ListDriverByCustomerModel item, bool isSelected) {
    //             return Container(
    //               // height: 100,
    //               decoration: !isSelected
    //                   ? null
    //                   : BoxDecoration(
    //                       border:
    //                           Border.all(color: Theme.of(context).primaryColor),
    //                       borderRadius: BorderRadius.circular(5),
    //                       color: Colors.white,
    //                     ),
    //               child: Card(
    //                 shape: OutlineInputBorder(
    //                   borderRadius: BorderRadius.circular(5),
    //                   borderSide: const BorderSide(
    //                     color: Colors.orangeAccent,
    //                   ),
    //                 ),
    //                 child: ListTile(
    //                   selected: isSelected,
    //                   title: Text(
    //                     item.tenTaixe!,
    //                     style: const TextStyle(color: Colors.orangeAccent),
    //                   ),
    //                 ),
    //               ),
    //             );
    //           },
    //         ),
    //       ],
    //     ),
    //   );
    // }

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
}
