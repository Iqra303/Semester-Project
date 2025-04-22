import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rms/main.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';
import 'authentication.dart';
import 'firebase_options.dart';
import 'menu.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with the generated config
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,  // This connects the app to Firebase
  );

  if (kIsWeb) {
    WebViewPlatform.instance = WebWebViewPlatform();
  }

  runApp(MaterialApp(debugShowCheckedModeBanner:false ,home: GoogleMapEmbedPage()));
}

class GoogleMapEmbedPage extends StatefulWidget {
  @override
  State<GoogleMapEmbedPage> createState() => _GoogleMapEmbedPageState();
}

class _GoogleMapEmbedPageState extends State<GoogleMapEmbedPage> {
  late final WebViewController _controller;
  final TextEditingController _searchController = TextEditingController();


  //Add Address in a firebase
  // Future<void> addAddress() async {
  //   final address = _searchController.text.trim();
  //
  //   if (address.isNotEmpty) {
  //     await FirebaseFirestore.instance.collection('addresses').add({
  //       'address': address,
  //     });
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Address added successfully!')),
  //     );
  //
  //     _searchController.clear();
  //   }
  // }
  // Future<void> addAddress() async {
  //   final address = _searchController.text.trim();
  //   final currentUser = FirebaseAuth.instance.currentUser;
  //
  //   if (currentUser == null && address.isNotEmpty) {
  //     await FirebaseFirestore.instance
  //         .collection('addresses')
  //         .doc(currentUser?.uid)
  //         .set({
  //       'address': address,
  //     });
  //
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Address added successfully!')),
  //     );
  //
  //     _searchController.clear();
  //   }
  // }
  Future<void> addAddress() async {
    final address = _searchController.text.trim();
    final user = FirebaseAuth.instance.currentUser;

    if (address.isNotEmpty && user != null) {
      await FirebaseFirestore.instance.collection('addresses').doc(user.uid).set({
        'uid': user.uid,
        'address': address,
      });


      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Address added successfully!')),
      );

      _searchController.clear();

    }
  }



  String generateMapHTML(String location) {
    final locationEncoded = Uri.encodeComponent(location);
    return '''
      <!DOCTYPE html>
      <html>
        <head>
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <style>
            body, html {
              margin: 0;
              padding: 0;
              height: 100%;
            }
            iframe {
              width: 100%;
              height: 100%;
              border: 0;
            }
          </style>
        </head>
        <body>
          <iframe
            src="https://www.google.com/maps?q=$locationEncoded&output=embed"
            allowfullscreen=""
            loading="lazy"
            referrerpolicy="no-referrer-when-downgrade">
          </iframe>
        </body>
      </html>
    ''';
  }

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..loadHtmlString(generateMapHTML('Lahore, Pakistan'));
  }

  void _searchLocation() {
    final location = _searchController.text.trim();
    if (location.isNotEmpty) {
      _controller.loadHtmlString(generateMapHTML(location));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    home: Scaffold(
      // appBar: AppBar(
      //   title: Text('Google Map Search'),
      //   backgroundColor: Colors.red,
      // ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(child: WebViewWidget(controller: _controller)),
              Container(
                width: double.infinity, // or a specific width like 1400
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Text("Add Your Location", style: TextStyle(fontSize: 24, color: Colors.white)),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        style: TextStyle(color: Colors.red),
                        controller: _searchController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Search for a location....',
                          suffixIcon: IconButton(
                            icon: Icon(Icons.search,size: 28, color: Colors.red),
                            onPressed: () {
                              _searchLocation();
                            },
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: addAddress,
                      child: Icon(Icons.add,color: Colors.red,size: 34,weight: 5,),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    )
                    ),
                    SizedBox(height: 23,),
                    ElevatedButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Menu()));
                        },
                        child: Text('Continue to Order', style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 80, vertical: 20),
                        )
                    ),

                  ],
                ),
              ),
            ],
          ),
        ],
      ),

    )
    );
  }
}

