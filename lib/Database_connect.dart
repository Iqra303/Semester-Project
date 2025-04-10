import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'menu.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyCjlKdGkncXHlkcvI75myKJC2IzQusSBvw",
          authDomain: "forknknives-2a317.firebaseapp.com",
          projectId: "forknknives-2a317",
          storageBucket: "forknknives-2a317.appspot.com",
          messagingSenderId: "455650914855",
          appId: "1:455650914855:web:4dfbd994e26dd0a4771402", measurementId: "G-C20P0EBKE2"
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(Menus());
}