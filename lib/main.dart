
import 'package:flutter/material.dart';
import 'splash.dart'; // Splash Screen
import 'package:flutter_animate/flutter_animate.dart';
import 'authentication.dart';
import 'MapAddress.dart';
void main() {
  runApp(Forkknives());
}

class Forkknives extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), //Splash involved
    );
  }
}
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Animation Controller
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    )
      ..forward();

    // Fade-in animation for the logo
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    // Slide-up animation for text and button
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 1), // Starts from bottom
      end: Offset(0, 0), // Moves to normal position
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    // Scale animation for button
    _scaleAnimation = Tween<double>(
      begin: 0.8, // Slightly small
      end: 1.0, // Normal size
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut, // Adds a bouncing effect
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Fading Logo
            FadeTransition(
              opacity: _fadeAnimation,
              child: Image.asset(
                "images/img_2-removebg-preview.png",
                width: 300,
                height: 300,
              ),
            ),

            SizedBox(height: 20),

            // Sliding Text
            SlideTransition(
              position: _slideAnimation,
              child: Container(
                padding: EdgeInsets.all(23),
                width: 500,
                child: Text(
                  "Let's Order Now!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 44,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),

            // Scaling Button
            ScaleTransition(
              scale: _scaleAnimation,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>slider()));
                },
                child: Text(
                  "Get Started!",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  // Text color
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 16),
                  // Padding
                  side: BorderSide(color: Colors.red,
                      width: 2), // Outline border color set to red
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class slider extends StatefulWidget {
  const slider({super.key});
  State<slider> createState() => _slider();
}

class _slider extends State<slider> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    // Start fade-in after slight delay
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _opacity = 1.0;
      });
      _controller.forward();
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
      backgroundColor: Colors.orange,
      body: SafeArea(
        child: SingleChildScrollView(
          child: AnimatedOpacity(
            duration: Duration(seconds: 2),
            opacity: _opacity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Top Image with rounded bottom and shadow
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: Offset(0, 4),
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    child: Image.asset(
                      "images/img_4.png",
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SizedBox(height: 60),

                // Inspiring food quote
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    "“Food is not just fuel—it’s information that talks to your DNA and tells it what to do.”\n\n"
                        "People who love to eat are always the best people, because good food is the foundation of genuine happiness.\n\nCooking is an art.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                ),

                SizedBox(height: 40),

                // Next button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => slider2()),
                    );
                  },
                  child: Text("Next", style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                        horizontal: 100, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                  ),
                ),

                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.orange,
//       body: SingleChildScrollView(
//         child: Center(
//           child: AnimatedOpacity(
//             duration: Duration(seconds: 2),
//             opacity: _opacity,
//             child: Column(
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.3),
//                         blurRadius: 10,
//                         spreadRadius: 2,
//                         offset: Offset(0, 4),
//                       ),
//                     ],
//                     borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(34),
//                       bottomRight: Radius.circular(34),
//                     ),
//                   ),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(34),
//                       bottomRight: Radius.circular(34),
//                     ),
//                     child: Image.asset(
//                       "images/img_4.png",
//                       width: double.infinity,
//                       height: 350,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: 140,),
//                 Container(
//                   padding: EdgeInsets.all(16),
//                   child: Text(
//                     "Food is not just fuel it’s information that talks to your DNA\n"
//                         "and tells it what to do. People who love to eat are always\n"
//                         "the best people because good food is the foundation of\n"
//                         "genuine happiness. Cooking is an art.",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(context, MaterialPageRoute(builder: (context) => slider2()));
//                   },
//                   child: Text("Next", style: TextStyle(fontSize: 19)),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.red,
//                     foregroundColor: Colors.white,
//                     padding: EdgeInsets.symmetric(horizontal: 140, vertical: 14),
//                     side: BorderSide(color: Colors.red, width: 2),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


class slider2 extends StatefulWidget {
  const slider2({super.key});

  @override
  _slider2State createState() => _slider2State();
}

