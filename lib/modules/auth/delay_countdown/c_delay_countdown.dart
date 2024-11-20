import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instrapound/_common/c_datacontroller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DelayCountdownController extends GetxController {
  DataController dataController = Get.find();
  int delaySecond = 120;
  ValueNotifier<bool> xTimeUp = ValueNotifier(false);
  ValueNotifier<int> remainingSeconds = ValueNotifier(0);

  Timer? timer;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initLoad();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    saveRemainingSeconds(); // Save remaining seconds when the controller is disposed
    timer?.cancel();
  }

  void initLoad() async {
    int attempt = await getAttempt();
    if (attempt == 3) {
      delaySecond = 60;
    } else if (attempt == 4) {
      delaySecond = 90;
    } else if (attempt == 5) {
      delaySecond = 120;
    } else if (attempt == 6) {
      delaySecond = 300;
    } else if (attempt >= 7) {
      delaySecond = 1800;
    }
    await loadRemainingSeconds(); // Load saved remaining seconds at startup
    startCountdown();
  }

  void startCountdown() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
        saveRemainingSeconds(); // Save remaining seconds each tick
      } else {
        xTimeUp.value = true;
        timer.cancel();
        clearRemainingSeconds(); // Clear the saved time if countdown is finished
      }
    });
  }

  Future<void> saveRemainingSeconds() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('remainingSeconds', remainingSeconds.value);
  }

  Future<void> loadRemainingSeconds() async {
    final prefs = await SharedPreferences.getInstance();
    remainingSeconds.value = prefs.getInt('remainingSeconds') ?? delaySecond;
  }

  Future<void> clearRemainingSeconds() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs
        .remove('remainingSeconds'); // Clear saved value when countdown ends
  }

  String formatTime(int seconds) {
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  Future<int> getAttempt() async {
    int attempt = await dataController.getAttempt();
    print("Current attempt count: $attempt");
    return attempt;
  }
}
