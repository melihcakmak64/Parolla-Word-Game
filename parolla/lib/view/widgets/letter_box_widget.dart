import 'package:flutter/material.dart';

class LetterBox extends StatelessWidget {
  final String letter;
  final String currentLetter;
  final Color color;

  const LetterBox({required this.letter, required this.currentLetter, required this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: letter == currentLetter ? Colors.blue : Colors.transparent, // border rengi
          width: 2, // border kalınlığı
        ),
      ),
      child: Center(
        child: Text(
          letter,
          style: TextStyle(
            fontSize: 20,
            color: letter == currentLetter ? Colors.blue : Colors.black, // harf rengi
          ),
        ),
      ),
    );
  }
}
