import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import 'providers/settings_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    ChangeNotifierProvider(
      create: (_) => SettingsProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pomodoro Timer")),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.account_circle, size: 50, color: Colors.white),
                  SizedBox(height: 10),
                  Text("Hello, User!",
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Logout"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Center(child: PomodoroPage()),
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Center(child: Text("Settings Page")),
    );
  }
}

class _PomodoroPageState extends State<PomodoroPage> {
  final FirebaseService _firebaseService = FirebaseService();
  String _selectedAudio = 'bell.mp3';
  String _backgroundImage = 'default.jpg';

  // Add these to existing variables
  AudioPlayer _audioPlayer = AudioPlayer();

  Widget _buildControlButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: Icon(Icons.music_note),
          onPressed: _showAudioSelection,
        ),
        IconButton(
          icon: Icon(Icons.timer),
          onPressed: _showTimerAdjustment,
        ),
        IconButton(
          icon: Icon(Icons.swap_horiz),
          onPressed: _toggleMode,
        ),
      ],
    );
  }

  void _showAudioSelection() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Sound'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('Bell'),
              onTap: () => _selectAudio('bell.mp3'),
            ),
            ListTile(
              title: Text('Chime'),
              onTap: () => _selectAudio('chime.mp3'),
            ),
          ],
        ),
      ),
    );
  }

  void _showTimerAdjustment() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Adjust Timer'),
        content: NumberPicker(
          value: _duration ~/ 60,
          minValue: 1,
          maxValue: 60,
          onChanged: (value) {
            setState(() {
              _duration = value * 60;
              _timeLeft = _duration;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/backgrounds/$_backgroundImage'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ... existing timer display code ...

            _buildControlButtons(),

            ElevatedButton(
              onPressed: _isRunning
                  ? null
                  : () {
                      _startTimer();
                      setState(() {
                        _showCancelButton = true;
                      });
                    },
              child: Text('Start'),
            ),

            if (_showCancelButton)
              ElevatedButton(
                onPressed: () {
                  _cancelTimer();
                  setState(() {
                    _showCancelButton = false;
                  });
                },
                child: Text('Cancel'),
                style: ElevatedButton.styleFrom(primary: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  final int timeLeft;
  final int totalTime;

  ClockPainter(this.timeLeft, this.totalTime);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final paintCircle = Paint()..color = Colors.red.withOpacity(0.3);
    final paintHand = Paint()
      ..color = Colors.red
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, paintCircle);

    double angle = 2 * pi * (1 - (timeLeft / totalTime));
    final handX = center.dx + radius * -0.8 * cos(angle - pi / 2);
    final handY = center.dy + radius * 0.8 * sin(angle - pi / 2);

    canvas.drawLine(center, Offset(handX, handY), paintHand);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
