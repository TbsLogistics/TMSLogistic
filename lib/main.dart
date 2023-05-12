// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tbs_logistics_tms/app/config/constants/constants.dart';
import 'package:tbs_logistics_tms/app/config/core/theme/theme_provider.dart';
import 'package:tbs_logistics_tms/app/config/routes/pages.dart';
import 'package:tbs_logistics_tms/app/page/splash/controller/splash_bindings.dart';
import 'package:tbs_logistics_tms/app/page/splash/splash_screen.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  await GetStorage.init('MyStorage');
  final box = GetStorage('MyStorage');
  bool? mode = box.read(AppConstants.THEME_KEY);
  // ignore: unrelated_type_equality_checks
  bool isLightMode = (mode != null && mode == "light");

  var locale = const Locale('vi', 'VN');
  Get.updateLocale(locale);
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: locale,
      themeMode: ThemeMode.light,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.lightTheme,
      defaultTransition: Transition.fade,
      initialBinding: SplashBinding(),
      initialRoute: Routes.SPLASH,
      getPages: AppPages.pages,
      home: const SplashScreen(),
    ),
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
