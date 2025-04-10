/*-----------------------------MENU LIST TO ORDER-----------------------------*/
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_sparkle/flutter_sparkle.dart';
import 'dart:math';// Add this import
import 'package:flutter/scheduler.dart';
/*------------Database-----------*/
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
  runApp(Menus());
}

class Menus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Menu(),
    );
  }
}


class Menu extends StatefulWidget {

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> _images = [
    'images/img_9.png',
    'images/img_10.png',
    'images/img_11.png',
    'images/img_12.png',
    'images/img_13.png',
    'images/img_14.png'
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Future.doWhile(() async {
        await Future.delayed(Duration(seconds: 3));
        if (!mounted) return false;
        int nextPage = (_currentPage + 1) % _images.length;
        _pageController.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 700),
          curve: Curves.easeInOut,
        );
        setState(() {
          _currentPage = nextPage;
        });
        return true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.orange,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(onPressed: (){}, child: Icon(Icons.menu,size: 26,color: Colors.white,)),
                      Text("Menu List",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold)),
                      TextButton(onPressed: (){}, child: Icon(Icons.search,size: 26,color: Colors.white,)),
                    ],
                  ),
                ),
              ),
            ),

            // Image slider
            Container(
              height: 300,
              width: double.infinity,
              child: PageView.builder(
                controller: _pageController,
                itemCount: _images.length,
                itemBuilder: (context, index) {
                  return AnimatedOpacity(
                    opacity: _currentPage == index ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 600),
                    child: Image.asset(
                      _images[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  );
                },
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
              ),
            ),

            // Buttons
            Container(
                padding: EdgeInsets.all(13),
                child:SingleChildScrollView(
                    scrollDirection: Axis.horizontal,

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        OutlinedButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Deals()));
                        }, child: Text("Deals",style: TextStyle(color: Colors.white),),style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.white, width: 2),
                            backgroundColor: Colors.orange
                        ),),
                        SizedBox(width: 16,),
                        OutlinedButton(onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context)=>Pizza())
                          );
                        }, child: Text("Pizza",style: TextStyle(color: Colors.white)),style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.white, width: 2),
                            backgroundColor: Colors.orange
                        ),),
                        SizedBox(width: 16,),
                        OutlinedButton(onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Burger()),
                          );
                        }, child: Text("Burgers",style: TextStyle(color: Colors.white)),style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.white, width: 2),
                            backgroundColor: Colors.orange
                        ),),
                        SizedBox(width: 16,),
                        OutlinedButton(onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Fries()),
                          );
                        }, child: Text("Fries",style: TextStyle(color: Colors.white)),style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.white, width: 2),
                            backgroundColor: Colors.orange
                        ),),
                        SizedBox(width: 16,),
                        OutlinedButton(onPressed: (){
                          Navigator.push(
                            context,MaterialPageRoute(builder: (context)=>Wings()),
                          );
                        }, child: Text("Wings",style: TextStyle(color: Colors.white)),style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.white, width: 2),
                            backgroundColor: Colors.orange
                        ),),
                        SizedBox(width: 16,),
                        OutlinedButton(onPressed: (){
                          Navigator.push(
                            context,MaterialPageRoute(builder: (context)=>Sweats()),
                          );
                        }, child: Text("Sweets",style: TextStyle(color: Colors.white)),style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.white, width: 2),
                            backgroundColor: Colors.orange
                        ),),
                      ],
                    )
                )
            ),



          ],
        ),
      ),
    );
  }
}
List<Map<String, dynamic>> cart = [];
class Deals extends StatefulWidget{
  @override
  _Dealstate createState()=>_Dealstate();
}
class _Dealstate extends State<Deals> {
  //List<Map<String, dynamic>> cart = [];

  void addToCart(Map<String, dynamic> item) {


    setState(() {
      cart.add({
        ...item,
        'quantity': 1,
      });
    });

    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text('Added to Cart'),
            content: Text('Would you like to order more?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Yes'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewCart(cart: cart),
                    ),
                  );
                },
                child: Text('View Cart'),
              )
            ],
          ),
    );
  }
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Deals List",style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.red,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('menu').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text("Error loading data: ${snapshot.error}"));
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(child: Text("No menu items found"));
                    }

                    return Column(
                      children: snapshot.data!.docs.map((doc) {
                        Map<String, dynamic> data = {};
                        try {
                          data = doc.data() as Map<String, dynamic>;
                        } catch (e) {
                          print("Error parsing Firestore document: $e");
                          return SizedBox.shrink(); // or return an empty container
                        }

                        final List items = data['items'];

                        return Container(
                          margin: EdgeInsets.all(23),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(19),
                            color: Colors.orange[100],
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              )
                            ],
                          ),
                          padding: EdgeInsets.all(18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data['name'],
                                      style: TextStyle(
                                          color: Colors.red[500],
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold)),
                                  for (var item in items)
                                    Text(item,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            color: Colors.red)),
                                  SizedBox(height: 13),
                                  Text("Price: PKR ${data['price']}/-",
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 13),
                                  ElevatedButton(
                                    onPressed: () =>addToCart(data),
                                    child: Text("Add to cart",
                                        style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.orange,
                                      foregroundColor: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.asset(
                                  "images/${data['image']}",
                                  width: 100,
                                  height: 100,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),

              ),
              Container(
                child: ElevatedButton(onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Menu()),
                  );
                }, child: Text("Go Back"),style:
                ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                ),),
              )
            ],
          ),
        ),
      ),
    );
  }
}


