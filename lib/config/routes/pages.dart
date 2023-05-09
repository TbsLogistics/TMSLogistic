import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/home_page/home_page.dart';
import 'package:tbs_logistics_tms/app/hrm/create_leave/view/create_leave_form_page.dart';
import 'package:tbs_logistics_tms/app/hrm/manager_leave_form/manager_leave_form_page.dart';
import 'package:tbs_logistics_tms/app/hrm/manager_leave_form/view/access_leave/detail_access_single_screen.dart';
import 'package:tbs_logistics_tms/app/hrm/manager_leave_form/view/single_view/detail_single_view.dart';

import 'package:tbs_logistics_tms/app/login/login_screen.dart';
import 'package:tbs_logistics_tms/app/npt/customer/customer_page.dart';
import 'package:tbs_logistics_tms/app/npt/customer/view/list_driver/list_driver_by_customer.dart';
import 'package:tbs_logistics_tms/app/npt/customer/view/list_registed_of_customer/details_list_ticker_customer.dart';
import 'package:tbs_logistics_tms/app/npt/customer/view/list_registed_of_customer/list_ticker_customer.dart';
import 'package:tbs_logistics_tms/app/npt/customer/view/register_for_driver/create_register_driver_by_customer.dart';
import 'package:tbs_logistics_tms/app/npt/customer/view/register_for_driver/customer_details_register.dart';
import 'package:tbs_logistics_tms/app/npt/driver/driver_page.dart';
import 'package:tbs_logistics_tms/app/npt/driver/view/create_register_view/create_register_screen.dart';
import 'package:tbs_logistics_tms/app/npt/driver/view/settings/qr_code_screen.dart';
import 'package:tbs_logistics_tms/app/npt/driver/view/status/list_status_unfinished_screen.dart';
import 'package:tbs_logistics_tms/app/npt/driver/view/status/modules/list_status_unfinished_details_screen.dart';
import 'package:tbs_logistics_tms/app/npt/driver/view/status_tiker_finished/status_ticker_details_view.dart';
import 'package:tbs_logistics_tms/app/splash/splash_screen.dart';
import 'package:tbs_logistics_tms/app/tms/start_detail_tms/modules/cancel_pending_sceen.dart';
import 'package:tbs_logistics_tms/app/tms/start_detail_tms/modules/details_pending_working.dart';
import 'package:tbs_logistics_tms/app/tms/start_detail_tms/modules/note_pending.dart';
import 'package:tbs_logistics_tms/app/tms/start_detail_tms/start_detail_finished.dart';
import 'package:tbs_logistics_tms/app/tms/start_detail_tms/start_detail_pending.dart';
import 'package:tbs_logistics_tms/app/tms/start_detail_tms/start_detail_tms.dart';

import 'package:tbs_logistics_tms/app/tms/tms_page/tms_page.dart';

import '../../app/npt/customer/view/list_driver/customer_details_info_driver.dart';
import '../../app/npt/driver/view/create_register_view/details_form_register_driver.dart';
import '../../app/tms/change_password/change_password.dart';
import '../../app/tms/start_detail_tms/modules/camera_screen.dart';
import '../../app/tms/surcharges/surcharges_screen.dart';
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
      page: () => const StartDetailTms(),
    ),
    GetPage(
      name: Routes.PENDING_DETAIL_TMS,
      page: () => const PendingDetailTms(),
    ),
    GetPage(
      name: Routes.FINISHED_DETAIL_TMS,
      page: () => const FinishedDetailTms(),
    ),
    //PENDING
    GetPage(
      name: Routes.DETAILS_PENDING_WORKING_SCREEN,
      page: () => const DetailsPendingWorkingScreen(),
    ),
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
      page: () => const DetailsFormRegisterDriver(),
    ),
    GetPage(
      name: Routes.CREATE_REGISTER_DRIVER,
      page: () => const RegisterFormScreen(),
    ),
    GetPage(
      name: Routes.LIST_STATUS_INFINISHED_SCREEN,
      page: () => ListStatusUnfinishedScreen(),
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
      page: () => const DetailSingleView(),
    ),
    GetPage(
      name: Routes.CREATE_LEAVE_FORM_PAGE,
      page: () => const CreateLeaveFormPage(),
    ),
    GetPage(
      name: Routes.DETAIL_ACCESS_SINGLE_SCREEN,
      page: () => const DetailAccessSingleScreen(),
    ),
    GetPage(
      name: Routes.MANAGER_LEAVE_FORM_SCREEN,
      page: () => const ManagerLeaveFormScreen(),
    ),
  ];
}
