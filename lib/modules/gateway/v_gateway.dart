import 'package:flutter/material.dart';
import 'package:instrapound/modules/gateway/c_gateway.dart';
import 'package:get/get.dart';

class GatewayPage extends StatelessWidget {
  const GatewayPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(GatewayController());
    return Scaffold(
      backgroundColor: const Color(0XFF262D39),
      body: Center(
        child: Image.asset(
          "assets/images/image.webp",
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