class _slider2State extends State<slider2> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _opacity = 1.0;
      });
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.orange,
//       body: SingleChildScrollView(
//         child: Center(
//           child: AnimatedOpacity(
//             duration: Duration(seconds: 2),
//             opacity: _opacity,
//             child: Column(
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.3),
//                         blurRadius: 10,
//                         spreadRadius: 2,
//                         offset: Offset(0, 4),
//                       ),
//                     ],
//                     borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(34),
//                       bottomRight: Radius.circular(34),
//                     ),
//                   ),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(34),
//                       bottomRight: Radius.circular(34),
//                     ),
//                     child: Image.asset(
//                       "images/img_5.png",
//                       width: 450,
//                       height: 350,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.all(16),
//                   child: Text(
//                     "Ramadan is the month of blessings,\n"
//                         "A time for reflection and prayer.\n"
//                         "Fasting fills the heart with gratitude,\n"
//                         "And iftar brings loved ones together.\n"
//                         "May your table be full of joy and peace,\n"
//                         "And your soul be nourished with faith.",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => slider3()),
//                     );
//                   },
//                   child: Text("Next", style: TextStyle(fontSize: 19)),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.red,
//                     foregroundColor: Colors.white,
//                     padding: EdgeInsets.symmetric(horizontal: 140, vertical: 14),
//                     side: BorderSide(color: Colors.red, width: 2),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: SafeArea(
        child: SingleChildScrollView(
          child: AnimatedOpacity(
            duration: Duration(seconds: 2),
            opacity: _opacity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Top Image with rounded bottom and shadow
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: Offset(0, 4),
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    child: Image.asset(
                      "images/img_5.png",
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SizedBox(height: 60),

                // Inspiring food quote
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    "“Food is not just fuel—it’s information that talks to your DNA and tells it what to do.”\n\n"
                        "People who love to eat are always the best people, because good food is the foundation of genuine happiness.\n\nCooking is an art.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                ),

                SizedBox(height: 40),

                // Next button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => slider3()),
                    );
                  },
                  child: Text("Next", style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                        horizontal: 100, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                  ),
                ),

                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


  class slider3 extends StatefulWidget {
  const slider3({super.key});

  @override
  _slider3State createState() => _slider3State();
}

class _slider3State extends State<slider3> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _opacity = 1.0;
      });
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.orange,
//       body: SingleChildScrollView(
//         child: Center(
//         child: AnimatedOpacity(
//         duration: Duration(seconds: 2),
//     opacity: _opacity,
//           child: Column(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.3),
//                       blurRadius: 10,
//                       spreadRadius: 2,
//                       offset: Offset(0, 4),
//                     ),
//                   ],
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(34),
//                     bottomRight: Radius.circular(34),
//                   ),
//                 ),
//
//                 child:
//                 ClipRRect(
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(34),
//                     bottomRight: Radius.circular(34),
//                   ),
//                   child: Image.asset(
//                     "images/img_6.png",
//                     width: 450,
//                     height: 350,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//
//               Container(
//                 padding: EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   //color: Colors.black.withOpacity(0.6),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Text(
//                   " Pizza is not just food its a feeling A slice of happiness in every bite Cheesy dreams and \n crispy delights Bringing friends and family together Life’s too short \n for bad pizza So grab a slice \n and enjoy the moment! \n enjoy the dishes!",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => slider4()),
//                   );
//                 },
//                 child: Text(
//                   "Next",
//                   style: TextStyle(fontSize: 19),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.red,
//                   foregroundColor: Colors.white,
//                   padding: EdgeInsets.symmetric(horizontal: 140, vertical: 14),
//                   side: BorderSide(color: Colors.red, width: 2),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         ),
//       ),
//     );
//   }
// }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: SafeArea(
        child: SingleChildScrollView(
          child: AnimatedOpacity(
            duration: Duration(seconds: 2),
            opacity: _opacity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Top Image with rounded bottom and shadow
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: Offset(0, 4),
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    child: Image.asset(
                      "images/img_6.png",
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SizedBox(height: 60),

                // Inspiring food quote
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    "“Food is not just fuel—it’s information that talks to your DNA and tells it what to do.”\n\n"
                        "People who love to eat are always the best people, because good food is the foundation of genuine happiness.\n\nCooking is an art.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                ),

                SizedBox(height: 40),

                // Next button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => slider4()),
                    );
                  },
                  child: Text("Next", style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                        horizontal: 100, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                  ),
                ),

                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
  class slider4 extends StatefulWidget {
  const slider4({super.key});

  @override
  _slider4State createState() => _slider4State();
}

