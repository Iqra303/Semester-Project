import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'splash.dart';

/*-------------------------------ADMIN PANEL---------------------------------*/
/*-------CRUD ON PRODUCTS-----------*/
/*-------CRUD ON ORDERS------------*/
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(home: AdminPanel(), debugShowCheckedModeBanner: false));
}

class AdminPanel extends StatefulWidget {
  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  final categories = {
    "Burger": "burger",
    "Fries": "fries",
    "Pizza": "pizza",
    "Sweets": "sweats",
    "Wings": "wings",
    "Deals": "menu"
  };

  String selectedCategory = "Burger";

  get collections => null;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.orangeAccent[100],
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.orangeAccent[100],
          title: Text("Fork n Knives", style: TextStyle(
              color: Colors.red, fontWeight: FontWeight.bold, fontSize: 25)),
          leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SplashScreen()));
              }, icon: Icon(Icons.home, size: 26, color: Colors.red,))
          ),
          bottom: TabBar(tabs: [
            Tab(text: "Products"),
            Tab(text: "Orders"),
          ]),
        ),

        body: TabBarView(
          children: [
            buildProductManager(),
            buildOrderManager(),
          ],
        ),

      ),
    );
  }


  /// ===================== PRODUCT MANAGER =====================
  Widget buildProductManager() {
    String collectionName = categories[selectedCategory]!;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: DropdownButton<String>(
            borderRadius: BorderRadius.circular(10),
            dropdownColor: Colors.orangeAccent[100],
            value: selectedCategory,
            style: TextStyle(color: Colors.red, fontSize: 20),
            onChanged: (v) => setState(() => selectedCategory = v!),
            items: categories.keys
                .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                .toList(),
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection(collectionName)
                .snapshots(),
            builder: (context, snap) {
              if (!snap.hasData)
                return Center(child: CircularProgressIndicator());
              final docs = snap.data!.docs;
              return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (ctx, i) {
                  final doc = docs[i];
                  final data = doc.data() as Map<String, dynamic>;

                  Widget subtitle;
                  // 1) SIMPLE PRODUCTS
                  if (collectionName != 'pizza' && collectionName != 'menu') {
                    subtitle = Text("PKR ${data['price']}",
                        style: TextStyle(color: Colors.grey));
                  }
                  // 2) PIZZA: parse list or map into size→price
                  else if (collectionName == 'pizza') {
                    // rawPrice could be List or Map
                    final raw = data['price'];
                    Map<String, int> priceMap = {};
                    if (raw is List && raw.length >= 3) {
                      priceMap =
                      {'Small': raw[0], 'Medium': raw[1], 'Large': raw[2]};
                    } else if (raw is Map) {
                      ['Small', 'Medium', 'Large']
                          .forEach((s) => priceMap[s] = (raw[s] ?? 0) as int);
                    }
                    subtitle = Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: priceMap.entries
                          .map((e) => Text("${e.key}: PKR ${e.value}",
                          style: TextStyle(color: Colors.green)))
                          .toList(),
                    );
                  }
                  // 3) DEALS (collection “menu”)
                  else {
                    final items = (data['items'] as List<dynamic>).cast<
                        String>();
                    subtitle = Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Includes: ${items.join(', ')}", style: TextStyle(
                            color: Colors.grey)),
                        Text("PKR ${data['price']}", style: TextStyle(
                            color: Colors.green)),
                      ],
                    );
                  }

                  return ListTile(
                    title: Text(
                        data['name'], style: TextStyle(color: Colors.red)),
                    subtitle: subtitle,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.orangeAccent),
                          onPressed: () =>
                              showProductDialog(
                                collectionName,
                                id: doc.id,
                                existing: data,
                              ),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () =>
                              FirebaseFirestore.instance
                                  .collection(collectionName)
                                  .doc(doc.id)
                                  .delete(),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
        ElevatedButton(
          onPressed: () => showProductDialog(categories[selectedCategory]!),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red,padding: EdgeInsets.only(left: 60,right: 60)),
          child: Text("Add Product", style: TextStyle(color: Colors.white)),

        ),
      ],
    );
  }

  /// ===================== DYNAMIC ADD/EDIT DIALOG =====================
  void showProductDialog(String collectionName, {
    String? id,
    Map<String, dynamic>? existing,
  }) {
    // controllers
    final nameCtrl = TextEditingController(text: existing?['name']);
    final imageCtrl = TextEditingController(text: existing?['image']);
    // for simple price
    final priceCtrl = TextEditingController(
      text: existing != null && existing!['price'] is int
          ? existing['price'].toString()
          : null,
    );
    // for pizza sizes
    final smallCtrl = TextEditingController();
    final medCtrl = TextEditingController();
    final largeCtrl = TextEditingController();
    if (collectionName == 'pizza' && existing != null) {
      final raw = existing['price'];
      if (raw is List && raw.length >= 3) {
        smallCtrl.text = raw[0].toString();
        medCtrl.text = raw[1].toString();
        largeCtrl.text = raw[2].toString();
      } else if (raw is Map) {
        smallCtrl.text = (raw['Small'] ?? '').toString();
        medCtrl.text = (raw['Medium'] ?? '').toString();
        largeCtrl.text = (raw['Large'] ?? '').toString();
      }
    }
    // for deals (menu)
    final itemsCtrl = TextEditingController(
      text: collectionName == 'menu' && existing != null
          ? (existing['items'] as List).join(',')
          : '',
    );

    showDialog(
      context: context,
      builder: (_) =>
          AlertDialog(
            backgroundColor: Colors.orange[400],
            title: Text(
              id == null ? "Add Product" : "Edit Product",
              style: TextStyle(color: Colors.white),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  // common fields
                  TextField(
                    controller: nameCtrl,
                    decoration: InputDecoration(
                      hintText: "Name",
                      hintStyle: TextStyle(color: Colors.white54),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  TextField(
                    controller: imageCtrl,
                    decoration: InputDecoration(
                      hintText: "Image path",
                      hintStyle: TextStyle(color: Colors.white54),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),

                  // simple price
                  if (collectionName != 'pizza' && collectionName != 'menu')
                    TextField(
                      controller: priceCtrl,
                      decoration: InputDecoration(
                        hintText: "Price",
                        hintStyle: TextStyle(color: Colors.white54),
                      ),
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.white),
                    ),

                  // pizza: three size fields
                  if (collectionName == 'pizza') ...[
                    SizedBox(height: 12),
                    Text("Small / Medium / Large",
                        style: TextStyle(color: Colors.white70)),
                    TextField(
                      controller: smallCtrl,
                      decoration: InputDecoration(
                        hintText: "Small price",
                        hintStyle: TextStyle(color: Colors.white54),
                      ),
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.white),
                    ),
                    TextField(
                      controller: medCtrl,
                      decoration: InputDecoration(
                        hintText: "Medium price",
                        hintStyle: TextStyle(color: Colors.white54),
                      ),
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.white),
                    ),
                    TextField(
                      controller: largeCtrl,
                      decoration: InputDecoration(
                        hintText: "Large price",
                        hintStyle: TextStyle(color: Colors.white54),
                      ),
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],

                  // deals: comma‑separated items + single price
                  if (collectionName == 'menu') ...[
                    SizedBox(height: 12),
                    TextField(
                      controller: itemsCtrl,
                      decoration: InputDecoration(
                        hintText: "Items (comma separated)",
                        hintStyle: TextStyle(color: Colors.white54),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    TextField(
                      controller: priceCtrl,
                      decoration: InputDecoration(
                        hintText: "Deal price",
                        hintStyle: TextStyle(color: Colors.white54),
                      ),
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text("Cancel", style: TextStyle(color: Colors.white)),
                onPressed: () => Navigator.pop(context),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text("Save", style: TextStyle(color: Colors.white)),
                onPressed: () {
                  final col = FirebaseFirestore.instance.collection(
                      collectionName);

                  // build payload dynamically
                  final payload = <String, dynamic>{
                    'name': nameCtrl.text,
                    'image': imageCtrl.text
                  };
                  if (collectionName == 'pizza') {
                    payload['price'] = [
                      int.tryParse(smallCtrl.text) ?? 0,
                      int.tryParse(medCtrl.text) ?? 0,
                      int.tryParse(largeCtrl.text) ?? 0,
                    ];
                  } else if (collectionName == 'menu') {
                    payload['items'] =
                        itemsCtrl.text.split(',').map((s) => s.trim()).toList();
                    payload['price'] = int.tryParse(priceCtrl.text) ?? 0;
                  } else {
                    payload['price'] = int.tryParse(priceCtrl.text) ?? 0;
                  }

                  if (id == null)
                    col.add(payload);
                  else
                    col.doc(id).set(payload, SetOptions(merge: true));

                  Navigator.pop(context);
                },
              ),
            ],
          ),
    );
  }

  // Widget buildProductManager() {
  //   String collectionName = categories[selectedCategory]!;
  //   return Column(
  //     children: [
  //       Padding(
  //         padding: const EdgeInsets.all(8),
  //         child: DropdownButton<String>(
  //           dropdownColor: Colors.grey[900],
  //           value: selectedCategory,
  //           style: TextStyle(color: Colors.white),
  //           onChanged: (value) => setState(() => selectedCategory = value!),
  //           items: categories.keys.map((cat) {
  //             return DropdownMenuItem(value: cat, child: Text(cat));
  //           }).toList(),
  //         ),
  //       ),
  //       Expanded(
  //         child: StreamBuilder<QuerySnapshot>(
  //           stream: FirebaseFirestore.instance
  //               .collection(collectionName)
  //               .snapshots(),
  //           builder: (context, snapshot) {
  //             if (!snapshot.hasData)
  //               return Center(child: CircularProgressIndicator());
  //             final docs = snapshot.data!.docs;
  //             return ListView.builder(
  //               itemCount: docs.length,
  //               itemBuilder: (context, index) {
  //                 final item = docs[index];
  //                 return ListTile(
  //                   title: Text(item['name'], style: TextStyle(color: Colors.white)),
  //                   subtitle: Text("PKR ${item['price']}", style: TextStyle(color: Colors.grey)),
  //                   trailing: Row(
  //                     mainAxisSize: MainAxisSize.min,
  //                     children: [
  //                       IconButton(
  //                         icon: Icon(Icons.edit, color: Colors.yellow),
  //                         onPressed: () => showProductDialog(
  //                             collectionName, item.id, item['name'], item['price']),
  //                       ),
  //                       IconButton(
  //                         icon: Icon(Icons.delete, color: Colors.red),
  //                         onPressed: () => FirebaseFirestore.instance
  //                             .collection(collectionName)
  //                             .doc(item.id)
  //                             .delete(),
  //                       ),
  //                     ],
  //                   ),
  //                 );
  //               },
  //             );
  //           },
  //         ),
  //       ),
  //       ElevatedButton(
  //         onPressed: () => showProductDialog(categories[selectedCategory]!),
  //         style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[800]),
  //         child: Text("Add Product", style: TextStyle(color: Colors.white)),
  //       ),
  //     ],
  //   );
  // }
  //
  // void showProductDialog(String collectionName, [String? id, String? name, int? price, String? image]) {
  //   final nameController = TextEditingController(text: name);
  //   final priceController = TextEditingController(text: price?.toString());
  //   final imageController = TextEditingController(text: image);
  //
  //   showDialog(
  //     context: context,
  //     builder: (_) => AlertDialog(
  //       backgroundColor: Colors.grey[900],
  //       title: Text(id == null ? "Add Product" : "Edit Product", style: TextStyle(color: Colors.white)),
  //       content: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           TextField(
  //             controller: nameController,
  //             decoration: InputDecoration(hintText: "Product Name", hintStyle: TextStyle(color: Colors.white54)),
  //             style: TextStyle(color: Colors.white),
  //           ),
  //           TextField(
  //             controller: priceController,
  //             decoration: InputDecoration(hintText: "Price", hintStyle: TextStyle(color: Colors.white54)),
  //             keyboardType: TextInputType.number,
  //             style: TextStyle(color: Colors.white),
  //           ),
  //           TextField(
  //             controller: imageController,
  //             decoration: InputDecoration(hintText: "Image path", hintStyle: TextStyle(color: Colors.white54)),
  //             // keyboardType: TextInputType.text,
  //             style: TextStyle(color: Colors.white),
  //           ),
  //         ],
  //       ),
  //       actions: [
  //         TextButton(
  //           child: Text("Cancel", style: TextStyle(color: Colors.white)),
  //           onPressed: () => Navigator.pop(context),
  //         ),
  //         ElevatedButton(
  //           style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
  //           child: Text("Save", style: TextStyle(color: Colors.white)),
  //           onPressed: () {
  //             final data = {
  //               'name': nameController.text,
  //               'image': imageController.text,
  //               'price': int.parse(priceController.text),
  //             };
  //             if (id == null) {
  //               FirebaseFirestore.instance.collection(collectionName).add(data);
  //             } else {
  //               FirebaseFirestore.instance.collection(collectionName).doc(id).update(data);
  //             }
  //             Navigator.pop(context);
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  /// ===================== ORDER MANAGER =====================
//   Widget buildOrderManager() {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance
//           .collection('orders')
//           .orderBy('timestamp', descending: true)
//           .snapshots(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
//         final orders = snapshot.data!.docs;
//         return ListView.builder(
//           itemCount: orders.length,
//           itemBuilder: (context, index) {
//             final order = orders[index];
//             final cart = List.from(order['cart']);
//             return Card(
//               color: Colors.deepOrange[600],
//               margin: EdgeInsets.all(10),
//               child: Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Customer: ${order['username']}", style: TextStyle(color: Colors.white)),
//                     Text("Phone: ${order['phone']}", style: TextStyle(color: Colors.white)),
//                     Text("Email: ${order['email']}", style: TextStyle(color: Colors.white)),
//                     Text("Payment: ${order['paymentMethod']}", style: TextStyle(color: Colors.white)),
//                     Divider(color: Colors.white),
//                     ...cart.map((item) => Text(
//                       "${item['name']} x${item['quantity']} = PKR ${item['price'] * item['quantity']}",
//                       style: TextStyle(color: Colors.white),
//                     )),
//                     Divider(color: Colors.white),
//                     Text("Total: PKR ${order['total']}", style: TextStyle(color: Colors.green)),
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: IconButton(
//                         icon: Icon(Icons.delete, color: Colors.yellow),
//                         onPressed: () => FirebaseFirestore.instance
//                             .collection('orders')
//                             .doc(order.id)
//                             .delete(),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }

  /// ===================== ORDER MANAGER WITH EDIT =====================
  Widget buildOrderManager() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('orders')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());

        final orders = snapshot.data!.docs;
        return ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            final cart = List.from(order['cart']);

            return Card(
              color: Colors.deepOrange[600],
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Customer: ${order['username']}",
                        style: TextStyle(color: Colors.white)),
                    Text("Phone: ${order['phone']}",
                        style: TextStyle(color: Colors.white)),
                    Text("Email: ${order['email']}",
                        style: TextStyle(color: Colors.white)),
                    Text("Payment: ${order['paymentMethod']}",
                        style: TextStyle(color: Colors.white)),
                    Text("Address: ${order['address']}",
                        style: TextStyle(color: Colors.white)),
                    Divider(color: Colors.white),
                    ...cart.map((item) =>
                        Text(
                          "${item['name']} x${item['quantity']} = PKR ${item['price'] *
                              item['quantity']}",
                          style: TextStyle(color: Colors.white),
                        )),
                    Divider(color: Colors.white),
                    Text("Total: PKR ${order['total']}",
                        style: TextStyle(color: Colors.green)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // EDIT BUTTON
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.yellow),
                          onPressed: () {
                            showOrderDialog(
                              order.id,
                              existing: {
                                'username': order['username'],
                                'phone': order['phone'],
                                'email': order['email'],
                                'paymentMethod': order['paymentMethod'],
                              },
                            );
                          },
                        ),

                        // DELETE BUTTON
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.black),
                          onPressed: () =>
                              FirebaseFirestore.instance
                                  .collection('orders')
                                  .doc(order.id)
                                  .delete(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  /// ===================== ORDER EDIT DIALOG =====================
  void showOrderDialog(String orderId, {
    required Map<String, dynamic> existing,
  }) {
    final userCtrl = TextEditingController(text: existing['username']);
    final phoneCtrl = TextEditingController(text: existing['phone']);
    final emailCtrl = TextEditingController(text: existing['email']);
    String payment = existing['paymentMethod'];

    showDialog(

      context: context,
      builder: (ctx) =>
          StatefulBuilder(
            builder: (ctx2, setState) {
              return AlertDialog(
                backgroundColor: Colors.orangeAccent,
                title: Text(
                    "Edit Order", style: TextStyle(color: Colors.red)),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        controller: userCtrl,
                        decoration: InputDecoration(labelText: "Customer Name"),
                      ),
                      TextField(
                        controller: phoneCtrl,
                        decoration: InputDecoration(labelText: "Phone"),
                      ),
                      TextField(
                        controller: emailCtrl,
                        decoration: InputDecoration(labelText: "Email"),
                      ),

                      SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        value: payment,
                        decoration: InputDecoration(
                            labelText: "Payment Method"),
                        items: ["Cash on Delivery", "Credit Card"]
                            .map((m) =>
                            DropdownMenuItem(value: m, child: Text(m)))
                            .toList(),
                        onChanged: (v) => setState(() => payment = v!),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    child: Text("Cancel"),
                    onPressed: () => Navigator.of(ctx).pop(),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red,foregroundColor: Colors.white),

                  ),
                  ElevatedButton(
                    child: Text("Save"),
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection('orders')
                          .doc(orderId)
                          .update({
                        'username': userCtrl.text,
                        'phone': phoneCtrl.text,
                        'email': emailCtrl.text,
                        'paymentMethod': payment,
                      });
                      Navigator.of(ctx).pop();
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red,foregroundColor: Colors.white),
                  ),
                ],
              );
            },
          ),
    );
  }
}