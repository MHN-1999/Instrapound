import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:instrapound/modules/auth/login/v_login.dart';
import 'package:instrapound/modules/auth/sign_up/c_sign_up.dart';

import '../../../_common/c_datacontroller.dart';
import '../../../_common/c_theme_controller.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    SignUpController controller = Get.put(SignUpController());
    return Scaffold(
      // appBar: AppBar(
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         controller.testDB();
      //       },
      //       icon: Icon(Icons.add),
      //     ),
      //     IconButton(
      //       onPressed: () {
      //         EncryptService encryptService = EncryptService();
      //         String? test = encryptService.decryptText(
      //             encryptedText: "BsSaR8Lf+as4QX+cEIZCzQ==");
      //         print(test.toString());

      //         String? test2 = encryptService.encryptText(
      //             plainText: "ViCiu123@");
      //         print(test2.toString());
      //       },
      //       icon: Icon(Icons.document_scanner),
      //     )
      //   ],
      // ),
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0XFF262D39),
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              "assets/images/image.webp",
              fit: BoxFit.fill,
            ),
            SingleChildScrollView(
              child: SizedBox(
                height: Get.height - 20,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 520,
                        decoration: BoxDecoration(
                            color: secondary,
                            borderRadius: BorderRadius.circular(40)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 10,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "SIGN UP",
                                style:
                                    TextStyle(fontSize: 20, color: background),
                              ),
                              TextField(
                                controller: controller.txtName,
                                keyboardType: TextInputType.name,
                                maxLines: 1,
                                onTapOutside: (event) {
                                  dismissKeyboard();
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
                                        Iconsax.profile_2user,
                                        size: 20,
                                        color: Colors.white),
                                    hintText: "Name"),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
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
                                    prefixIcon: const Icon(Icons.email,
                                        size: 20, color: Colors.white),
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
                                            ? const Icon(
                                                Icons.check_box_outlined,
                                                size: 15,
                                                color: Colors.green)
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
                              const SizedBox(
                                height: 10,
                              ),
                              ValueListenableBuilder(
                                valueListenable: controller.xObscured,
                                builder: (context, value, child) {
                                  return TextField(
                                    controller: controller.txtPassword,
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
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      fillColor: onBackground,
                                      prefixIcon: const Icon(
                                        Iconsax.password_check,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      hintText: "Password",
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
                                                ? const Icon(
                                                    Icons.check_box_outlined,
                                                    size: 15,
                                                    color: Colors.green)
                                                : const Icon(
                                                    Icons
                                                        .check_box_outline_blank,
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
                                                ? const Icon(
                                                    Icons.check_box_outlined,
                                                    size: 15,
                                                    color: Colors.green)
                                                : const Icon(
                                                    Icons
                                                        .check_box_outline_blank,
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
                                                ? const Icon(
                                                    Icons.check_box_outlined,
                                                    size: 15,
                                                    color: Colors.green)
                                                : const Icon(
                                                    Icons
                                                        .check_box_outline_blank,
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
                                      valueListenable:
                                          controller.xhasSpecialCharacters,
                                      builder: (context, value, child) {
                                        return Row(
                                          children: [
                                            value
                                                ? const Icon(
                                                    Icons.check_box_outlined,
                                                    size: 15,
                                                    color: Colors.green)
                                                : const Icon(
                                                    Icons
                                                        .check_box_outline_blank,
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
                                                    Icons
                                                        .check_box_outline_blank,
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
                                    //       valueListenable:
                                    //           controller.xScoreLoading,
                                    //       builder: (context, value, child) {
                                    //         if (value) {
                                    //           return const SizedBox(
                                    //             width: 10,
                                    //             height: 10,
                                    //             child:
                                    //                 CircularProgressIndicator(
                                    //               strokeWidth: 2,
                                    //             ),
                                    //           );
                                    //         } else {
                                    //           return ValueListenableBuilder(
                                    //             valueListenable:
                                    //                 controller.xvalidScore,
                                    //             builder:
                                    //                 (context, value, child) {
                                    //               if (value) {
                                    //                 return const Icon(
                                    //                   Icons.check_box_outlined,
                                    //                   size: 15,
                                    //                   color: Colors.green,
                                    //                 );
                                    //               } else {
                                    //                 return const Icon(
                                    //                   Icons
                                    //                       .check_box_outline_blank,
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
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10,),
                              ///
                              ValueListenableBuilder(
                                valueListenable: controller.xObscured2,
                                builder: (context, value, child) {
                                  return TextField(
                                    controller: controller.txtPasswordConfirm,
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
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      fillColor: onBackground,
                                      prefixIcon: const Icon(
                                        Iconsax.password_check,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      hintText: "Confirm Password",
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
                              ///
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  controller.checkAllField();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: background,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50, vertical: 10),
                                ),
                                child: const Text(
                                  "SIGN UP",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.offAll(() => const LoginPage());
                                },
                                child: const Text(
                                  "LOGIN",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
