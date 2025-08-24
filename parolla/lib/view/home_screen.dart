import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parolla/controller/home_controller.dart';
import 'package:parolla/model/question_model.dart';
import 'package:parolla/theme/app_colors.dart';
import 'package:parolla/view/widgets/custom_app_bar.dart';
import 'package:parolla/view/widgets/custom_text_field.dart';
import 'package:parolla/view/widgets/game_end_bottomsheet.dart';
import 'package:parolla/view/widgets/letter_box_widget.dart';
import 'package:parolla/view/widgets/progress_box.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController controller = Get.put(HomeController());
  @override
  void initState() {
    ever(controller.currentQuestionIndex, (_) {
      controller.scrollToCenter();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
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
                    Color? backgroundColor =
                        index == controller.currentQuestionIndex.value
                            ? AppColors.primaryColor
                            : AppColors.accentColor;
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
            SizedBox(
              height: 20,
            ),
            // Süre ve progress bar
            Obx(() => ProgressBox(
                remainingTime: controller.remainingSeconds.value /
                    controller.totalTime.value,
                formattedTime: controller.formattedTime)),
            const SizedBox(height: 32),
            const Text(
              "Soru",
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Obx(() => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                      height: 1.3,
                    ),
                    textAlign: TextAlign.center,
                    questionList[controller.currentQuestionIndex.value]
                        .question,
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
      ),
    );
  }
}
