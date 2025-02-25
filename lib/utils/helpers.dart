import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Format a Duration into a readable string (e.g., "25:00")
String formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));
  return "$minutes:$seconds";
}

/// Format a DateTime to a readable date string
String formatDate(DateTime date) {
  return DateFormat('MMM d, yyyy').format(date);
}

/// Format a DateTime to a readable time string
String formatTime(DateTime time) {
  return DateFormat('h:mm a').format(time);
}

/// Show a snackbar with a message
void showSnackBar(BuildContext context, String message,
    {bool isError = false}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: isError ? Colors.red : null,
      behavior: SnackBarBehavior.floating,
    ),
  );
}

/// Calculate the percentage of a value within a range
double calculatePercentage(int value, int total) {
  if (total == 0) return 0.0;
  return (value / total) * 100;
}

/// Get a color based on a percentage value
Color getColorFromPercentage(double percentage) {
  if (percentage >= 80) {
    return Colors.green;
  } else if (percentage >= 50) {
    return Colors.orange;
  } else {
    return Colors.red;
  }
}

/// Validate an email address
bool isValidEmail(String email) {
  return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
}

/// Validate a password (at least 8 characters, with at least one letter and one number)
bool isValidPassword(String password) {
  return password.length >= 8 &&
      RegExp(r'[A-Za-z]').hasMatch(password) &&
      RegExp(r'[0-9]').hasMatch(password);
}
