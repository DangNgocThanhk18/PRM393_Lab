import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeatherHelpers {
  static String formatTemperature(double temp) {
    return '${temp.round()}°C';
  }

  static String formatWindSpeed(double speed) {
    return '${speed.toStringAsFixed(1)} km/h';
  }

  static String formatHumidity(int humidity) {
    return '$humidity%';
  }

  static String formatTime(DateTime time) {
    return DateFormat('HH:mm, EEE, MMM d').format(time);
  }

  static Color getTemperatureColor(double temp) {
    if (temp > 30) return Colors.red;
    if (temp > 20) return Colors.orange;
    if (temp > 10) return Colors.green;
    if (temp > 0) return Colors.blue;
    return Colors.purple;
  }
}