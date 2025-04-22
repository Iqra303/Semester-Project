import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';  // Firebase Core
import 'package:rms/main.dart';
import 'firebase_options.dart';  // Import the generated Firebase config

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with the generated config
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,  // This connects the app to Firebase
  );
//START YOUR PROJECT FROM HERE FORK N KNIVES RESTAURANT
  runApp(Forkknives());
}