class Burger extends StatefulWidget {
  @override
  _Burgerstate createState() => _Burgerstate();
}

class _Burgerstate extends State<Burger> {
  // List<Map<String, dynamic>> cart = [];

  void addToCart(Map<String, dynamic> item) {

    setState(() {
      cart.add({
        ...item,
        'quantity': 1,
      });
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Added to Cart'),
        content: Text('Would you like to order more?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewCart(cart:cart),
                ),
              );
            },
            child: Text('View Cart'),
          )
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[800],
          title: Text("Burger's List",style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('burger').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(child: Text("No menu items found"));
                    }

                    return Column(
                      children: snapshot.data!.docs.map((doc) {
                        final data = doc.data() as Map<String, dynamic>;


                        return Container(
                          margin: EdgeInsets.all(23),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(19),
                            color: Colors.orange[100],
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              )
                            ],
                          ),
                          padding: EdgeInsets.all(18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data['name'],
                                      style: TextStyle(
                                          color: Colors.red[500],
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 13),
                                  Text("Price: PKR ${data['price']}/-",
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 13),
                                  ElevatedButton(
                                    onPressed: () =>addToCart(data),
                                    child: Text("Add to cart",
                                        style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.orange,
                                      foregroundColor: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.asset(
                                  "images/${data['image']}",
                                  width: 100,
                                  height: 100,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
             Container(
               child: ElevatedButton(onPressed: (){
                 Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => Menu()),
                 );
               }, child: Text("Go Back"),style:
                 ElevatedButton.styleFrom(
                   backgroundColor: Colors.deepOrange,
                   foregroundColor: Colors.white,
                 ),),
             )
            ],

          ),
        ),
      )
    );
  }
}

//Fries List
class Fries extends StatefulWidget {
@override
_FriesState createState() => _FriesState();
}

class _FriesState extends State<Fries> {
  //List<Map<String, dynamic>> cart = [];

  void addToCart(Map<String, dynamic> item) {
    setState(() {
      cart.add({
        ...item,
        'quantity': 1,
      });
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Added to Cart'),
        content: Text('Would you like to order more?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewCart(cart:cart),
                ),
              );
            },
            child: Text('View Cart'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[800],
          title: Text("Fries List", style: TextStyle(color: Colors.white)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream:
                FirebaseFirestore.instance.collection('fries').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text("No menu items found"));
                  }

                  return Column(
                    children: snapshot.data!.docs.map((doc) {
                      final data = doc.data() as Map<String, dynamic>;

                      return Container(
                        margin: EdgeInsets.all(23),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(19),
                          color: Colors.orange[100],
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            )
                          ],
                        ),
                        padding: EdgeInsets.all(18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data['name'],
                                    style: TextStyle(
                                        color: Colors.red[500],
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 13),
                                Text("Price: PKR ${data['price']}/-",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 13),
                                ElevatedButton(
                                  onPressed: () => addToCart(data),
                                  child: Text("Add to cart",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange,
                                    foregroundColor: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                "images/${data['image']}",
                                width: 100,
                                height: 100,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Menu()),
                  );
                },
                child: Text("Go Back"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Wings extends StatefulWidget {
  @override
  _Wingstate createState() => _Wingstate();
}

class _Wingstate extends State<Wings> {

  //List<Map<String, dynamic>> cart = [];

  void addToCart(Map<String, dynamic> item) {
    setState(() {
      cart.add({
        ...item,
        'quantity': 1,
      });
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Added to Cart'),
        content: Text('Would you like to order more?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewCart(cart:cart),
                ),
              );
            },
            child: Text('View Cart'),
          )
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context){
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home:Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red[800],
            title: Text("Wing's List",style: TextStyle(color: Colors.white),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('wings').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(child: Text("No menu items found"));
                      }

                      return Column(
                        children: snapshot.data!.docs.map((doc) {
                          final data = doc.data() as Map<String, dynamic>;


                          return Container(
                            margin: EdgeInsets.all(23),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(19),
                              color: Colors.orange[100],
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                )
                              ],
                            ),
                            padding: EdgeInsets.all(18),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(data['name'],
                                        style: TextStyle(
                                            color: Colors.red[500],
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: 13),
                                    Text("Price: PKR ${data['price']}/-",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: 13),
                                    ElevatedButton(
                                      onPressed: () => addToCart(data),
                                      child: Text("Add to cart",
                                          style:
                                          TextStyle(fontWeight: FontWeight.bold)),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.orange,
                                        foregroundColor: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.asset(
                                    "images/${data['image']}",
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
                Container(
                  child: ElevatedButton(onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Menu()),
                    );
                  }, child: Text("Go Back"),style:
                  ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    foregroundColor: Colors.white,
                  ),),
                )
              ],

            ),
          ),
        )
    );
  }
}

class Sweats extends StatefulWidget {
  @override
  _Sweatstate createState() => _Sweatstate();
}

