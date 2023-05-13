import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/page/home_page/home_page.dart';
import 'package:tbs_logistics_tms/app/page/hrm/home/home_hrm_page.dart';
import 'package:tbs_logistics_tms/app/page/hrm/letter_manager_details/view/letter_manager_details_screen.dart';
import 'package:tbs_logistics_tms/app/page/hrm/letter_myself_create/view/letter_myself_create_screen.dart';
import 'package:tbs_logistics_tms/app/page/hrm/letter_myself_details/view/letter_myself_details_screen.dart';

import 'package:tbs_logistics_tms/app/page/login/login_screen.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/customer_page.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/view/list_driver/customer_details_info_driver.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/view/list_driver/list_driver_by_customer.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/view/list_registed_of_customer/details_list_ticker_customer.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/view/list_registed_of_customer/list_ticker_customer.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/view/register_for_driver/create_register_driver_by_customer.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/view/register_for_driver/customer_details_register.dart';

import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/view/driver_create_register_screen.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register_details/view/driver_create_register_details_screen.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_finished_details/view/driver_finished_details_screen.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_home/driver_home_page.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_qr/view/driver_qr_screen.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_status/view/driver_status_screen.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_status_details/view/driver_status_details_screen.dart';

import 'package:tbs_logistics_tms/app/page/splash/splash_screen.dart';
import 'package:tbs_logistics_tms/app/page/tms/camera/view/camera_screen.dart';
import 'package:tbs_logistics_tms/app/page/tms/cancel/view/cancel_screen.dart';
import 'package:tbs_logistics_tms/app/page/tms/change_password/change_password.dart';
import 'package:tbs_logistics_tms/app/page/tms/finished_details/view/finished_details_screen.dart';
import 'package:tbs_logistics_tms/app/page/tms/note/view/note_screen.dart';
import 'package:tbs_logistics_tms/app/page/tms/pending_details/view/pending_details_screen.dart';

import 'package:tbs_logistics_tms/app/page/tms/surcharges/surcharges_screen.dart';
import 'package:tbs_logistics_tms/app/page/tms/tms_page/tms_page.dart';
import 'package:tbs_logistics_tms/app/page/tms/wait_details/view/wait_details_screen.dart';

part './routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.LOGIN_PAGE,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: Routes.HOME_PAGE,
      page: () => HomePage(),
    ),
    //------------------Tính năng TMS-------------------------------
    //TMS_PAGE
    GetPage(
      name: Routes.TMS_PAGE,
      page: () => const TmsPage(),
    ),
    GetPage(
      name: Routes.START_DETAIL_TMS,
      page: () => const AwaitDetails(),
    ),
    GetPage(
      name: Routes.PENDING_DETAIL_TMS,
      page: () => const PendingDetailTms(),
    ),
    GetPage(
      name: Routes.FINISHED_DETAIL_TMS,
      page: () => const FinishedDetailsScreen(),
    ),
    //PENDING
    // GetPage(
    //   name: Routes.DETAILS_PENDING_WORKING_SCREEN,
    //   page: () => const DetailsPendingWorkingScreen(),
    // ),
    GetPage(
      name: Routes.NOTE_PENDING_SCREEN,
      page: () => const NotePendingScreen(),
    ),
    GetPage(
      name: Routes.CANCEL_PENDING_SCREEN,
      page: () => const CancelPendingScreen(),
    ),
    //CAMERA
    GetPage(
      name: Routes.CAMERA,
      page: () => const CameraScreen(),
    ),
    //SurChange
    GetPage(
      name: Routes.SUR_CHANGE_SCREEN,
      page: () => const SurChangesScreen(),
    ),
    //CHANGE_PASSWORD__FULL_SCREEN
    GetPage(
      name: Routes.CHANGE_PASSWORD__FULL_SCREEN,
      page: () => ChangePasswordScreen(),
    ),

    //------------------Tính năng NPT-------------------------------
    //Tài xế
    GetPage(
      name: Routes.DRIVER_PAGE,
      page: () => DriverPage(),
    ),
    GetPage(
      name: Routes.DETAILS_FORM_REGISTER_DRIVER,
      page: () => DriverCreateRegisterDetailsScreen(),
    ),
    GetPage(
      name: Routes.CREATE_REGISTER_DRIVER,
      page: () => const DriverCreateRegisterScreen(),
    ),
    GetPage(
      name: Routes.LIST_STATUS_INFINISHED_SCREEN,
      page: () => DriverStatusScreen(),
    ),
    GetPage(
      name: Routes.LIST_STATUS_UNFINISHED_DETAIL_SCREEN,
      page: () => ListStatusUnfinishedDetailsScreen(),
    ),
    GetPage(
      name: Routes.STATUS_TICKER_DETAIL_SCREEN,
      page: () => const StatusTikerDetailScreen(),
    ),
    //Khách hàng
    GetPage(
      name: Routes.LIST_DRIVER_BY_CUSTOMER,
      page: () => const ListDriverByCustomer(),
    ),
    GetPage(
      name: Routes.QR_CODE_SCREEN,
      page: () => const QrCodeScreen(),
    ),
    GetPage(
      name: Routes.CUSTOMER_PAGE,
      page: () => const CustomerPage(),
    ),
    GetPage(
      name: Routes.REGISTER_CUSTOMER,
      page: () => const RegisterCustomer(),
    ),
    GetPage(
      name: Routes.DETAILS_REGISTER_CUSTOMER,
      page: () => const DetailsRegisterCustomer(),
    ),
    GetPage(
      name: Routes.CUSTOMER_DETAILS_INFO_DRIVER,
      page: () => const CustomerDetailsInfoDriver(),
    ),
    GetPage(
      name: Routes.LIST_TICKER_CUSTOMER,
      page: () => const ListTickerCustomer(),
    ),
    GetPage(
      name: Routes.DETAILS_LIST_TICKER_OF_CUSTOMER,
      page: () => const DetailsListTickerOfCustomer(),
    ),

    //------------------Tính năng HRM-------------------------------

    GetPage(
      name: Routes.CHANGE_PASSWORD_FULL_SCREEN,
      page: () => const RegisterCustomer(),
    ),
    GetPage(
      name: Routes.DETAIL_SINGLE_VIEW,
      page: () => const LetterMyselfDetailsScreen(),
    ),
    GetPage(
      name: Routes.CREATE_LEAVE_FORM_PAGE,
      page: () => const LetterMyselfCreateScreen(),
    ),
    GetPage(
      name: Routes.DETAIL_ACCESS_SINGLE_SCREEN,
      page: () => const LetterManagerDetailsScreen(),
    ),
    GetPage(
      name: Routes.MANAGER_LEAVE_FORM_SCREEN,
      page: () => const HomeHrmPage(),
    ),
  ];
}
