import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:instrapound/modules/auth/forgot_password/captcha/v_captcha.dart';

import '../../../_common/c_datacontroller.dart';

class ForgotPasswordController extends GetxController {
  String email = '';
  TextEditingController txtEmail = TextEditingController(text: '');
  ValueNotifier<bool> xValidEmail = ValueNotifier(false);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initLoad();
  }

  void initLoad() {}

  void checkAllField() {
    if (txtEmail.text.isNotEmpty) {
      if (xValidEmail.value) {
        email = txtEmail.text;
        Get.to(() => const ForgotCaptchaPage());
      } else {
        mySuccessDialog("Enter Valid Email", false, Colors.red);
      }
    } else {
      mySuccessDialog("Enter all field", false, Colors.red);
    }
  }

  void checkEmailOnChange() {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);
    final value = txtEmail.text;
    if (value.isEmpty || !regex.hasMatch(value)) {
      xValidEmail.value = false;
    } else {
      xValidEmail.value = true;
    }
  }
}
