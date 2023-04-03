import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ComeWareHomeController extends GetxController {
  void openGoogleMap(String placeName) async {
    final query = Uri.encodeComponent(placeName);
    final url = "https://www.google.com/maps/search/?api=1&query=$query";
    String appleMapUrl = "http://maps.apple.com/?q=$query";

    if (Platform.isAndroid) {
      try {
        if (await canLaunchUrl(Uri.parse(url))) {
          print("oke");
          await launchUrl(
            Uri.parse(url),
            mode: LaunchMode.externalNonBrowserApplication,
          );
        }
      } catch (error) {
        print(error);
        throw ("Cannot launch Google map");
      }
    }
    if (Platform.isIOS) {
      try {
        if (await canLaunch(appleMapUrl)) {
          await launch(appleMapUrl);
        }
      } catch (error) {
        throw ("Cannot launch Apple map");
      }
    }
  }
}
