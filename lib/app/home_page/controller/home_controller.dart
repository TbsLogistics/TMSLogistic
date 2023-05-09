import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:tbs_logistics_tms/app/npt/driver/model/user_npt_model.dart';
import 'package:tbs_logistics_tms/app/tms/tms_page/model/user_model.dart';
import 'package:tbs_logistics_tms/config/share_preferences/share_preferences.dart';

class HomeController extends GetxController {
  Rx<UserModel> user = UserModel().obs;
  Rx<UserNptModel> user_npt = UserNptModel().obs;

  RxString tokenTms = "".obs;
  RxString tokenNpt = "".obs;
  RxString tokenHrm = "".obs;

  @override
  void onInit() {
    getUser();
    super.onInit();
  }

  void getUser() async {
    var tokenTMS = await SharePerApi().getTokenTMS();
    if (tokenTMS != null) {
      tokenTms.value = tokenTMS;
      Map<String, dynamic> decodedToken = JwtDecoder.decode(tokenTMS);
      user.value = UserModel.fromJson(decodedToken);
    }
    var tokenNPT = await SharePerApi().getTokenNPT();
    if (tokenNPT != null) {
      tokenNpt.value = tokenNPT;
      Map<String, dynamic> decodedToken = JwtDecoder.decode(tokenNPT);
      print(decodedToken);
      user_npt.value = UserNptModel.fromJson(decodedToken);
    }
    var tokenHRM = await SharePerApi().getTokenHRM();
    if (tokenHRM != null) {
      tokenHrm.value = tokenHRM;
      Map<String, dynamic> decodedToken = JwtDecoder.decode(tokenHRM);
      user.value = UserModel.fromJson(decodedToken);
    }
  }
}
