import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instrapound/_common/c_datacontroller.dart';
import 'package:instrapound/modules/auth/forgot_password/c_forgot_password.dart';

import '../../../../_services/database_services/database_service.dart';
import '../../../../_services/encrypt_service/encrypt_service.dart';
import '../../login/v_login.dart';

class ResetPasswordController extends GetxController {
  String strEmail = '';
  DataController dataController = Get.find();
  ForgotPasswordController forgotPasswordController = Get.find();

  TextEditingController txtNewPassword = TextEditingController(text: '');
  TextEditingController txtNewPasswordConfirm = TextEditingController(text: '');

  ValueNotifier<bool> xObscured = ValueNotifier(true);
  ValueNotifier<bool> xObscured2 = ValueNotifier(true);

  ValueNotifier<bool> xScoreLoading = ValueNotifier(false);

  ValueNotifier<String> score = ValueNotifier('Weak');

  ValueNotifier<bool> xValidEmail = ValueNotifier(false);
  ValueNotifier<bool> xhasUppercase = ValueNotifier(false);
  ValueNotifier<bool> xhasLowercase = ValueNotifier(false);
  ValueNotifier<bool> xhasDigits = ValueNotifier(false);
  ValueNotifier<bool> xhasSpecialCharacters = ValueNotifier(false);
  ValueNotifier<bool> xhasMinLength = ValueNotifier(false);
  ValueNotifier<bool> xvalidScore = ValueNotifier(false);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initLoad();
  }

  void initLoad() {
    strEmail = forgotPasswordController.email;
    print("reset Email - " + strEmail);
  }

  void checkAllField() {
    if (txtNewPassword.text.isNotEmpty &&
        txtNewPasswordConfirm.text.isNotEmpty) {
      if (txtNewPassword.text == txtNewPasswordConfirm.text) {
        String message = dataController.getFeedbackMessage(txtNewPassword.text);
        if (message == 'ok') {
          resetPassword();
        } else {
          mySuccessDialog(message, false, Colors.red);
        }
      } else {
        mySuccessDialog("Password didn't match.", false, Colors.red);
      }
    } else {
      myMessageDialog('Please Enter All Fields.');
    }
  }

  void resetPassword() async {
    myMessageLoadingDialog('Loading ... Please wait!');

    String? dbResult = "Something went wrong!";
    try {
      EncryptService encryptService = EncryptService();
      final email = strEmail;
      final newPassword = txtNewPassword.text;

      final encryptedPwd = encryptService.encryptText(plainText: newPassword);
      print(encryptedPwd);
      if (encryptedPwd == null) {
        throw Exception("Fail to encrypt password!");
      }
      DatabaseService databaseService = DatabaseService();
      dbResult = await databaseService.updatePassword(
        email: email,
        newPassword: encryptedPwd,
      );
    } catch (e) {
      print(e);
    }
    Get.back();

    if (dbResult == null) {
      //success
      Get.offAll(() => const LoginPage());
      mySuccessDialog(
          "Reset Successful!\nPlease log in to continue!", true, Colors.green);
    } else {
      mySuccessDialog(dbResult, false, Colors.red);
    }
  }

  void checkPassowrdOnChange() async {
    checkPasswordStrength(txtNewPassword.text);
  }

  void checkPasswordStrength(String password) {
    // Define the criteria
    final bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    final bool hasDigits = password.contains(RegExp(r'\d'));
    final bool hasSpecialCharacters =
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    final bool hasMinLength = password.length >= 8;

    if (hasUppercase) {
      xhasUppercase.value = true;
    } else {
      xhasUppercase.value = false;
    }
    if (hasLowercase) {
      xhasLowercase.value = true;
    } else {
      xhasLowercase.value = false;
    }
    if (hasDigits) {
      xhasDigits.value = true;
    } else {
      xhasDigits.value = false;
    }
    if (hasSpecialCharacters) {
      xhasSpecialCharacters.value = true;
    } else {
      xhasSpecialCharacters.value = false;
    }
    if (hasMinLength) {
      xhasMinLength.value = true;
    } else {
      xhasMinLength.value = false;
    }
  }
}
