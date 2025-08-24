import 'package:flutter/material.dart';

extension BottomSheetExtension on BuildContext {
  Future<T?> showBottomSheetWidget<T>({
    required Widget child,
    bool isScrollControlled = true,
    Color backgroundColor = Colors.white,
    double borderRadius = 16,
  }) {
    return showModalBottomSheet<T>(
      context: this,
      isScrollControlled: isScrollControlled,
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(borderRadius)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(this)
              .viewInsets
              .bottom, // klavye açılırsa boşluk bırak
        ),
        child: child,
      ),
    );
  }
}
