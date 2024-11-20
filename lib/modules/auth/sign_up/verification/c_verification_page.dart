import 'dart:async';

import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instrapound/_common/c_datacontroller.dart';
import 'package:instrapound/_services/database_services/database_service.dart';
import 'package:instrapound/_services/encrypt_service/encrypt_service.dart';
import 'package:instrapound/modules/auth/login/v_login.dart';

class VerificationController extends GetxController {
  DataController dataController = Get.find();

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
    strEmail = dataController.email;
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
      makeLogin();
    } else {
      mySuccessDialog("Incorrect OTP", false, Colors.red);
    }
  }

  void makeLogin() async {
    myMessageLoadingDialog('Loading ... Please wait!');

    String? dbResult = "Something went wrong!";
    try {
      EncryptService encryptService = EncryptService();
      final name = dataController.name;
      final email = dataController.email;
      final password = dataController.password;

      final encryptedPwd = encryptService.encryptText(plainText: password);
      print(encryptedPwd);
      if (encryptedPwd == null) {
        throw Exception("Fail to encrypt password!");
      }
      DatabaseService databaseService = DatabaseService();
      dbResult = await databaseService.register(
        name: name,
        email: email,
        password: encryptedPwd,
        createdAt: DateTime.now(),
      );
    } catch (e) {
      print(e);
    }
    Get.back();

    if (dbResult == null) {
      //success
      Get.offAll(() => const LoginPage());
      mySuccessDialog("Successfully registered!\nPlease log in to continue!",
          true, Colors.green);
    } else {
      mySuccessDialog(dbResult, false, Colors.red);
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