class _slider4State extends State<slider4> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _opacity = 1.0;
      });
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
//
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: SafeArea(
        child: SingleChildScrollView(
          child: AnimatedOpacity(
            duration: Duration(seconds: 2),
            opacity: _opacity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Top Image with rounded bottom and shadow
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: Offset(0, 4),
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    child: Image.asset(
                      "images/img_7.png",
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SizedBox(height: 60),

                // Inspiring food quote
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    "“Food is not just fuel—it’s information that talks to your DNA and tells it what to do.”\n\n"
                        "People who love to eat are always the best people, because good food is the foundation of genuine happiness.\n\nCooking is an art.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                ),

                SizedBox(height: 40),

                // Next button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Slider5()),
                    );
                  },
                  child: Text("Next", style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                        horizontal: 100, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                  ),
                ),

                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

  class Slider5 extends StatefulWidget {
  const Slider5({super.key});

  @override
  _Slider5State createState() => _Slider5State();
}

class _Slider5State extends State<Slider5> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _opacity = 1.0;
      });
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.orange,
//       body: SingleChildScrollView(
//         child: Center(
//         child: AnimatedOpacity(
//         duration: Duration(seconds: 2),
//     opacity: _opacity,
//           child: Column(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//           boxShadow: [
//               BoxShadow(
//               color: Colors.black.withOpacity(0.3),
//           blurRadius: 10,
//           spreadRadius: 2,
//           offset: Offset(0, 4),
//         ),
//           ],
//       borderRadius: BorderRadius.only(
//       bottomLeft: Radius.circular(34),
//       bottomRight: Radius.circular(34),
//     ),
//     ),
//
//           child:
//               ClipRRect(
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(34),
//                   bottomRight: Radius.circular(34),
//                 ),
//                 child: Image.asset(
//                   "images/img_8.png",
//                   width: 450,
//                   height: 350,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               ),
//
//               Container(
//                 padding: EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   //color: Colors.black.withOpacity(0.6),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Text(
//                   "  Whether it’s a home-cooked dish or a feast with friends,\n  every bite tells a story of love \n Good food is the foundation of genuine happiness emphasizing that the \n flavors we savor bring warmth to our hearts.",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//
//
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => GoogleMapEmbedPage()),
//                   );
//                 },
//                 child: Text(
//                   "Next",
//                   style: TextStyle(fontSize: 19),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.red,
//                   foregroundColor: Colors.white,
//                   padding: EdgeInsets.symmetric(horizontal: 140, vertical: 14),
//                   side: BorderSide(color: Colors.red, width: 2),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       ),
//     );
//   }
// }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: SafeArea(
        child: SingleChildScrollView(
          child: AnimatedOpacity(
            duration: Duration(seconds: 2),
            opacity: _opacity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Top Image with rounded bottom and shadow
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: Offset(0, 4),
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    child: Image.asset(
                      "images/img_8.png",
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SizedBox(height: 60),

                // Inspiring food quote
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    "“Food is not just fuel—it’s information that talks to your DNA and tells it what to do.”\n\n"
                        "People who love to eat are always the best people, because good food is the foundation of genuine happiness.\n\nCooking is an art.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                ),

                SizedBox(height: 40),

                // Next button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Register()),
                    );
                  },
                  child: Text("Next", style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                        horizontal: 100, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                  ),
                ),

                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// /*-----------------google Map to find user address for DELIVERY---------------*/

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.orange,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                // Animated Logo
                Animate(
                  effects: [FadeEffect(duration: 900.ms), SlideEffect(curve: Curves.easeOut, begin: Offset(0, -0.3))],
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/img_2-removebg-preview.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // Animated Button Row
                Animate(
                  effects: [FadeEffect(duration: 1200.ms), SlideEffect(curve: Curves.easeOut, begin: Offset(0, 0.2))],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Login Button with Navigation
                      _buildAnimatedButton(context, "Login", Colors.yellow, Colors.red, Login()),

                      SizedBox(width: 23),

                      // Register Button without Navigation
                      _buildAnimatedButton(context, "Sign Up", Colors.yellow, Colors.red, Signup()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ✅ Corrected Button Function
  Widget _buildAnimatedButton(BuildContext context, String text, Color bgColor, Color textColor, Widget? screen) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 300),
      tween: Tween(begin: 1.0, end: 1.0),
      builder: (context, scale, child) {
        return GestureDetector(
          onTapDown: (_) => scale = 0.95, // Shrink button on tap
          onTapUp: (_) => scale = 1.0, // Restore size on release
          child: Transform.scale(
            scale: scale,
            child: ElevatedButton(
              onPressed: () {
                if (screen != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => screen),
                  );
                }
              },
              child: Text(text),
              style: ElevatedButton.styleFrom(
                backgroundColor: bgColor,
                foregroundColor: textColor,
                padding: EdgeInsets.symmetric(horizontal: 45, vertical: 12),
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
                elevation: 5,
              ),
            ),
          ),
        );
      },
    );
  }
}


