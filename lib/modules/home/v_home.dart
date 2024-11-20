import 'package:flutter/material.dart';
import 'package:instrapound/_common/c_theme_controller.dart';
import 'package:instrapound/modules/auth/login/v_login.dart';
import 'package:instrapound/modules/home/c_home.dart';
import 'package:get/get.dart';
import 'package:instrapound/modules/profile/profile_edit/v_profile_edit.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    return Scaffold(
      backgroundColor: const Color(0XFF262D39),
      appBar: AppBar(
        backgroundColor: secondary,
        title: ValueListenableBuilder(
          valueListenable: controller.name,
          builder: (context, name, child) {
            return Text(
              "Hello $name!",
              style: const TextStyle(
                fontSize: 15,
                color: Color(0XFF262D39),
              ),
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const ProfileEditPage())?.whenComplete(() {
                controller.initLoad();
              });
            },
            icon: const Icon(
              Icons.edit,
              size: 30,
              color: Color(0XFF262D39),
            ),
          ),
          IconButton(
            onPressed: () {
              Get.offAll(() => const LoginPage());
            },
            icon: const Icon(
              Icons.logout_outlined,
              size: 30,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
      body: Center(
        child: ValueListenableBuilder(
          valueListenable: controller.xFetching,
          builder: (context, xFetching, child) {
            if (xFetching) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ValueListenableBuilder(
                valueListenable: controller.userList,
                builder: (context, userList, child) {
                  if (userList.isEmpty) {
                    return Center(
                      child: ValueListenableBuilder(
                        valueListenable: controller.name,
                        builder: (context, name, child) {
                          return Text(
                            "Welcome $name!",
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: ListView.builder(
                        itemCount: userList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('ID - ${userList[index].id}'),
                                  Text('Name - ${userList[index].name}'),
                                  Text('Email - ${userList[index].email}'),
                                  Text(
                                      'Password - ${userList[index].password}'),
                                  Text(
                                      'Created Date - ${DateFormat("dd MMM yyyy - h:mm a").format(userList[index].createdAt)}'),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }
}