class _Sweatstate extends State<Sweats> {
  //List<Map<String, dynamic>> cart = [];

  void addToCart(Map<String, dynamic> item) {

    setState(() {
      cart.add({
        ...item,
        'quantity': 1,
      });
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Added to Cart'),
        content: Text('Would you like to order more?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewCart(cart:cart),
                ),
              );
            },
            child: Text('View Cart'),
          )
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context){
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home:Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red[800],
            title: Text("Sweats List",style: TextStyle(color: Colors.white),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('sweats').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(child: Text("No menu items found"));
                      }

                      return Column(
                        children: snapshot.data!.docs.map((doc) {
                          final data = doc.data() as Map<String, dynamic>;


                          return Container(
                            margin: EdgeInsets.all(23),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(19),
                              color: Colors.orange[100],
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                )
                              ],
                            ),
                            padding: EdgeInsets.all(18),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(data['name'],
                                        style: TextStyle(
                                            color: Colors.red[500],
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: 13),
                                    Text("Price: PKR ${data['price']}/-",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: 13),
                                    ElevatedButton(
                                      onPressed: () =>addToCart(data),
                                      child: Text("Add to cart",
                                          style:
                                          TextStyle(fontWeight: FontWeight.bold)),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.orange,
                                        foregroundColor: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.asset(
                                    "images/${data['image']}",
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
                Container(
                  child: ElevatedButton(onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Menu()),
                    );
                  }, child: Text("Go Back"),style:
                  ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    foregroundColor: Colors.white,
                  ),),
                )
              ],

            ),
          ),
        )
    );
  }
}








class Pizza extends StatefulWidget {
  @override
  _PizzaState createState() => _PizzaState();
}

class _PizzaState extends State<Pizza> {
 // List<Map<String, dynamic>> cart = [];

