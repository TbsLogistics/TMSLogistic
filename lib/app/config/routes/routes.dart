// ignore_for_file: constant_identifier_names

part of "pages.dart";

abstract class Routes {
  //Đăng nhập
  static const LOGIN_PAGE = "/LOGIN_PAGE";
  //Splash
  static const SPLASH = "/SPLASH";
  //Trang chủ
  static const HOME_PAGE = "/HOME_PAGE";

  //---------------------- Tính năng TMS ----------------------------

  //TMS_PAGE
  static const TMS_PAGE = "/TMS_PAGE";
  static const START_DETAIL_TMS = "/START_DETAIL_TMS";
  static const PENDING_DETAIL_TMS = "/PENDING_DETAIL_TMS";
  static const FINISHED_DETAIL_TMS = "/FINISHED_DETAIL_TMS";
  static const DASH_BOARD_TMS_PAGE = "/DASH_BOARD_TMS_PAGE";
  //DASHBoard
  static const DASH_BOARD_PAGE = "/DASH_BOARD_PAGE";
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
  //---------------------- Tính năng NPT ----------------------------
  //++++++++++++++++++++++++++DRIVER+++++++++++++++++++++++++++++++++
  static const DRIVER_PAGE = "/DRIVER_PAGE";
  static const LIST_STATUS_INFINISHED_SCREEN = "/LIST_STATUS_INFINISHED_SCREEN";
  static const STATUS_TICKER_DETAIL_SCREEN = "/STATUS_TICKER_DETAIL_SCREEN";
  static const QR_CODE_DRIVER_SCREEN = "/QR_CODE_DRIVER_SCREEN";
  static const QR_CODE_DETAILS_REGISTED_DRIVER_SCREEN =
      "/QR_CODE_DETAILS_REGISTED_DRIVER_SCREEN";
  static const LIST_STATUS_UNFINISHED_DETAIL_SCREEN =
      "/LIST_STATUS_UNFINISHED_DETAIL_SCREEN";
  static const DETAILS_FORM_REGISTER_DRIVER = "/DETAILS_FORM_REGISTER_DRIVER";
  static const CREATE_REGISTER_DRIVER = "/CREATE_REGISTER_DRIVER";
  static const SERCURITY_PAGE = "/SERCURITY_PAGE";
  static const CREATE_EDIT_REGISTER_DRIVER = "/CREATE_EDIT_REGISTER_DRIVER";
  //++++++++++++++++++++++++++CUSTOMER+++++++++++++++++++++++++++++++++

  static const CUSTOMER_PAGE = "/CUSTOMER_PAGE";
  static const QR_CODE_CUSTOMER_SCREEN = "/QR_CODE_CUSTOMER_SCREEN";
  static const QR_CODE_FROM_DETALS_CUSTOMER_SCREEN =
      "/QR_CODE_FROM_DETALS_CUSTOMER_SCREEN";
  static const REGISTER_CUSTOMER = "/REGISTER_CUSTOMER";
  static const LIST_DRIVER_BY_CUSTOMER = "/LIST_DRIVER_BY_CUSTOMER";
  static const LIST_TICKER_CUSTOMER = "/LIST_TICKER_CUSTOMER";
  static const DETAILS_LIST_TICKER_OF_CUSTOMER =
      "/DETAILS_LIST_TICKER_OF_CUSTOMER";
  static const DETAILS_REGISTER_CUSTOMER = "/DETAILS_REGISTER_CUSTOMER";
  static const CUSTOMER_DETAILS_INFO_DRIVER = "/CUSTOMER_DETAILS_INFO_DRIVER";
  //++++++++++++++++++++++++++SERCURITY++++++++++++++++++++++++++
  static const SERCURITY_SCREEN = "/SERCURITY_SCREEN";
  static const SERCURITY_LIST_DANGTAI = "/SERCURITY_LIST_DANGTAI";
  static const SERCURITY_DETAILS_LIST_DANGTAI =
      "/SERCURITY_DETAILS_LIST_DANGTAI";

  static const CREATE_EDIT_REGISTER_CUSTOMER = "/CREATE_EDIT_REGISTER_CUSTOMER";

  static const SERCURITY_RE_PASSWORD = "/SERCURITY_RE_PASSWORD";

  //---------------------- Tính năng HRM ----------------------------
  static const CHANGE_PASSWORD_FULL_SCREEN = "/CHANGE_PASSWORD_FULL_SCREEN";
  static const DETAIL_SINGLE_VIEW = "/DETAIL_SINGLE_VIEW";
  static const CREATE_LEAVE_FORM_PAGE = "/CREATE_LEAVE_FORM_PAGE";
  static const DETAIL_ACCESS_SINGLE_SCREEN = "/DETAIL_ACCESS_SINGLE_SCREEN";
  static const MANAGER_LEAVE_FORM_SCREEN = "/MANAGER_LEAVE_FORM_SCREEN";
}
