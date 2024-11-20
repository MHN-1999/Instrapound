import 'package:flutter/material.dart';
import 'package:instrapound/modules/auth/delay_countdown/c_delay_countdown.dart';
import 'package:get/get.dart';
import 'package:instrapound/modules/auth/login/v_login.dart';

import '../../../_common/c_theme_controller.dart';

class DelayCountdownPage extends StatelessWidget {
  const DelayCountdownPage({super.key});

  @override
  Widget build(BuildContext context) {
    DelayCountdownController controller = Get.put(DelayCountdownController());
    return Scaffold(
      backgroundColor: const Color(0XFF262D39),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(height: 70,),
              Text(
                "Incorrect attempts reached the limit.\nPlease try again in -".tr,
                style: const  TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w300),
              ),
              const SizedBox(height: 50,),
              ValueListenableBuilder(
                valueListenable: controller.remainingSeconds,
                builder: (context, value, child) {
                  return Text(
                    controller.formatTime(value),
                    style: TextStyle(fontSize: 28, color: secondary,fontWeight: FontWeight.w300),
                  );
                },
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: ValueListenableBuilder(
                  valueListenable: controller.xTimeUp,
                  builder: (context, xValid, child) {
                    return ElevatedButton(
                      onPressed: () {
                        if (xValid) {
                          Get.offAll(() => const LoginPage());
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
                            "Try Again".tr,
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
                            color: !xValid
                                ? secondary.withOpacity(0.3)
                                : secondary,
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
      ),
    );
  }
}