  void addToCart(Map<String, dynamic> item) {

    setState(() {
      cart.add({...item, 'quantity': 1});
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Added to Cart'),
        content: Text('Would you like to order more?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewCart(cart:cart),
                ),
              );
            },
            child: Text('View Cart'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[800],
          title: Text("Pizza's List", style: TextStyle(color: Colors.white)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('pizza').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text("No pizza items found"));
                  }

                  return Column(
                    children: snapshot.data!.docs.map((doc) {
                      final data = doc.data() as Map<String, dynamic>;

                      // Safe price parsing
                      dynamic rawPrice = data['price'];
                      Map<String, dynamic> priceMap = {};

                      if (rawPrice is List && rawPrice.length >= 3) {
                        priceMap = {
                          'Small': rawPrice[0],
                          'Medium': rawPrice[1],
                          'Large': rawPrice[2],
                        };
                      } else if (rawPrice is Map) {
                        priceMap = {
                          'Small': rawPrice['Small'] ?? 0,
                          'Medium': rawPrice['Medium'] ?? 0,
                          'Large': rawPrice['Large'] ?? 0,
                        };
                      } else {
                        priceMap = {
                          'Small': 0,
                          'Medium': 0,
                          'Large': 0,
                        };
                      }

                      return Container(
                        margin: EdgeInsets.all(23),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(19),
                          color: Colors.orange[100],
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            )
                          ],
                        ),
                        padding: EdgeInsets.all(18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data['name'],
                                    style: TextStyle(
                                        color: Colors.red[500],
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 10),
                                Text("Prices:",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold)),
                                Text("Small: PKR ${priceMap['Small']}"),
                                Text("Medium: PKR ${priceMap['Medium']}"),
                                Text("Large: PKR ${priceMap['Large']}"),
                                SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    // Ask size before adding to cart
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text('Choose Size'),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: ['Small', 'Medium', 'Large']
                                              .map((sizeOption) {
                                            return ListTile(
                                              title: Text(
                                                  "$sizeOption - PKR ${priceMap[sizeOption]}"),
                                              onTap: () {
                                                Navigator.pop(context);
                                                addToCart({
                                                  'name': data['name'] + " ($sizeOption)",
                                                  'price': priceMap[sizeOption],
                                                  'image': data['image'],
                                                });
                                              },
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text("Add to cart",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange,
                                    foregroundColor: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                "images/${data['image']}",
                                width: 100,
                                height: 100,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(Icons.local_pizza, size: 100);
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Go Back"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
/*--------------------------------VIEWCART SCEEN--------------------------------*/
class ViewCart extends StatefulWidget {
  final List<Map<String, dynamic>> cart;

  ViewCart({required this.cart});

  @override
  _ViewCartState createState() => _ViewCartState();
}

class _ViewCartState extends State<ViewCart> {
  late List<Map<String, dynamic>> cart;

  @override
  void initState() {
    super.initState();
    cart = widget.cart;
  }

  void updateQuantity(int index, int change) {
    setState(() {
      cart[index]['quantity'] += change;
      if (cart[index]['quantity'] < 1) {
        cart[index]['quantity'] = 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double total = cart.fold(0, (sum, item) => sum + (item['price'] * item['quantity']));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[800],
        title: Text('Your Cart', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            ...cart.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> item = entry.value;

              return ListTile(
                title: Text(item['name']),
                subtitle: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove, color: Colors.red),
                      onPressed: () => updateQuantity(index, -1),
                    ),
                    Text("${item['quantity']}"),
                    IconButton(
                      icon: Icon(Icons.add, color: Colors.green),
                      onPressed: () => updateQuantity(index, 1),
                    ),
                  ],
                ),
                trailing: Text("PKR ${item['price'] * item['quantity']}"),
              );
            }),
            Divider(),
            Text(
              "Total: PKR $total",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16,),
            ElevatedButton(onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=>PlaceOrder( cart: cart)));
            }, child: Text("Place Order",style: TextStyle(color: Colors.white)),style:
              ElevatedButton.styleFrom(backgroundColor: Colors.red),)
          ],
        ),
      ),
    );
  }
}
/*--------------------------------PLACE ORDERING SCREEN-------------------------------*/
// class PlaceOrder extends StatefulWidget{
//   @override
//   _PlaceorderState createState() => _PlaceorderState();
// }
// class _PlaceorderState extends State<PlaceOrder>{
//   @override
//   Widget build(BuildContext context){
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home:Scaffold(
//           appBar: AppBar(
//             backgroundColor: Colors.red[800],
//             title: Text("Place Ordering",style: TextStyle(color: Colors.white),
//             ),
//           ),
//           body: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Container(
//                   child: StreamBuilder<QuerySnapshot>(
//                     stream: FirebaseFirestore.instance.collection('PlaceOrder').snapshots(),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return Center(child: CircularProgressIndicator());
//                       }
//                       if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                         return Center(child: Text("No Customer found"));
//                       }
//
//                       return Column(
//                         children: snapshot.data!.docs.map((doc) {
//                           final data = doc.data() as Map<String, dynamic>;
//
//
//                           return Container(
//                             margin: EdgeInsets.all(23),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(19),
//                               color: Colors.orange[100],
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black.withOpacity(0.5),
//                                   spreadRadius: 2,
//                                   blurRadius: 6,
//                                   offset: Offset(0, 3),
//                                 )
//                               ],
//                             ),
//                             padding: EdgeInsets.all(18),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(data['username'],
//                                         style: TextStyle(
//                                             color: Colors.red[500],
//                                             fontSize: 30,
//                                             fontWeight: FontWeight.bold)),
//                                     SizedBox(height: 13),
//                                     Text(data['email'],
//                                         style: TextStyle(
//                                             color: Colors.red[500],
//                                             fontSize: 30,
//                                             fontWeight: FontWeight.bold)),
//                                     SizedBox(height: 13),
//                                     Text(data['phone'],
//                                         style: TextStyle(
//                                             color: Colors.red[500],
//                                             fontSize: 30,
//                                             fontWeight: FontWeight.bold)),
//                                     SizedBox(height: 13),
//                                     Text(data['name'],
//                                         style: TextStyle(
//                                             color: Colors.red[500],
//                                             fontSize: 30,
//                                             fontWeight: FontWeight.bold)),
//                                     SizedBox(height: 13),
//                                     Text("Total: PKR ${data['total']}/-",
//                                         style: TextStyle(
//                                             color: Colors.green,
//                                             fontWeight: FontWeight.bold)),
//                                     SizedBox(height: 13),
//                                     ElevatedButton(
//                                       onPressed: () {},
//                                       child: Text("Confirm Order",
//                                           style:
//                                           TextStyle(fontWeight: FontWeight.bold)),
//                                       style: ElevatedButton.styleFrom(
//                                         backgroundColor: Colors.orange,
//                                         foregroundColor: Colors.white,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//
//                               ],
//                             ),
//                           );
//                         }).toList(),
//                       );
//                     },
//                   ),
//                 ),
//                 Container(
//                   child: ElevatedButton(onPressed: (){
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => Menu()),
//                     );
//                   }, child: Text("Go Back"),style:
//                   ElevatedButton.styleFrom(
//                     backgroundColor: Colors.deepOrange,
//                     foregroundColor: Colors.white,
//                   ),),
//                 )
//               ],
//
//             ),
//           ),
//         )
//     );
//   }
// }
// class PlaceOrder extends StatefulWidget {
//   final List<Map<String, dynamic>> cart;
//
//   PlaceOrder({required this.cart});
//
//   @override
//   _PlaceorderState createState() => _PlaceorderState();
// }
//
// class _PlaceorderState extends State<PlaceOrder> {
//   late List<Map<String, dynamic>> cart;
//   User? currentUser;
//   bool isLoading = true;
//   String? username; // Track loading state
//
//   @override
//   void initState() {
//     super.initState();
//     cart = widget.cart;
//     _loadUserData();
//   }
//
//   // Method to load the authenticated user data
//   void _loadUserData() async {
//     currentUser = FirebaseAuth.instance.currentUser;
//
//     if (currentUser != null) {
//       // Fetch username from Firestore
//       DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection(
//           'users').doc(currentUser!.uid).get();
//       setState(() {
//         username = userDoc['username']; // Store the username
//         isLoading = false; // Stop loading once the data is fetched
//       });
//     } else {
//       setState(() {
//         isLoading = false; // Stop loading once the data is fetched
//       });
//     }
//
//     @override
//     Widget build(BuildContext context) {
//       // Show a loading spinner while the user data is loading
//       if (isLoading) {
//         return Scaffold(
//           backgroundColor: Colors.orange,
//           appBar: AppBar(
//             backgroundColor: Colors.red[800],
//             title: Text("Place Order", style: TextStyle(color: Colors.white)),
//           ),
//           body: Center(child: CircularProgressIndicator()), // Loading indicator
//         );
//       }
//
//       double total = cart.fold(
//           0, (sum, item) => sum + (item['price'] * item['quantity']));
//
//       return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.red[800],
//           title: Text("Place Order", style: TextStyle(color: Colors.white)),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Column(
//             children: [
//               // Display current user details only if the user is logged in
//               if (currentUser != null) ...[
//                 Text(
//                   "User: ${username ?? "No Username"}", // Display username
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   "Email: ${currentUser!.email ?? "No Email"}",
//                   style: TextStyle(fontSize: 16),
//                 ),
//                 SizedBox(height: 8),
//               ] else
//                 ...[
//                   // If no user is logged in, show a message
//                   Text(
//                     "No user is logged in.",
//                     style: TextStyle(fontSize: 16, color: Colors.red),
//                   ),
//                 ],
//
//               // Display cart items
//               ...cart
//                   .asMap()
//                   .entries
//                   .map((entry) {
//                 int index = entry.key;
//                 Map<String, dynamic> item = entry.value;
//
//                 return ListTile(
//                   title: Text(item['name']),
//                   subtitle: Row(
//                     children: [
//                       IconButton(
//                         icon: Icon(Icons.remove, color: Colors.red),
//                         onPressed: () =>
//                             setState(() {
//                               item['quantity'] -= 1;
//                               if (item['quantity'] < 1) item['quantity'] = 1;
//                             }),
//                       ),
//                       Text("${item['quantity']}"),
//                       IconButton(
//                         icon: Icon(Icons.add, color: Colors.green),
//                         onPressed: () =>
//                             setState(() {
//                               item['quantity'] += 1;
//                             }),
//                       ),
//                     ],
//                   ),
//                   trailing: Text("PKR ${item['price'] * item['quantity']}"),
//                 );
//               }),
//
//               Divider(),
//               Text(
//                 "Total: PKR $total",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () {
//                   // Handle order placement logic here
//                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                     content: Text("Order placed successfully!"),
//                     backgroundColor: Colors.green,
//                   ));
//                 },
//                 child: Text(
//                     "Confirm Order", style: TextStyle(color: Colors.white)),
//                 style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
//               ),
//             ],
//           ),
//         ),
//       );
//     }
//
// }
// class PlaceOrder extends StatefulWidget {
//   final List<Map<String, dynamic>> cart;
//
//   PlaceOrder({required this.cart});
//
//   @override
//   _PlaceorderState createState() => _PlaceorderState();
// }
//
// class _PlaceorderState extends State<PlaceOrder> {
//   late List<Map<String, dynamic>> cart;
//   User? currentUser;
//   bool isLoading = true;
//   String? username; // Track loading state
//
//   @override
//   void initState() {
//     super.initState();
//     cart = widget.cart;
//     _loadUserData();
//   }
//
//   // Method to load the authenticated user data
//   void _loadUserData() async {
//     currentUser = FirebaseAuth.instance.currentUser;
//
//     if (currentUser != null) {
//       // Fetch username from Firestore
//       DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection(
//           'users').doc(currentUser!.uid).get();
//       setState(() {
//         username = userDoc['username']; // Store the username
//         isLoading = false; // Stop loading once the data is fetched
//       });
//     } else {
//       setState(() {
//         isLoading = false; // Stop loading once the data is fetched
//       });
//     }
//   }
//
//   // Function to show success dialog
//   void _showSuccessDialog() {
//     showDialog(
//       context: context,
//       barrierDismissible: false, // Prevent dialog dismissal by tapping outside
//       builder: (BuildContext context) {
//         return AlertDialog(
//             backgroundColor: Colors.white,
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//             contentPadding: EdgeInsets.all(20),
//             title: Column(
//               children: [
//                 Icon(Icons.check_circle, color: Colors.green, size: 70),
//                 SizedBox(height: 10),
//                 Text(
//                   "Order Placed Successfully!",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//             content: Text(
//               "Thank you for your order. Your items will be processed shortly.",
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 16),
//             ),
//             actions: [
//             ElevatedButton(
//             onPressed: () {
//           Navigator.of(context).pop(); // Close the dialog
//         },
//         child: Text("Ok", style: TextStyle(color: Colors.white)),
//         style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
//             )
//         ]
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Show a loading spinner while the user data is loading
//     if (isLoading) {
//       return Scaffold(
//         backgroundColor: Colors.orange,
//         appBar: AppBar(
//           backgroundColor: Colors.red[800],
//           title: Text("Place Order", style: TextStyle(color: Colors.white)),
//         ),
//         body: Center(child: CircularProgressIndicator()), // Loading indicator
//       );
//     }
//
//     double total = cart.fold(
//         0, (sum, item) => sum + (item['price'] * item['quantity']));
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.red[800],
//         title: Text("Place Order", style: TextStyle(color: Colors.white)),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           children: [
//             // Display current user details only if the user is logged in
//             if (currentUser != null) ...[
//               Text(
//                 "User: ${username ?? "No Username"}", // Display username
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 "Email: ${currentUser!.email ?? "No Email"}",
//                 style: TextStyle(fontSize: 16),
//               ),
//               SizedBox(height: 8),
//             ] else ...[
//               // If no user is logged in, show a message
//               Text(
//                 "No user is logged in.",
//                 style: TextStyle(fontSize: 16, color: Colors.red),
//               ),
//             ],
//
//             // Display cart items
//             ...cart
//                 .asMap()
//                 .entries
//                 .map((entry) {
//               int index = entry.key;
//               Map<String, dynamic> item = entry.value;
//
//               return ListTile(
//                 title: Text(item['name']),
//                 subtitle: Row(
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.remove, color: Colors.red),
//                       onPressed: () =>
//                           setState(() {
//                             item['quantity'] -= 1;
//                             if (item['quantity'] < 1) item['quantity'] = 1;
//                           }),
//                     ),
//                     Text("${item['quantity']}"),
//                     IconButton(
//                       icon: Icon(Icons.add, color: Colors.green),
//                       onPressed: () =>
//                           setState(() {
//                             item['quantity'] += 1;
//                           }),
//                     ),
//                   ],
//                 ),
//                 trailing: Text("PKR ${item['price'] * item['quantity']}"),
//               );
//             }),
//
//             Divider(),
//             Text(
//               "Total: PKR $total",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 // Handle order placement logic here
//                 _showSuccessDialog(); // Show success dialog
//               },
//               child: Text(
//                   "Confirm Order", style: TextStyle(color: Colors.white)),
//               style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

 // Add this import




