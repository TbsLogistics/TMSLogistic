import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tbs_logistics_tms/app/start_detail_tms/controller/camera_controller.dart';
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
                      height: size.width * 0.9,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        image: DecorationImage(
                            image: FileImage(imageFile!), fit: BoxFit.cover),
                        border: Border.all(width: 8, color: Colors.black),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    )
                  else
                    Container(
                      width: size.width * 0.9,
                      height: size.width * 0.9,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        border: Border.all(width: 8, color: Colors.black12),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: const Text(
                        'Ảnh chứng từ',
                        style: TextStyle(fontSize: 26),
                      ),
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 60,
                        width: size.width * 0.8,
                        // padding: EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          maxLines: 2,
                          controller: controller.noteController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(.0),
                              borderSide: BorderSide(
                                color: Colors.orangeAccent,
                              ),
                            ),
                            hintText: "Nhập chú ý",
                            contentPadding: EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 20,
                              bottom: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  imageFile == null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
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
                      : Row(
                          children: [
                            Expanded(
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
                            const SizedBox(width: 15),
                            Expanded(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Colors.orangeAccent,
                                  ),
                                ),
                                onPressed: () async {
                                  final String filePath = '${imageFile!.path}';
                                  final List<int> binaryData =
                                      await fileToBinary(filePath);
                                  // getCurrentLocation();
                                  print([
                                    "data : $filePath",
                                    controller.noteController.text
                                  ]);
                                  controller.uploadImages(
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
                        ),
                ],
              ),
            ),
          );
        },
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
      print(locationMessage);
    });
  }
}
