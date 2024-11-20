import 'dart:async';

import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instrapound/_common/c_datacontroller.dart';
import 'package:instrapound/modules/auth/forgot_password/c_forgot_password.dart';
import 'package:instrapound/modules/auth/forgot_password/reset_password/v_reset_password.dart';

class ForgotVerificationController extends GetxController {
  DataController dataController = Get.find();
  ForgotPasswordController forgotPasswordController = Get.find();

  String strEmail = '';

  TextEditingController pinController = TextEditingController();
  FocusNode focusNode = FocusNode();
  ValueNotifier<int> remainingSeconds = ValueNotifier(60);
  ValueNotifier<bool> xSendAgain = ValueNotifier(false);
  ValueNotifier<bool> xFetching = ValueNotifier(false);

  Timer? timer;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initLoad();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel();
  }

  void initLoad() async {
    strEmail = forgotPasswordController.email;
    print("Verification Email - " + strEmail);
    startCountdown();
  }

  Future<void> varifyOTP(String pin) async {
    bool result = false;
    try {
      result = EmailOTP.verifyOTP(otp: pin);
    } catch (e1) {
      print(e1);
      mySuccessDialog(e1.toString(), false, Colors.red);
    }
    if (result) {
      Get.to(() => const ResetPasswordPage());
    } else {
      mySuccessDialog("Incorrect OTP", false, Colors.red);
    }
  }

  void sendCodeAgain() {
    if (xSendAgain.value) {
      print('send again');
      xSendAgain.value = false;
      dataController.sendOTP(strEmail);
      remainingSeconds.value = 60;
      startCountdown();
      pinController.clear();
    } else {
      print("not now");
    }
  }

  void startCountdown() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        xSendAgain.value = true;
        timer.cancel();
      }
    });
  }

  String formatTime(int seconds) {
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}
