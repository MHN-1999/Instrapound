import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import 'package:instrapound/_common/c_theme_controller.dart';
import 'package:instrapound/modules/auth/sign_up/captcha/c_captcha.dart';
import 'package:local_captcha/local_captcha.dart';

import '../../../../_common/c_datacontroller.dart';

class SignUpCaptchaPage extends StatelessWidget {
  const SignUpCaptchaPage({super.key});

  @override
  Widget build(BuildContext context) {
    SignUpCaptchaController controller = Get.put(SignUpCaptchaController());
    return Scaffold(
      backgroundColor: const Color(0XFF262D39),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0XFF262D39),
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
        title: const Text(
          'CAPTCHA',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.04,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Captcha",
                    style: TextStyle(
                      color: secondary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  ValueListenableBuilder(
                    valueListenable: controller.captchaRefreshCooldown,
                    builder: (context, refreshCoolDown, child) {
                      if (refreshCoolDown < 1) {
                        return IconButton(
                            onPressed: () {
                              controller.refreshCaptcha();
                            },
                            icon: Icon(
                              Icons.refresh_rounded,
                              color: secondary,
                            ));
                      } else {
                        return Text(
                          "Refresh in $refreshCoolDown s",
                          style: const TextStyle(color: Colors.redAccent),
                        );
                      }
                    },
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder(
              future: Future.delayed(const Duration(milliseconds: 100)),
              initialData: "s",
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Center(
                    child: LocalCaptcha(
                      key: const Key("My Captcha"),
                      controller: controller.localCaptchaController,
                      height: 120,
                      width: Get.width,
                      chars:
                          'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789',
                      backgroundColor: Colors.transparent,
                      length: 6,
                      fontSize: 60.0,
                      textColors: const [
                        Colors.white,
                        Colors.pink,
                        Colors.deepPurpleAccent,
                        Colors.green,
                        Colors.yellow,
                      ],
                      noiseColors: const [
                        Colors.red,
                        Colors.green,
                        Colors.yellow,
                        Colors.deepPurple,
                        Colors.orange
                      ],
                      caseSensitive: false,
                      codeExpireAfter: const Duration(minutes: 10),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
            const Text(
              "Please type the letters inside the box above\n(Case sensitive)",
              style: TextStyle(color: Colors.white),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.txtCaptcha,
                    onTapOutside: (event) {
                      dismissKeyboard();
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusColor: secondary,
                        hintText: "Type here...",
                        hintStyle: TextStyle(color: secondary)),
                    style: TextStyle(fontSize: 15, color: secondary),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.validateCaptcha();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: background,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  ),
                  child: const Text(
                    "Check",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: ValueListenableBuilder(
                valueListenable: controller.xValidCaptcha,
                builder: (context, xValid, child) {
                  return ElevatedButton(
                    onPressed: () {
                      if (xValid) {
                        controller.onClickNext();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: background,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Next".tr,
                          style: TextStyle(
                              color: !xValid
                                  ? secondary.withOpacity(0.3)
                                  : secondary,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.arrow_forward_rounded,
                          size: 20,
                          color:
                              !xValid ? secondary.withOpacity(0.3) : secondary,
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
