import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parolla/controller/home_controller.dart';
import 'package:parolla/model/QuestionModel.dart';
import 'package:parolla/theme/app_colors.dart';
import 'package:parolla/view/widgets/custom_text_field.dart';
import 'package:parolla/view/widgets/letter_box_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        centerTitle: true,
        title: const Text(
          "PAROLLA",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 80,
            child: ListView.builder(
              controller: controller.scrollController,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: questionList.length,
              itemBuilder: (context, index) {
                return Obx(() {
                  if (index == controller.currentQuestionIndex.value) {
                    controller.scrollToCenter();
                  }
                  Color? backgroundColor = Colors.transparent;
                  if (index < controller.currentQuestionIndex.value) {
                    backgroundColor = controller.answeredQuestions[index]
                        ? Colors.green
                        : Colors.red;
                  }
                  return Padding(
                    padding: EdgeInsets.only(
                        left: index == 0 ? width / 2 - 30 : 0, right: 8),
                    child: LetterBox(
                      letter: questionList[index].letter,
                      currentLetter:
                          questionList[controller.currentQuestionIndex.value]
                              .letter,
                      color: backgroundColor,
                    ),
                  );
                });
              },
            ),
          ),
          // Süre ve progress bar
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 12,
                ),
              ],
            ),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            child: Obx(() => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.timer,
                              size: 16, color: AppColors.textSecondary),
                          const SizedBox(width: 4),
                          const Text(
                            "Kalan Süre: ",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary),
                          ),
                          const Spacer(),
                          Text(
                            controller.formattedTime,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      LinearProgressIndicator(
                        borderRadius: BorderRadius.circular(16),
                        value: controller.remainingSeconds.value /
                            controller.totalTime.value,
                        backgroundColor: Colors.grey[300],
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(Colors.blue),
                        minHeight: 8,
                      ),
                    ],
                  ),
                )),
          ),
          const SizedBox(height: 14),
          Obx(() => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  style: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  questionList[controller.currentQuestionIndex.value].question,
                ),
              )),
          const Spacer(),
          Obx(() {
            return controller.remainingSeconds.value > 0
                ? CustomTextField(
                    focusNode: controller.focusNode,
                    controller: controller.textController,
                    onSubmitted: (value) {
                      controller.checkAnswer(value);
                    },
                  )
                : const SizedBox.shrink();
          }),
        ],
      ),
    );
  }
}
