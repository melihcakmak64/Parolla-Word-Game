import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:parolla/model/question_model.dart';
import 'package:parolla/view/widgets/game_end_bottomsheet.dart';

class HomeController extends GetxController {
  var currentQuestionIndex = 0.obs;
  var remainingSeconds = 180.obs;
  var totalScore = 0.obs; // Toplam puan
  var answeredQuestions = <bool>[].obs; // Soruların doğru/yanlış durumu
  var isGameEnded = false.obs;
  late Timer timer;
  late ScrollController scrollController;
  late TextEditingController textController;
  late FocusNode focusNode;

  final totalTime = 180.obs; // Süre başlangıç değeri

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    textController = TextEditingController();
    focusNode = FocusNode();
    answeredQuestions.value = List.filled(
        questionList.length, false); // Başlangıçta tüm sorular yanlış
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        timer.cancel();
        isGameEnded.value = true;
      }
    });
  }

  void scrollToCenter() {
    if (scrollController.hasClients) {
      final double targetPosition = currentQuestionIndex.value * 50.0;
      scrollController.animateTo(
        targetPosition,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void checkAnswer(String answer) {
    if (answer.toLowerCase() ==
        questionList[currentQuestionIndex.value].answer.toLowerCase()) {
      totalScore.value += 10; // Doğru cevap için puan ekle
      answeredQuestions[currentQuestionIndex.value] = true; // Doğru işaretle
    } else {
      answeredQuestions[currentQuestionIndex.value] = false; // Yanlış işaretle
    }

    // Soruların sonuna ulaşıp ulaşmadığımızı kontrol ediyoruz
    if (currentQuestionIndex.value < questionList.length - 1) {
      currentQuestionIndex.value += 1;
      textController.text = "";
      scrollToCenter();
      focusNode.requestFocus();
    } else {
      timer.cancel();
      isGameEnded.value = true;
      // Oyun bitince sonucu göster
    }
  }

  void resetGame() {
    isGameEnded.value = false;
    currentQuestionIndex.value = 0;
    remainingSeconds.value = 180;
    totalScore.value = 0;
    answeredQuestions.value = List.filled(questionList.length, false);
    startTimer();
    textController.text = "";
    scrollToCenter();
  }

  @override
  void onClose() {
    scrollController.dispose();
    timer.cancel();
    textController.dispose();
    focusNode.dispose();
    super.onClose();
  }

  String get formattedTime {
    int minutes = remainingSeconds.value ~/ 60;
    int seconds = remainingSeconds.value % 60;
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }
}
