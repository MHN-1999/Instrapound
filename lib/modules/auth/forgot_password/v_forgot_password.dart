import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:instrapound/modules/auth/forgot_password/c_forgot_password.dart';
import 'package:get/get.dart';

import '../../../_common/c_datacontroller.dart';
import '../../../_common/c_theme_controller.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    ForgotPasswordController controller = Get.put(ForgotPasswordController());
    return Scaffold(
      // backgroundColor: const Color(0XFF262D39),
      backgroundColor: secondary,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: const Color(0XFF262D39),
        centerTitle: true,
        title: const Text(
          'Forgot Password',
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Iconsax.arrow_left,
            color: Colors.white,
            size: 25,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 35),
              const Text(
                'Don’t worry.\nEnter your email and we’ll send you a code to reset your password.',
                style: TextStyle(fontSize: 22),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: controller.txtEmail,
                keyboardType: TextInputType.emailAddress,
                maxLines: 1,
                onTapOutside: (event) {
                  dismissKeyboard();
                },
                onChanged: (value) {
                  controller.checkEmailOnChange();
                },
                cursorWidth: 1,
                cursorColor: secondary,
                cursorHeight: 15,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: onBackground,
                    prefixIcon:
                        const Icon(Icons.email, size: 20, color: Colors.white),
                    hintText: "Email"),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: ValueListenableBuilder(
                  valueListenable: controller.xValidEmail,
                  builder: (context, value, child) {
                    return Row(
                      children: [
                        value
                            ? const Icon(Icons.check_box_outlined,
                                size: 15, color: Colors.green)
                            : const Icon(
                                Icons.check_box_outline_blank,
                                size: 15,
                              ),
                        Text(
                          'Valid Email',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: onBackground,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  controller.checkAllField();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: background,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                ),
                child: const Text(
                  "Continue",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
