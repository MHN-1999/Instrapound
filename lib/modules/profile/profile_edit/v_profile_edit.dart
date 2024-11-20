import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:instrapound/modules/profile/profile_edit/c_profile_edit.dart';

import '../../../_common/c_datacontroller.dart';
import '../../../_common/c_theme_controller.dart';

class ProfileEditPage extends StatelessWidget {
  const ProfileEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileEditController controller = Get.put(ProfileEditController());
    return Scaffold(
      backgroundColor: secondary,
      appBar: AppBar(
        backgroundColor: const Color(0XFF262D39),
        title: Text(
          "Profile Edit",
          style: TextStyle(fontSize: 18, color: secondary),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
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
                    prefixIcon: const Icon(Iconsax.profile_2user,
                        size: 20, color: Colors.white),
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
                  ],
                ),
              ),
              const SizedBox(height: 10),

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
              const SizedBox(height: 10),
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