// //sign up form to register
//
//
// class Signup extends StatefulWidget {
//   @override
//   _SignupState createState() => _SignupState();
// }
//
// class _SignupState extends State<Signup> {
//   bool _isPasswordHidden = true;
//   bool _isConfirmPasswordHidden = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: SingleChildScrollView( // Prevent overflow issues
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Logo Image
//               Image.asset(
//                 "images/img_2-removebg-preview.png",
//                 width: 200,
//                 height: 200,
//               ),
//
//               SizedBox(height: 20),
//
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 30),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Email Field
//
//                     TextField(
//                       decoration: InputDecoration(
//                         labelText: "Email",
//                         border: OutlineInputBorder(),
//                         suffixIcon: Icon(Icons.email, color: Colors.red),
//                       ),
//                       keyboardType: TextInputType.emailAddress,
//                     ),
//                     SizedBox(height: 15),
//                     TextField(
//                       decoration: InputDecoration(
//                         labelText: "Username",
//                         border: OutlineInputBorder(),
//                         suffixIcon: Icon(Icons.person, color: Colors.red),
//                       ),
//                       keyboardType: TextInputType.text,
//                     ),
//                     SizedBox(height: 15),
//                     TextField(
//                       decoration: InputDecoration(
//                         labelText: "Phone number",
//                         border: OutlineInputBorder(),
//                         suffixIcon: Icon(Icons.phone, color: Colors.red),
//                       ),
//                       keyboardType: TextInputType.number,
//                     ),
//
//                     SizedBox(height: 15),
//                     // Password Field with Visibility Toggle
//
//                     TextField(
//                       obscureText: _isPasswordHidden,
//                       decoration: InputDecoration(
//                         labelText: "Password",
//                         border: OutlineInputBorder(),
//                         suffixIcon: IconButton(
//                           icon: Icon(
//                             _isPasswordHidden ? Icons.visibility_off : Icons.visibility,
//                             color: Colors.red,
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               _isPasswordHidden = !_isPasswordHidden;
//                             });
//                           },
//                         ),
//                       ),
//                     ),
//
//
//                     SizedBox(height: 15),
//
//                     // Confirm Password Field with Visibility Toggle
//
//
//                     TextField(
//                       obscureText: _isConfirmPasswordHidden,
//                       decoration: InputDecoration(
//                         labelText: "Confirm Password",
//                         border: OutlineInputBorder(),
//                         suffixIcon: IconButton(
//                           icon: Icon(
//                             _isConfirmPasswordHidden ? Icons.visibility_off : Icons.visibility,
//                             color: Colors.red,
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               _isConfirmPasswordHidden = !_isConfirmPasswordHidden;
//                             });
//                           },
//                         ),
//                       ),
//                     ),
//
//                     SizedBox(height: 20),
//
//                     // Signup Button
//                     SizedBox(
//                       width: double.infinity, // Full Width Button
//                       child: ElevatedButton(
//                         onPressed: () {},
//                         child: Text("Signup", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.red,
//                           foregroundColor: Colors.white,
//                           padding: EdgeInsets.symmetric(vertical: 14),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// //login screen to register
// class Login extends StatefulWidget {
//   @override
//   _LoginState createState() => _LoginState();
// }
//
// class _LoginState extends State<Login> {
//   bool _isPasswordHidden = true;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: SingleChildScrollView( // Prevent overflow issues
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Logo Image
//               Image.asset(
//                 "images/img_2-removebg-preview.png",
//                 width: 200,
//                 height: 200,
//               ),
//
//               SizedBox(height: 20),
//
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 30),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Email Field
//                     Text("Enter your Email", style: TextStyle(
//                       color: Colors.red,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     )),
//                     SizedBox(height: 5),
//                     TextField(
//                       decoration: InputDecoration(
//                         labelText: "Email",
//                         border: OutlineInputBorder(),
//                         suffixIcon: Icon(Icons.email, color: Colors.red),
//                       ),
//                       keyboardType: TextInputType.emailAddress,
//                     ),
//
//                     SizedBox(height: 15),
//
//                     // Password Field with Visibility Toggle
//                     Text("Enter your Password", style: TextStyle(
//                       color: Colors.red,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     )),
//                     SizedBox(height: 5),
//                     TextField(
//                       obscureText: _isPasswordHidden,
//                       decoration: InputDecoration(
//                         labelText: "Password",
//                         border: OutlineInputBorder(),
//                         suffixIcon: IconButton(
//                           icon: Icon(
//                             _isPasswordHidden ? Icons.visibility_off : Icons.visibility,
//                             color: Colors.red,
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               _isPasswordHidden = !_isPasswordHidden;
//                             });
//                           },
//                         ),
//                       ),
//                     ),
//
//                     SizedBox(height: 15),
//
//
//                     // Signup Button
//                     SizedBox(
//                       width: double.infinity, // Full Width Button
//                       child: ElevatedButton(
//                         onPressed: () {},
//                         child: Text("Login", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.red,
//                           foregroundColor: Colors.white,
//                           padding: EdgeInsets.symmetric(vertical: 14),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