// class PlaceOrder extends StatefulWidget {
//   final List<Map<String, dynamic>> cart;
//
//   PlaceOrder({required this.cart});
//
//   @override
//   _PlaceOrderState createState() => _PlaceOrderState();
// }
//
// class _PlaceOrderState extends State<PlaceOrder> with TickerProviderStateMixin {
//   late List<Map<String, dynamic>> cart;
//   User? currentUser;
//   bool isLoading = true;
//   String? username;
//
//   late AnimationController _sparkleController;
//
//   @override
//   void initState() {
//     super.initState();
//     cart = widget.cart;
//     _loadUserData();
//     _sparkleController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     )..repeat(reverse: true); // Repeats the sparkle animation
//   }
//
//   void _loadUserData() async {
//     currentUser = FirebaseAuth.instance.currentUser;
//
//     if (currentUser != null) {
//       DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(currentUser!.uid).get();
//       setState(() {
//         username = userDoc['username'];
//         isLoading = false;
//       });
//     } else {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     _sparkleController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return Scaffold(
//         backgroundColor: Colors.orange,
//         appBar: AppBar(
//           backgroundColor: Colors.red[800],
//           title: Text("Place Order", style: TextStyle(color: Colors.white)),
//         ),
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }
//
//     double total = cart.fold(0, (sum, item) => sum + (item['price'] * item['quantity']));
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.red[800],
//         title: Text("Place Order", style: TextStyle(color: Colors.white)),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           children: [
//             if (currentUser != null) ...[
//               Text(
//                 "User: ${username ?? "No Username"}",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 8),
//               Text("Email: ${currentUser!.email ?? "No Email"}", style: TextStyle(fontSize: 16)),
//               SizedBox(height: 8),
//             ] else ...[
//               Text("No user is logged in.", style: TextStyle(fontSize: 16, color: Colors.red)),
//             ],
//
//             ...cart.asMap().entries.map((entry) {
//               int index = entry.key;
//               Map<String, dynamic> item = entry.value;
//
//               return ListTile(
//                 title: Text(item['name']),
//                 subtitle: Row(
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.remove, color: Colors.red),
//                       onPressed: () => setState(() {
//                         item['quantity'] -= 1;
//                         if (item['quantity'] < 1) item['quantity'] = 1;
//                       }),
//                     ),
//                     Text("${item['quantity']}"),
//                     IconButton(
//                       icon: Icon(Icons.add, color: Colors.green),
//                       onPressed: () => setState(() {
//                         item['quantity'] += 1;
//                       }),
//                     ),
//                   ],
//                 ),
//                 trailing: Text("PKR ${item['price'] * item['quantity']}"),
//               );
//             }),
//
//             Divider(),
//             Text("Total: PKR $total", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 _showOrderPlacedDialog(context); // Show the success dialog
//               },
//               child: Text("Confirm Order", style: TextStyle(color: Colors.white)),
//               style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Method to show the Order Placed Success dialog with custom sparkle effect
//   void _showOrderPlacedDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//
//           backgroundColor: Colors.transparent,
//           child: Stack(
//
//             children: [
//               // Custom sparkle effect
//               Positioned.fill(
//                 child: AnimatedBuilder(
//                   animation: _sparkleController,
//                   builder: (context, child) {
//                     return CustomPaint(
//                       painter: SparklePainter(),
//                     );
//                   },
//                 ),
//               ),
//               Center(
//                 child: AlertDialog(
//                   backgroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                   contentPadding: EdgeInsets.all(20),
//                   title: Column(
//                     children: [
//                       Icon(Icons.check_circle, color: Colors.green, size: 70),
//                       SizedBox(height: 10),
//                       Text("Order Placed Successfully!", textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                     ],
//                   ),
//                   content: Text("Thank you for your order. Your items will be processed shortly.", textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
//                   actions: [
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.of(context).pop(); // Close the dialog
//                       },
//                       child: Text("Okay", style: TextStyle(color: Colors.white)),
//                       style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
//
// class SparklePainter extends CustomPainter {
//   final Random random = Random();
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.yellow.withOpacity(0.8)
//       ..style = PaintingStyle.fill;
//
//     for (int i = 0; i < 100; i++) {
//       double x = random.nextDouble() * size.width;
//       double y = random.nextDouble() * size.height;
//       double radius = random.nextDouble() * 3 + 2; // Random radius for sparkles
//       canvas.drawCircle(Offset(x, y), radius, paint);
//     }
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }


