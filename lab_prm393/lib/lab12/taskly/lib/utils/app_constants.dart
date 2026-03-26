import 'package:flutter/material.dart';

/// Hằng số ứng dụng
class AppConstants {
  static const double iconSize = 32.0;
  static const EdgeInsets listPadding = EdgeInsets.all(16.0);
  static const EdgeInsets imagePadding = EdgeInsets.all(8.0);
  static const Duration animationDuration = Duration(milliseconds: 300);
}

/// Styles cho text
class AppStyles {
  static const TextStyle normalTaskStyle = TextStyle(
    fontSize: 16,
    color: Colors.black,
  );

  static const TextStyle completedTaskStyle = TextStyle(
    fontSize: 16,
    color: Colors.grey,
    decoration: TextDecoration.lineThrough,
  );

  static const TextStyle titleStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
}