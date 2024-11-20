import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instrapound/modules/auth/forgot_password/v_forgot_password.dart';
import 'package:instrapound/modules/auth/login/captcha/v_captcha.dart';

import '../../../_common/c_datacontroller.dart';

class LoginController extends GetxController {
  DataController dataController = Get.find();
  TextEditingController txtEmail = TextEditingController(text: "");
  TextEditingController txtPassword = TextEditingController(text: "");
  ValueNotifier<bool> xObscured = ValueNotifier(true);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void checkAllField() async {
    if (txtEmail.text.isNotEmpty && txtPassword.text.isNotEmpty) {
      dataController.email = txtEmail.text;
      dataController.password = txtPassword.text;
      Get.to(() => const LoginCaptchaPage());
    } else {
      mySuccessDialog("Enter all field", false, Colors.red);
    }
  }

  void onCLickForgotPassword(){
    Get.to(()=>const ForgotPasswordPage());
  }
}