// class PlaceOrder extends StatefulWidget {
//   final List<Map<String, dynamic>> cart;
//
//   PlaceOrder({required this.cart});
//
//   @override
//   _PlaceOrderState createState() => _PlaceOrderState();
// }
//
// class _PlaceOrderState extends State<PlaceOrder> with TickerProviderStateMixin {
//   late List<Map<String, dynamic>> cart;
//   User? currentUser;
//   bool isLoading = true;
//   String? username;
//
//   late AnimationController _sparkleController;
//
//   @override
//   void initState() {
//     super.initState();
//     cart = widget.cart;
//     _loadUserData();
//     _sparkleController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     )..repeat(reverse: true); // Repeats the sparkle animation
//   }
//
//   void _loadUserData() async {
//     currentUser = FirebaseAuth.instance.currentUser;
//
//     if (currentUser != null) {
//       DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(currentUser!.uid).get();
//       setState(() {
//         username = userDoc['username'];
//
//         isLoading = false;
//       });
//     } else {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     _sparkleController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return Scaffold(
//         backgroundColor: Colors.orange,
//         appBar: AppBar(
//           backgroundColor: Colors.red[800],
//           title: Text("Place Order", style: TextStyle(color: Colors.white)),
//         ),
//         body: Center(child: CircularProgressIndicator()), // Loading indicator
//       );
//     }
//
//     double total = cart.fold(0, (sum, item) => sum + (item['price'] * item['quantity']));
//
//     return Scaffold(
//       backgroundColor: Colors.orange,
//       appBar: AppBar(
//         backgroundColor: Colors.red[800],
//         title: Text("Place Order", style: TextStyle(color: Colors.white)),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           children: [
//             if (currentUser != null) ...[
//               Text(
//                 "User: ${username ?? "No Username"}",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 "Phone Number: ${phone ?? "No phone number"}",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 8),
//               Text("Email: ${currentUser!.email ?? "No Email"}", style: TextStyle(fontSize: 16)),
//               SizedBox(height: 8),
//             ] else ...[
//               Text("No user is logged in.", style: TextStyle(fontSize: 16, color: Colors.red)),
//             ],
//
//             // Display cart items
//             ...cart.map((item) {
//               return ListTile(
//                 title: Text(item['name']),
//                 subtitle: Text("Quantity: ${item['quantity']}"),
//                 trailing: Text("PKR ${item['price'] * item['quantity']}"),
//               );
//             }),
//
//             Divider(),
//             Text("Total: PKR $total", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 _saveOrderToFirebase(total); // Save order to Firebase
//                 _showOrderPlacedDialog(context); // Show the success dialog
//               },
//               child: Text("Confirm Order", style: TextStyle(color: Colors.white)),
//               style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Method to save the order data to Firebase Firestore
//   Future<void> _saveOrderToFirebase(double total) async {
//     if (currentUser != null) {
//       // Reference to Firestore
//       CollectionReference orders = FirebaseFirestore.instance.collection('orders');
//
//       // Create the order data
//       Map<String, dynamic> orderData = {
//         'username': username,
//         'email': currentUser!.email,
//         'cart': cart,
//         'total': total,
//         'timestamp': FieldValue.serverTimestamp(),
//       };
//
//       // Add order to Firestore
//       try {
//         await orders.add(orderData);
//       } catch (e) {
//         print("Error saving order: $e");
//       }
//     }
//   }
//
//   // Method to show the Order Placed Success dialog with custom sparkle effect
//   void _showOrderPlacedDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           backgroundColor: Colors.transparent,
//           child: Stack(
//             children: [
//               // Custom sparkle effect
//               Positioned.fill(
//                 child: AnimatedBuilder(
//                   animation: _sparkleController,
//                   builder: (context, child) {
//                     return CustomPaint(
//                       painter: SparklePainter(),
//                     );
//                   },
//                 ),
//               ),
//               Center(
//                 child: AlertDialog(
//                   backgroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                   contentPadding: EdgeInsets.all(20),
//                   title: Column(
//                     children: [
//                       Icon(Icons.check_circle, color: Colors.green, size: 70),
//                       SizedBox(height: 10),
//                       Text("Order Placed Successfully!", textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                     ],
//                   ),
//                   content: Text("Thank you for your order. Your items will be processed shortly.", textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
//                   actions: [
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.of(context).pop(); // Close the dialog
//                       },
//                       child: Text("Okay", style: TextStyle(color: Colors.white)),
//                       style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
//
// class SparklePainter extends CustomPainter {
//   final Random random = Random();
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.yellow.withOpacity(0.8)
//       ..style = PaintingStyle.fill;
//
//     for (int i = 0; i < 100; i++) {
//       double x = random.nextDouble() * size.width;
//       double y = random.nextDouble() * size.height;
//       double radius = random.nextDouble() * 3 + 2; // Random radius for sparkles
//       canvas.drawCircle(Offset(x, y), radius, paint);
//     }
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }


