import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:tbs_logistics_tms/app/config/constants/constants.dart';
import 'package:tbs_logistics_tms/app/config/share_preferences/share_preferences.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/model/status_driver_model.dart';

class ListStatusUnfinishedController extends GetxController {
  var dio = Dio();
  late Response response;

  RxList<StatusDriverModel> listStatusDriver = <StatusDriverModel>[].obs;
  RxBool isLoadList = true.obs;
  @override
  void onInit() {
    getListStatusUnfinish();
    super.onInit();
  }

  void getListStatusUnfinish() async {
    var maTaiXe = await SharePerApi().getIdUser();

    var url =
        "${AppConstants.urlBaseNpt}/unfinished-list-driver?maTaixe=$maTaiXe";
    isLoadList(false);
    try {
      response = await dio.get(url);
      if (response.statusCode == AppConstants.RESPONSE_CODE_SUCCESS) {
        List<dynamic> data = response.data["data"];

        listStatusDriver.value =
            data.map((e) => StatusDriverModel.fromJson(e)).toList();
      }
    } catch (e) {
      rethrow;
    } finally {
      Future.delayed(const Duration(seconds: 1), () {
        isLoadList(true);
      });
    }
  }
}
