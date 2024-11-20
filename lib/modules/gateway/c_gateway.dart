import 'package:get/get.dart';
import 'package:instrapound/modules/auth/delay_countdown/v_delay_countdown.dart';
import 'package:instrapound/modules/auth/login/v_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GatewayController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initLoad();
  }

  void initLoad() async {
    final prefs = await SharedPreferences.getInstance();
    int? remainingSeconds = prefs.getInt('remainingSeconds');
    await Future.delayed(const Duration(seconds: 2));

    if (remainingSeconds == null) {
      Get.offAll(() => const LoginPage());
    } else {
      Get.offAll(() => const DelayCountdownPage());
    }
  }
}
