import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:instrapound/modules/auth/forgot_password/reset_password/c_reset_password.dart';
import 'package:get/get.dart';

import '../../../../_common/c_datacontroller.dart';
import '../../../../_common/c_theme_controller.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    ResetPasswordController controller = Get.put(ResetPasswordController());
    return Scaffold(
      backgroundColor: secondary,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: const Color(0XFF262D39),
        centerTitle: true,
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
          'Reset Password',
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ValueListenableBuilder(
                valueListenable: controller.xObscured,
                builder: (context, value, child) {
                  return TextField(
                    controller: controller.txtNewPassword,
                    obscureText: value,
                    maxLines: 1,
                    onTapOutside: (event) {
                      dismissKeyboard();
                    },
                    onChanged: (value) {
                      controller.checkPassowrdOnChange();
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
                      prefixIcon: const Icon(
                        Iconsax.password_check,
                        color: Colors.white,
                        size: 20,
                      ),
                      hintText: "New Password",
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.xObscured.value =
                              !controller.xObscured.value;
                        },
                        icon: value
                            ? const Icon(Iconsax.eye_slash)
                            : Icon(
                                Iconsax.eye,
                                color: secondary,
                              ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    ValueListenableBuilder(
                      valueListenable: controller.xhasUppercase,
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
                              'Has Uppercase',
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
                    ValueListenableBuilder(
                      valueListenable: controller.xhasLowercase,
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
                              'Has Lowercase',
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
                    ValueListenableBuilder(
                      valueListenable: controller.xhasDigits,
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
                              'Has Numbers',
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
                    ValueListenableBuilder(
                      valueListenable: controller.xhasSpecialCharacters,
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
                              'Has Special Characters (eg. *@#%&)',
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
                    ValueListenableBuilder(
                      valueListenable: controller.xhasMinLength,
                      builder: (context, value, child) {
                        return Row(
                          children: [
                            value
                                ? const Icon(
                                    Icons.check_box_outlined,
                                    size: 15,
                                    color: Colors.green,
                                  )
                                : const Icon(
                                    Icons.check_box_outline_blank,
                                    size: 15,
                                  ),
                            Text(
                              'Has 8 Digits',
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
                    // Row(
                    //   children: [
                    //     ValueListenableBuilder(
                    //       valueListenable: controller.xScoreLoading,
                    //       builder: (context, value, child) {
                    //         if (value) {
                    //           return const SizedBox(
                    //             width: 10,
                    //             height: 10,
                    //             child: CircularProgressIndicator(
                    //               strokeWidth: 2,
                    //             ),
                    //           );
                    //         } else {
                    //           return ValueListenableBuilder(
                    //             valueListenable: controller.xvalidScore,
                    //             builder: (context, value, child) {
                    //               if (value) {
                    //                 return const Icon(
                    //                   Icons.check_box_outlined,
                    //                   size: 15,
                    //                   color: Colors.green,
                    //                 );
                    //               } else {
                    //                 return const Icon(
                    //                   Icons.check_box_outline_blank,
                    //                   size: 15,
                    //                 );
                    //               }
                    //             },
                    //           );
                    //         }
                    //       },
                    //     ),
                    //     ValueListenableBuilder(
                    //       valueListenable: controller.score,
                    //       builder: (context, value, child) {
                    //         return Text(
                    //           'Password Score - ' + value,
                    //           textAlign: TextAlign.left,
                    //           style: TextStyle(
                    //             color: onBackground,
                    //             fontWeight: FontWeight.w500,
                    //             fontSize: 12,
                    //           ),
                    //         );
                    //       },
                    //     )
                    //   ],
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    ValueListenableBuilder(
                      valueListenable: controller.xObscured2,
                      builder: (context, value, child) {
                        return TextField(
                          controller: controller.txtNewPasswordConfirm,
                          obscureText: value,
                          maxLines: 1,
                          onTapOutside: (event) {
                            dismissKeyboard();
                          },
                          onChanged: (value) {
                            controller.checkPassowrdOnChange();
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
                            prefixIcon: const Icon(
                              Iconsax.password_check,
                              color: Colors.white,
                              size: 20,
                            ),
                            hintText: "New Password Confirm",
                            suffixIcon: IconButton(
                              onPressed: () {
                                controller.xObscured2.value =
                                    !controller.xObscured2.value;
                              },
                              icon: value
                                  ? const Icon(Iconsax.eye_slash)
                                  : Icon(
                                      Iconsax.eye,
                                      color: secondary,
                                    ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
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
