import 'package:flutter/material.dart';
import 'package:parolla/theme/app_colors.dart';

class LetterBox extends StatelessWidget {
  final String letter;
  final String currentLetter;
  final Color color;

  const LetterBox(
      {required this.letter,
      required this.currentLetter,
      required this.color,
      super.key});

  @override
  Widget build(BuildContext context) {
    final isActive = letter == currentLetter;
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: isActive
            ? Border.all(color: Colors.indigo.shade300, width: 3)
            : null,
        boxShadow: isActive
            ? [const BoxShadow(color: Colors.black26, blurRadius: 6)]
            : null,
      ),
      child: Center(
        child: Text(
          letter,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: letter == currentLetter
                  ? Colors.white
                  : AppColors.textSecondary // harf rengi
              ),
        ),
      ),
    );
  }
}
