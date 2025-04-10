
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rms/menu.dart';


class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Signup(),
    );
  }
}

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
        appId: "1:455650914855:web:4dfbd994e26dd0a4771402",
        measurementId: "G-C20P0EBKE2",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp2());
}

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  TextEditingController _email = TextEditingController();
  TextEditingController _username = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();

  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;
  bool _isLoading = false;

  void _registerUser() async {
    setState(() {
      _isLoading = true;
    });

    if (_formKey.currentState!.validate()) {
      try {
        final userCredential = await _auth.createUserWithEmailAndPassword(
          email: _email.text.trim(),
          password: _password.text.trim(),
        );

        await _firestore.collection("users").doc(userCredential.user!.uid).set({
          "email": _email.text.trim(),
          "username": _username.text.trim(),
          "phone": _phone.text.trim(),
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Account created successfully!"),
          backgroundColor: Colors.green,
        ));
        await Future.delayed(Duration(seconds: 2));

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Menus()));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Errors: $e"),
          backgroundColor: Colors.green,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[100],
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  Image.asset("images/img_2-removebg-preview.png", width: 200),
                  SizedBox(height: 20),

                  TextFormField(
                    controller: _email,
                    decoration: InputDecoration(labelText: "Email", border: OutlineInputBorder(), suffixIcon: Icon(Icons.email, color: Colors.red)),
                    validator: (value) => value!.isEmpty || !value.contains('@') ? 'Enter a valid email' : null,
                  ),
                  SizedBox(height: 10),

                  TextFormField(
                    controller: _username,
                    decoration: InputDecoration(labelText: "Username", border: OutlineInputBorder(), suffixIcon: Icon(Icons.person, color: Colors.red)),
                    validator: (value) => value!.isEmpty ? 'Enter a username' : null,
                  ),
                  SizedBox(height: 10),

                  TextFormField(
                    controller: _phone,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: "Phone", border: OutlineInputBorder(), suffixIcon: Icon(Icons.phone, color: Colors.red)),
                    validator: (value) => value!.isEmpty || value.length < 10 ? 'Enter valid phone' : null,
                  ),
                  SizedBox(height: 10),

                  TextFormField(
                    controller: _password,
                    obscureText: _isPasswordHidden,
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(_isPasswordHidden ? Icons.visibility_off : Icons.visibility, color: Colors.red),
                        onPressed: () => setState(() => _isPasswordHidden = !_isPasswordHidden),
                      ),
                    ),
                    validator: (value) => value!.length < 6 ? 'Password too short' : null,
                  ),
                  SizedBox(height: 10),

                  TextFormField(
                    controller: _confirmPassword,
                    obscureText: _isConfirmPasswordHidden,
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(_isConfirmPasswordHidden ? Icons.visibility_off : Icons.visibility, color: Colors.red),
                        onPressed: () => setState(() => _isConfirmPasswordHidden = !_isConfirmPasswordHidden),
                      ),
                    ),
                    validator: (value) => value != _password.text ? 'Passwords do not match' : null,
                  ),

                  SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: _registerUser,
                    child: Text("Sign up"),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
                  ),
                  SizedBox(height: 15),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Already have an account?",style: TextStyle(fontSize: 16)),
                        TextButton(onPressed: (){
                          Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>Login()));
                        }, child: Text("Login",style: TextStyle(color: Colors.red),))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool _isPasswordHidden = true;
  bool _isLoading = false;

  void _loginUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        await _auth.signInWithEmailAndPassword(
          email: _email.text.trim(),
          password: _password.text.trim(),
        );
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Login successful!"),
          backgroundColor: Colors.green,
        )
        );
        await Future.delayed(Duration(seconds: 2));

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Menus()));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Login failed: $e"),
          backgroundColor: Colors.red,
        ));
      }
    finally {
    setState(() {
    _isLoading = false;
    });
    }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[100],
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  Image.asset("images/img_2-removebg-preview.png", width: 200),
                  SizedBox(height: 20),

                  TextFormField(
                    controller: _email,
                    decoration: InputDecoration(labelText: "Email", border: OutlineInputBorder(), suffixIcon: Icon(Icons.email, color: Colors.red)),
                    validator: (value) => value!.isEmpty || !value.contains('@') ? 'Enter a valid email' : null,
                  ),
                  SizedBox(height: 10),

                  TextFormField(
                    controller: _password,
                    obscureText: _isPasswordHidden,
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(_isPasswordHidden ? Icons.visibility_off : Icons.visibility, color: Colors.red),
                        onPressed: () => setState(() => _isPasswordHidden = !_isPasswordHidden),
                      ),
                    ),
                    validator: (value) => value!.length < 6 ? 'Password too short' : null,
                  ),
                  SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: _loginUser,
                    child: Text("Login"),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
                  ),
                  SizedBox(height: 15),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Don't have an account?",style: TextStyle(fontSize: 16)),
                        TextButton(onPressed: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context)=>Signup()));
                        }, child: Text("Sign up",style: TextStyle(color: Colors.red),))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
