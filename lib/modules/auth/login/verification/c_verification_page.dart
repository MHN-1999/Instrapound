import 'dart:async';

import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instrapound/_common/c_datacontroller.dart';
import 'package:instrapound/_services/database_services/database_service.dart';
import 'package:instrapound/_services/encrypt_service/encrypt_service.dart';
import 'package:instrapound/modules/auth/login/v_login.dart';

import '../../../home/v_home.dart';
import '../../delay_countdown/v_delay_countdown.dart';

class LoginVerificationController extends GetxController {
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

  Future<void> makeLogin() async {
    myMessageLoadingDialog('Loading... Please wait!');
    try {
      final email = dataController.email;
      final inputPassword = dataController.password;

      DatabaseService databaseService = DatabaseService();
      EncryptService encryptService = EncryptService();

      // Fetch the hashed password from the database
      String? hashedPassword = await databaseService.getPassword(email);

      // Close the loading dialog
      Get.back();

      // Handle specific error cases
      if (hashedPassword == "Unable to connect to the server!") {
        return mySuccessDialog(
            "Unable to connect to the server!", false, Colors.red);
      } else if (hashedPassword == "error") {
        return mySuccessDialog("Something went wrong.", false, Colors.red);
      } else if (hashedPassword == null) {
        return mySuccessDialog("Incorrect credentials.", false, Colors.red);
      }

      // Decrypt and validate password
      String? decryptedPassword =
          encryptService.decryptText(encryptedText: hashedPassword);

      print("hashed Password -- " + hashedPassword);
      print("decripted Passowrd -- " + decryptedPassword.toString());
      print("input password -- " + inputPassword);

      if (decryptedPassword == inputPassword) {
        await dataController.saveAttempt(0);
        Get.offAll(() => const HomePage());
      } else {
        int attempt = await handleLoginAttempt();
        print("Updated attempt count: $attempt");

        if (attempt >= 3) {
          Get.to(() => const DelayCountdownPage());
          return;
        }
        // For incorrect attempts under the limit
        Get.offAll(() => const LoginPage());
        mySuccessDialog("Incorrect credentials.", false, Colors.red);
      }
    } catch (e) {
      print("Error during login: $e");
      mySuccessDialog("An unexpected error occurred.", false, Colors.red);
    }
  }

  Future<int> handleLoginAttempt() async {
    int attempt = await dataController.getAttempt();
    print("Current attempt count: $attempt");
    attempt++;
    await dataController.saveAttempt(attempt);
    return attempt;
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