class PlaceOrder extends StatefulWidget {
  final List<Map<String, dynamic>> cart;

  PlaceOrder({required this.cart});

  @override
  _PlaceOrderState createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> with TickerProviderStateMixin {
  late List<Map<String, dynamic>> cart;
  User? currentUser;
  bool isLoading = true;
  String? username;
  String? phone; // Store user's phone number
  bool isCashOnDelivery = false; // Payment method selected
  bool isCreditCard = false; // Payment method selected

  late AnimationController _sparkleController;

  @override
  void initState() {
    super.initState();
    cart = widget.cart;
    _loadUserData();
    _sparkleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true); // Repeats the sparkle animation
  }

  void _loadUserData() async {
    currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(currentUser!.uid).get();
      setState(() {
        username = userDoc['username'];
        phone = userDoc['phone']; // Assuming the user's phone number is stored in Firebase
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _sparkleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        backgroundColor: Colors.orange,
        appBar: AppBar(
          backgroundColor: Colors.red[800],
          title: Text("Place Order", style: TextStyle(color: Colors.white)),
        ),
        body: Center(child: CircularProgressIndicator()), // Loading indicator
      );
    }

    double total = cart.fold(0, (sum, item) => sum + (item['price'] * item['quantity']));

    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        backgroundColor: Colors.red[800],
        title: Text("Place Order", style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (currentUser != null) ...[
              Text(
                "User: ${username ?? "No Username"}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "Phone Number: ${phone ?? "No phone number"}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text("Email: ${currentUser!.email ?? "No Email"}", style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
            ] else ...[
              Text("No user is logged in.", style: TextStyle(fontSize: 16, color: Colors.red)),
            ],

            // Display cart items
            ...cart.map((item) {
              return ListTile(
                title: Text(item['name']),
                subtitle: Text("Quantity: ${item['quantity']}"),
                trailing: Text("PKR ${item['price'] * item['quantity']}"),
              );
            }),

            Divider(),
            Text("Total: PKR $total", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),

            // Payment method options (Checkboxes)
            Text("Select Payment Method", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Row(
              children: [
                Checkbox(
                  value: isCashOnDelivery,
                  onChanged: (bool? value) {
                    setState(() {
                      isCashOnDelivery = value ?? false;
                      if (isCashOnDelivery) isCreditCard = false; // Uncheck Credit Card if Cash is selected
                    });
                  },
                ),
                Text("Cash on Delivery"),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: isCreditCard,
                  onChanged: (bool? value) {
                    setState(() {
                      isCreditCard = value ?? false;
                      if (isCreditCard) isCashOnDelivery = false; // Uncheck Cash on Delivery if Credit Card is selected
                    });
                  },
                ),
                Text("Credit Card"),
              ],
            ),
            SizedBox(height: 16),

            // Confirm Order Button
            ElevatedButton(
              onPressed: () {
                _saveOrderToFirebase(total); // Save order to Firebase
                _showOrderPlacedDialog(context); // Show the success dialog
              },
              child: Text("Confirm Order", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            ),
          ],
        ),
      ),
    );
  }

