
import 'package:flutter/material.dart';
import 'dart:async';
import 'main.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Animation Controller
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..forward();

    // Fade animation for logo
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    // Slide animation for "Powered By" and second image
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 1), // Starts from bottom
      end: Offset(0, 0), // Moves to normal position
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    // Timer to navigate to the main screen
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MainScreen()), // Navigate to Main Screen
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange, // Background color
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Fading Logo
              FadeTransition(
                opacity: _fadeAnimation,
                child: Container(

                  child: Image.asset(
                    "images/img_2-removebg-preview.png",
                    width: 300,
                    height: 300,
                  ),
                ),
              ),

              SizedBox(height: 195),

              // Sliding "Powered By" Text
              SlideTransition(
                position: _slideAnimation,
                child: Text(
                  "Powered By",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),

              // Sliding Secondary Image
              SlideTransition(
                position: _slideAnimation,
                child: Image.asset(
                  "images/img_3.png",
                  width: 100,
                  height: 100,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
