import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instrapound/models/me_model.dart';

import '../../_common/c_datacontroller.dart';
import '../../_services/database_services/database_service.dart';
import '../../_services/encrypt_service/encrypt_service.dart';

class HomeController extends GetxController {
  EncryptService encryptService = EncryptService();
  DatabaseService databaseService = DatabaseService();

  DataController dataController = Get.find();
  ValueNotifier<String> name = ValueNotifier("-");
  ValueNotifier<List<MeModel>> userList = ValueNotifier([]);
  ValueNotifier<bool> xFetching = ValueNotifier(false);
  String email = '';
  String password = '';

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      email = dataController.email;
      password = dataController.password;
      initLoad();
    });
  }

  void initLoad() async {
    try {
      String? encryptedPassword =
          encryptService.encryptText(plainText: password);

      print("Getting User Info");

      myMessageLoadingDialog('Loading ... Please wait!');
      final user = await databaseService.getUser(
          email: email, password: encryptedPassword!);

      if (user != null) {
        print("Name: " + user['name']);
        print("Email: " + email);
        print("Input password: " + password);
        print("Encrypted password: " + encryptedPassword.toString());

        name.value = user['name'];

        var userId = user['_id'];
        fetchAllUsers(userId.oid);
      } else {
        print("User not found or invalid credentials.");
      }

      Get.back();
    } catch (e) {
      print(e);
    }
  }

  void fetchAllUsers(String id) async {
    if (id == '673dd3838ec51a90cc000000') {
      print("this is admin");
      xFetching.value = true;
      List<MeModel> temp = await databaseService.getAllUser();
      userList.value = [...temp];
      xFetching.value = false;
    } else {
      print("this is not admin");
    }
  }
}