  // Method to save the order data to Firebase Firestore
  Future<void> _saveOrderToFirebase(double total) async {
    if (currentUser != null) {
      // Reference to Firestore
      CollectionReference orders = FirebaseFirestore.instance.collection('orders');

      // Create the order data
      Map<String, dynamic> orderData = {
        'username': username,
        'email': currentUser!.email,
        'phone': phone,
        'cart': cart,
        'total': total,
        'paymentMethod': isCashOnDelivery ? "Cash on Delivery" : "Credit Card",
        'timestamp': FieldValue.serverTimestamp(),
      };

      // Add order to Firestore
      try {
        await orders.add(orderData);
      } catch (e) {
        print("Error saving order: $e");
      }
    }
  }

  // Method to show the Order Placed Success dialog with custom sparkle effect
  void _showOrderPlacedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              // Custom sparkle effect
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: _sparkleController,
                  builder: (context, child) {
                    return CustomPaint(
                      painter: SparklePainter(),
                    );
                  },
                ),
              ),
              Center(
                child: AlertDialog(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  contentPadding: EdgeInsets.all(20),
                  title: Column(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green, size: 70),
                      SizedBox(height: 10),
                      Text("Order Placed Successfully!", textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  content: Text("Thank you for your order. Your items will be processed shortly.", textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: Text("Okay", style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class SparklePainter extends CustomPainter {
  final Random random = Random();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.yellow.withOpacity(0.8)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 100; i++) {
      double x = random.nextDouble() * size.width;
      double y = random.nextDouble() * size.height;
      double radius = random.nextDouble() * 3 + 2; // Random radius for sparkles
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
