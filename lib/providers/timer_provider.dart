import 'package:flutter/foundation.dart';

class TimerProvider with ChangeNotifier {
  bool _isRunning = false;
  int _timeLeft = 25 * 60; // 25 minutes in seconds
  String _currentPhase = 'pomodoro';

  bool get isRunning => _isRunning;
  int get timeLeft => _timeLeft;
  String get currentPhase => _currentPhase;

  void startTimer() {
    _isRunning = true;
    notifyListeners();
  }

  void pauseTimer() {
    _isRunning = false;
    notifyListeners();
  }

  void resetTimer() {
    _isRunning = false;
    _timeLeft = 25 * 60;
    notifyListeners();
  }
}
