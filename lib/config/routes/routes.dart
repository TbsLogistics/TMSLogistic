// ignore_for_file: constant_identifier_names

part of "pages.dart";

abstract class Routes {
  //Đăng nhập
  static const LOGIN_PAGE = "/LOGIN_PAGE";
  //Splash
  static const SPLASH = "/SPLASH";

  //TMS_PAGE
  static const TMS_PAGE = "/TMS_PAGE";
  static const START_DETAIL_TMS = "/START_DETAIL_TMS";
  static const PENDING_DETAIL_TMS = "/PENDING_DETAIL_TMS";
  static const FINISHED_DETAIL_TMS = "/FINISHED_DETAIL_TMS";
  //TMS_PENDING
  static const DETAILS_PENDING_WORKING_SCREEN =
      "/DETAILS_PENDING_WORKING_SCREEN";
  static const NOTE_PENDING_SCREEN = "/NOTE_PENDING_SCREEN";
  static const CANCEL_PENDING_SCREEN = "/CANCEL_PENDING_SCREEN";

  //CAMERA
  static const CAMERA = "/CAMERA";
  //SUR_CHANGE_SCREEN
  static const SUR_CHANGE_SCREEN = "/SUR_CHANGE_SCREEN";
  //CHANGE_PASSWORD__FULL_SCREEN
  static const CHANGE_PASSWORD__FULL_SCREEN = "/CHANGE_PASSWORD__FULL_SCREEN";
}
