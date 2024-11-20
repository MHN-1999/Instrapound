import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instrapound/_common/c_theme_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataController extends GetxController {
  String name = '';
  String email = '';
  String password = '';

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initLoad();
  }

  void initLoad() {
    EmailOTP.config(
      appName: 'Instrapound - Register OTP',
      otpType: OTPType.numeric,
      expiry: 60000,
      emailTheme: EmailTheme.v3,
      appEmail: 'instrapound@gmail.com',
      otpLength: 6,
    );
  }

  Future<void> saveAttempt(int attempt) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('attempt', attempt);
  }

  Future<int> getAttempt() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('attempt') ?? 0;
  }

  Future<bool> sendOTP(String email) async {
    bool result = false;
    try {
      result = await EmailOTP.sendOTP(email: email);
    } catch (e1) {
      print(e1);
    }
    return result;
  }

  String getFeedbackMessage(String password) {
    // Define the criteria
    final bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    final bool hasDigits = password.contains(RegExp(r'\d'));
    final bool hasSpecialCharacters =
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    final bool hasMinLength = password.length >= 8;

    // Return true if all criteria are met, otherwise return false
    if (!hasUppercase) {
      return 'Passowrd Should Contain Uppercase';
    } else if (!hasLowercase) {
      return 'Passowrd Should Contain Lowercase';
    } else if (!hasDigits) {
      return 'Passowrd Should Contain Numbers';
    } else if (!hasSpecialCharacters) {
      return 'Passowrd Should Contain Special Characters';
    } else if (!hasMinLength) {
      return 'Passowrd should have at least 8 digits';
    } else {
      return 'ok';
    }
  }

  // Future<String> checkPassowrdScore(String password) async {
  //   String url =
  //       'https://password-strength-backend.onrender.com/classify_password?password=$password';
  //   GetConnect client = GetConnect(timeout: const Duration(seconds: 30));
  //   try {
  //     final response = await client.get(url);
  //     if (response.isOk) {
  //       String score = response.body['strength_score'].toString();
  //       print(response.bodyString);
  //       return score;
  //     } else {
  //       return '';
  //     }
  //   } catch (e) {}
  //   return '';
  // }
}

void dismissKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

void myMessageLoadingDialog(String message) {
  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Center(
              child: CircularProgressIndicator(),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
    barrierDismissible: false,
  );
}

void myMessageDialog(String message) {
  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              // child: const Icon(
              //   Icons.info,
              //   color: Colors.white,
              //   size: 36,
              // ),
              child: const Center(
                child: Text(
                  '!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
    barrierDismissible: true,
  );
}

void mySuccessDialog(String message, bool type_, Color color) {
  Get.dialog(
    Dialog(
      backgroundColor: const Color(0XFF262D39),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: type_
                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 36,
                    )
                  : const Icon(
                      Icons.clear_rounded,
                      color: Colors.white,
                      size: 36,
                    ),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: TextStyle(
                fontSize: 16,
                color: secondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
    barrierDismissible: true,
  );
}
