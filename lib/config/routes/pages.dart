import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/change_password/change_password.dart';
import 'package:tbs_logistics_tms/app/start_detail_tms/modules/camera_screen.dart';
import 'package:tbs_logistics_tms/app/login/login_screen.dart';
import 'package:tbs_logistics_tms/app/splash/splash_screen.dart';
import 'package:tbs_logistics_tms/app/start_detail_tms/modules/cancel_pending_sceen.dart';
import 'package:tbs_logistics_tms/app/start_detail_tms/modules/details_pending_working.dart';
import 'package:tbs_logistics_tms/app/start_detail_tms/modules/note_pending.dart';
import 'package:tbs_logistics_tms/app/start_detail_tms/start_detail_finished.dart';
import 'package:tbs_logistics_tms/app/start_detail_tms/start_detail_pending.dart';
import 'package:tbs_logistics_tms/app/start_detail_tms/start_detail_tms.dart';
import 'package:tbs_logistics_tms/app/surcharges/surcharges_screen.dart';
import 'package:tbs_logistics_tms/app/tms/tms_page.dart';
part './routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.LOGIN_PAGE,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashScreen(),
    ),
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
  ];
}
