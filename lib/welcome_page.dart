import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to FocusMate',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'How to use:\n'
                  '1. Set your timer duration\n'
                  '2. Choose your preferred sound\n'
                  '3. Select timer display style\n'
                  '4. Click start to begin focusing!',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, '/login'),
                child: Text('Get Started'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
