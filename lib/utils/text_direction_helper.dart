import 'package:flutter/material.dart';

class TextDirectionHelper {
  static bool containsArabic(String text) {
    return text.contains(RegExp(r'[\u0600-\u06FF]'));
  }

  static TextDirection getTextDirection(String text) {
    return containsArabic(text) ? TextDirection.rtl : TextDirection.ltr;
  }
}
