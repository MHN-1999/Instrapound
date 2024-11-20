import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instrapound/_services/database_services/database_service.dart';
import 'package:instrapound/modules/auth/sign_up/v_sign_up.dart';
import 'package:instrapound/modules/auth/sign_up/verification/v_verification_page.dart';
import 'package:local_captcha/local_captcha.dart';

import '../../../../_common/c_datacontroller.dart';

class SignUpCaptchaController extends GetxController {
  DataController dataController = Get.find();
  LocalCaptchaController localCaptchaController = LocalCaptchaController();

  String strEmail = '';

  Timer captchaTimer = Timer(
    const Duration(seconds: 10),
    () {},
  );

  final int _captchaTimerInSecond = 10;

  ValueNotifier<int> captchaRefreshCooldown = ValueNotifier(0);
  ValueNotifier<bool> xValidCaptcha = ValueNotifier(false);

  TextEditingController txtCaptcha = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initLoad();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    captchaTimer.cancel();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    captchaTimer.cancel();
  }

  void initLoad() {
    strEmail = dataController.email;
    print("Captcha Email - " + strEmail);

    refreshCaptcha();
  }

  void refreshCaptcha() {
    if (captchaRefreshCooldown.value <= 0) {
      txtCaptcha.clear();
      localCaptchaController.refresh();
      _resetCaptchaTimer();
    }
  }

  void _resetCaptchaTimer() {
    captchaTimer.cancel();
    captchaRefreshCooldown.value = _captchaTimerInSecond;
    captchaTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        captchaRefreshCooldown.value = _captchaTimerInSecond - timer.tick;
        if (captchaRefreshCooldown.value < 1) {
          timer.cancel();
        }
      },
    );
  }

  Future<void> validateCaptcha() async {
    final query = txtCaptcha.text;
    try {
      final result = localCaptchaController.validate(query);
      if (result == LocalCaptchaValidation.valid) {
        xValidCaptcha.value = true;
        mySuccessDialog(
            "Captcha is valid! Press next to continue", true, Colors.green);
      } else if (result == LocalCaptchaValidation.invalidCode) {
        xValidCaptcha.value = false;
        mySuccessDialog(
            "Captcha is invalid! Please try again!", false, Colors.red);
      } else if (result == LocalCaptchaValidation.codeExpired) {
        xValidCaptcha.value = false;
        mySuccessDialog("Captcha is expired! Please refresh and try again!",
            false, Colors.red);
      }
    } catch (e1) {}
  }

  void onClickNext() async {
    DatabaseService databaseService = DatabaseService();
    myMessageLoadingDialog('Loading ... Please wait!');
    String? result = await databaseService.isEmailRegistered(strEmail);
    Get.back();

    if (result == null) {
      print('Sending OTP');
      dataController.sendOTP(strEmail);
      Get.to(() => const VerificationPage())?.whenComplete(() {
        xValidCaptcha.value = false;
        txtCaptcha.clear();
        localCaptchaController.refresh();
        _resetCaptchaTimer();
      });
    } else {
      Get.offAll(() => const SignUpPage());
      mySuccessDialog(result, false, Colors.red);
    }
  }
}
