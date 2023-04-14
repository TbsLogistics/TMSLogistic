// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:io';

import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tbs_logistics_tms/app/start_detail_tms/controller/camera_controller.dart';
import 'package:tbs_logistics_tms/app/start_detail_tms/model/list_doc_type.dart';
import 'package:tbs_logistics_tms/app/surcharges/model/list_subfee_model.dart';
import 'package:tbs_logistics_tms/config/core/data/color.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final String routes = "/CAMERA_SCREEN";
  File? imageFile;
  var locationMessage = '';
  late String latitude;
  late String longitude;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chụp ảnh chứng từ"),
        centerTitle: true,
        backgroundColor: CustomColor.backgroundAppbar,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 25,
          ),
        ),
      ),
      body: GetBuilder<CameraController>(
        init: CameraController(),
        builder: (controller) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (imageFile != null)
                    Container(
                      width: size.width * 0.9,
                      height: size.width * 0.7,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        image: DecorationImage(
                            image: FileImage(imageFile!), fit: BoxFit.cover),
                        border: Border.all(width: 2, color: Colors.black),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    )
                  else
                    Container(
                      width: size.width * 0.9,
                      height: size.width * 0.7,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        border: Border.all(width: 2, color: Colors.black12),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: const Text(
                        'Ảnh chứng từ',
                        style: TextStyle(fontSize: 26),
                      ),
                    ),
                  const SizedBox(height: 10),
                  const SizedBox(
                    height: 20,
                  ),
                  imageFile == null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 45,
                              width: 150,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Colors.orangeAccent,
                                  ),
                                ),
                                onPressed: () =>
                                    getImage(source: ImageSource.camera),
                                child: const Text(
                                  'Chụp ảnh',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(),
                  imageFile != null
                      ? Column(
                          children: [
                            _buildInput(
                              textCapitalization: TextCapitalization.words,
                              size: size,
                              controller: controller.noteController,
                              text: "Nhập chú thích",
                              title: 'Chú thích',
                            ),
                            const SizedBox(height: 10),
                            _buildSearchInput(controller),
                            const SizedBox(height: 10),
                            Obx(
                              () => controller.selectedValue.value == 1
                                  ? _buildInput(
                                      size: size,
                                      controller: controller.contController,
                                      text: "Nhập số Cont",
                                      title: 'Số Cont',
                                      textCapitalization:
                                          TextCapitalization.characters,
                                    )
                                  : Container(),
                            ),
                            const SizedBox(height: 10),
                            Obx(
                              () => controller.selectedValue.value == 1
                                  ? _buildInput(
                                      size: size,
                                      controller: controller.sealController,
                                      text: "Nhập số Seal",
                                      title: 'Số Seal',
                                      textCapitalization:
                                          TextCapitalization.characters,
                                    )
                                  : Container(),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  height: 45,
                                  width: 120,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                        Colors.orangeAccent,
                                      ),
                                    ),
                                    onPressed: () =>
                                        getImage(source: ImageSource.camera),
                                    child: const Text(
                                      'Chụp lại',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ),
                                // const SizedBox(width: 30),
                                SizedBox(
                                  height: 45,
                                  width: 120,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                        Colors.orangeAccent,
                                      ),
                                    ),
                                    onPressed: () async {
                                      final String filePath = imageFile!.path;
                                      final List<int> binaryData =
                                          await fileToBinary(filePath);
                                      // getCurrentLocation();

                                      controller.uploadImages(
                                        docType: controller.selectedValue.value,
                                        file: filePath,
                                        note: controller.noteController.text,
                                      );
                                    },
                                    child: const Text(
                                      'Gửi',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      : Container(),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 120,
                    width: double.infinity,
                    // color: Colors.amberAccent,
                    child: Obx(
                      () => ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, i) {
                          //Chuyển đổi dạng base64 to image
                          Uint8List byte = const Base64Decoder()
                              .convert("${controller.image[i].image}");
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.defaultDialog(
                                      backgroundColor: Colors.grey,
                                      title: "Hình ${i + 1}",
                                      content: SizedBox(
                                        // color: Colors.orangeAccent,
                                        height: size.height * 0.6,
                                        width: size.width,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: size.height * 0.4,
                                              width: size.width,
                                              color: Colors.orangeAccent,
                                              child: Image.memory(
                                                byte,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Expanded(
                                              child: Text(
                                                controller.image[i].note != null
                                                    ? "${controller.image[i].note}"
                                                    : "",
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ));
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 15),
                                  height: 90,
                                  width: 120,
                                  color: Colors.orangeAccent,
                                  child: Image.memory(
                                    byte,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                controller.image[i].note != null
                                    ? "${controller.image[i].note}"
                                    : "",
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          );
                        },
                        itemCount: controller.image.length,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchInput(CameraController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          SizedBox(
            height: 60,
            width: 75,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  "Chứng từ",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                )
              ],
            ),
          ),
          Expanded(
            child: FindDropdown<ListDocTypeModel>(
              onFind: (String filter) => controller.getListDocType(filter),
              onChanged: (ListDocTypeModel? data) {
                controller.selectedValue.value =
                    int.parse(data!.maLoaiChungTu.toString());
                controller.subFee.value = data.tenLoaiChungTu!;
                print(
                    [controller.selectedValue.value, controller.subFee.value]);
              },
              dropdownBuilder: (BuildContext context, ListDocTypeModel? item) {
                return Container(
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).dividerColor),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  child: (item?.tenLoaiChungTu == null)
                      ? Row(
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                "Chọn chứng từ",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down_outlined,
                              color: Colors.black,
                            )
                          ],
                        )
                      : Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                item!.tenLoaiChungTu!,
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                            const Icon(
                              Icons.arrow_drop_down_outlined,
                              color: Colors.black,
                            )
                          ],
                        ),
                );
              },
              dropdownItemBuilder: (BuildContext context, ListDocTypeModel item,
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
                      borderSide: const BorderSide(
                        color: Colors.orangeAccent,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ListTile(
                      selected: isSelected,
                      title: Text(
                        item.tenLoaiChungTu!,
                        style: const TextStyle(fontSize: 15),
                      ),
                      subtitle: Text(
                        item.maLoaiDiaDiem!,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInput({
    required Size size,
    required String title,
    required TextEditingController controller,
    required String text,
    required TextCapitalization textCapitalization,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 60,
            width: 75,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                )
              ],
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 50,
              child: TextFormField(
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                maxLines: 2,
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: const BorderSide(
                      color: Colors.orangeAccent,
                    ),
                  ),
                  hintText: text,
                  contentPadding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 10,
                    bottom: 20,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<List<int>> fileToBinary(String filePath) async {
    final File file = File(filePath);
    return await file.readAsBytes();
  }

  void getImage({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(
      source: source,
      maxWidth: 640,
      maxHeight: 480,
      // imageQuality: 70 //0 - 100
    );

    if (file?.path != null) {
      setState(
        () {
          imageFile = File(file!.path);
          List<int> imageBytes = imageFile!.readAsBytesSync();

          // print("imageFile ${base64Encode(imageBytes)}");
          // print(imageBytes);
        },
      );
    }
  }

  void getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    var position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.reduced,
    );
    var lat = position.latitude;
    var long = position.longitude;

    // passing this to latitude and longitude strings
    latitude = "$lat";
    longitude = "$long";

    setState(() {
      locationMessage = "Latitude: $lat and Longitude: $long";
    });
  }
}
