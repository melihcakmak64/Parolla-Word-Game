import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final void Function(String) onSubmitted; // Dışarıdan alınacak onChanged fonksiyonu
  final TextEditingController controller;
  final FocusNode focusNode;

  const CustomTextField(
      {super.key,
      required this.onSubmitted,
      required this.controller,
      required this.focusNode}); // Constructor'a onChanged ekledik

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          hintText: 'Cevabınızı buraya yazın...', // Hint metni
          border: OutlineInputBorder(
            // Outline border
            borderRadius: BorderRadius.circular(12), // Kenar yuvarlama
            borderSide: const BorderSide(color: Colors.blue, width: 2), // Border rengi ve kalınlığı
          ),
          focusedBorder: OutlineInputBorder(
            // Fokuslanınca border rengi değişir
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.green, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            // Başka bir stil, TextField etkinse
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.grey, width: 1),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20), // İçerik etrafındaki boşluk
        ),
        style: const TextStyle(fontSize: 18, color: Colors.black), // Yazı stili
      ),
    );
  }
}
