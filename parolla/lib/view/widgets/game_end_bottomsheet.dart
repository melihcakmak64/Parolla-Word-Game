import 'package:flutter/material.dart';

class GameEndBottomsheet extends StatelessWidget {
  final int correctAnswer;
  final int totalQuestions;
  final int totalScore;
  final VoidCallback onPlayAgain;
  const GameEndBottomsheet(
      {super.key,
      required this.correctAnswer,
      required this.totalQuestions,
      required this.totalScore,
      required this.onPlayAgain});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFE6E4DB),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Title
          const Padding(
            padding: EdgeInsets.only(top: 12, bottom: 4),
            child: Text(
              "Game Over!",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF181711),
              ),
            ),
          ),

          // Subtitle
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Text(
              "The clock has run out. Let's see how you did!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF181711),
              ),
            ),
          ),

          // Stats
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children: [
                _buildStatRow(
                    "Correct Answers", "$correctAnswer/$totalQuestions"),
                _buildStatRow("Total Score", "$totalScore"),
              ],
            ),
          ),

          // Buttons
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF2C80D),
                foregroundColor: const Color(0xFF181711),
                minimumSize: const Size.fromHeight(48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: onPlayAgain,
              child: const Text(
                "Play Again",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildStatRow(String label, String value) {
  return Column(
    children: [
      const Divider(color: Color(0xFFE6E4DB)),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF8A8360),
                fontSize: 14,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                color: Color(0xFF181711),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
