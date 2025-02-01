
import 'package:flutter/material.dart';

void main() {
  runApp(RestaurantAdminApp());
}

class RestaurantAdminApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurant Admin Panel',
      theme: ThemeData(
        primaryColor: Colors.red,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(color: Colors.yellowAccent),
        drawerTheme: DrawerThemeData(backgroundColor: Colors.red),
        textTheme: TextTheme(),
      ),
      home: AdminDashboard(),
    );
  }
}

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulating a loading delay for initial data loading
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminSidebar(),
      appBar: AppBar(
        title: Text('Grill Craft Dashboard', style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: DashboardContent()),
          ],
        ),
      ),
    );
  }
}

class AdminSidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Adjust image size for better fitting inside the circular ClipOval

          Image.asset(
            'images/h.jpg',
            height: 200,
            // Set both height and width to the same value for a perfect circle
            width: 100,
            fit: BoxFit
                .cover, // Ensures the image covers the circle without stretching
          ),

          SizedBox(height: 10), // Adds some space between the image and text
          // Row for the text and icon to align better
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // Centers the text and icon horizontally
            children: [
              Icon(Icons.admin_panel_settings, color: Colors.white, size: 35),
              SizedBox(width: 10),
              // Adds some space between the icon and the text
              Text(
                'Admin Dashboard',
                style: TextStyle(color: Colors.white, fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          SizedBox(height: 20), // Adds space before the ListTile options
          ListTile(title: Text('Home', style: TextStyle(color: Colors.black54)),
              leading: Icon(Icons.home, color: Colors.yellow),
              onTap: () {Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CustomerOrdersTable()), // Create a screen that holds the PaymentTable
              );}),
          ListTile(
              title: Text('Orders', style: TextStyle(color: Colors.black54)),
              leading: Icon(Icons.shopping_cart, color: Colors.yellow),
              onTap: () {Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CustomerOrdersTable()), // Create a screen that holds the PaymentTable
              );}),
          ListTile(
              title: Text('Payments', style: TextStyle(color: Colors.black54)),
              leading: Icon(Icons.payment, color: Colors.yellow),
              onTap: () {Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PaymentTable()), // Create a screen that holds the PaymentTable
              );}),
          ListTile(
              title: Text('Food Menu', style: TextStyle(color: Colors.black54)),
              leading: Icon(Icons.menu, color: Colors.yellow),
              onTap: () {Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FoodMenuTable()), // Create a screen that holds the PaymentTable
              );}),
          ListTile(
              title: Text('Settings', style: TextStyle(color: Colors.black54)),
              leading: Icon(Icons.settings, color: Colors.yellow),
              onTap: () {}),
          ListTile(
              title: Text('Logout', style: TextStyle(color: Colors.black54)),
              leading: Icon(Icons.logout, color: Colors.yellow),
              onTap: () => _showLogoutDialog(context)),
        ],
      ),
    );
  }
}

class PaymentTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set the background color to black
      appBar: AppBar(
        title: Text('Payments', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.yellowAccent,
      ),
      body: Center( // Center the content in the screen
        child: SingleChildScrollView( // Ensure the table is scrollable if needed
          child: DataTable(
            headingRowColor: MaterialStateProperty.all(Colors.red), // Set the header row color to red
            columns: [
              DataColumn(label: Text('Customer Name', style: TextStyle(color: Colors.white))),
              DataColumn(label: Text('Payment Amount', style: TextStyle(color: Colors.white))),
            ],
            rows: List.generate(5, (index) {
              return DataRow(cells: [
                DataCell(Text('Customer $index', style: TextStyle(color: Colors.white))),
                DataCell(Text('\$${(index + 1) * 20}.00', style: TextStyle(color: Colors.white))),
              ]);
            }),
          ),
        ),
      ),
    );
  }
}



  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text('Logout', style: TextStyle(color: Colors.black)),
        content: Text('Are you sure you want to logout?', style: TextStyle(color: Colors.black)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: Colors.black)),
          ),
          TextButton(
            onPressed: () {
              // Implement logout logic here
              Navigator.pop(context);
            },
            child: Text('Logout', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }

class FoodMenuTable extends StatelessWidget {
  // Define the showdialogue method to display a dialog
  void showdialogue(BuildContext context, String action) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$action Food Item'),
          content: Text('Do you want to $action this food item?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Perform the action (edit or delete)
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(action),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set the background color to black
      appBar: AppBar(
        title: Text('Food Menu', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.yellowAccent,
      ),
      body: Center( // Center the content on the screen
        child: SingleChildScrollView( // Ensure the table is scrollable if needed
          child: DataTable(
            headingRowColor: MaterialStateProperty.all(Colors.red), // Set the header row color to red
            columns: [
              DataColumn(label: Text('Food Name', style: TextStyle(color: Colors.white))),
              DataColumn(label: Text('Price', style: TextStyle(color: Colors.white))),
            ],
            rows: List.generate(5, (index) {
              return DataRow(cells: [
                DataCell(Text('Food Item $index', style: TextStyle(color: Colors.white))),
                DataCell(Text('\$${(index + 1) * 10}.00', style: TextStyle(color: Colors.white))),

              ]);
            }),
          ),
        ),
      ),
    );
  }
}



class DashboardContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(title: 'Customer Orders'),
        Expanded(child: CustomerOrdersTable()),
      ],
    );
  }
}

class CustomerOrdersTable extends StatelessWidget {
  void _showDialog(BuildContext context, String action) {
    final priceController = TextEditingController();
    final foodMenuController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.red,
        title: Text('$action Customer Order', style: TextStyle(color: Colors.black)),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'Price', labelStyle: TextStyle(color: Colors.black)),
              style: TextStyle(color: Colors.black),
            ),
            TextField(
              controller: foodMenuController,
              decoration: InputDecoration(labelText: 'Food Item', labelStyle: TextStyle(color: Colors.black)),
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: Colors.black)),
          ),
          TextButton(
            onPressed: () {
              // Handle the update action (use priceController.text, foodMenuController.text)
            },
            child: Text(action, style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
        DataColumn(label: Text('Customer ID', style: TextStyle(color: Colors.yellow))),
        DataColumn(label: Text('Name', style: TextStyle(color: Colors.yellow))),
        DataColumn(label: Text('Phone', style: TextStyle(color: Colors.yellow))),
        DataColumn(label: Text('Order', style: TextStyle(color: Colors.yellow))),
        DataColumn(label: Text('Price', style: TextStyle(color: Colors.yellow))),
        DataColumn(label: Text('Actions', style: TextStyle(color: Colors.yellow))),
      ],
      rows: List.generate(5, (index) {
        return DataRow(cells: [
          DataCell(Text('$index', style: TextStyle(color: Colors.white))),
          DataCell(Text('$index', style: TextStyle(color: Colors.white))),
          DataCell(Text('$index', style: TextStyle(color: Colors.white))),
          DataCell(Text('$index', style: TextStyle(color: Colors.white))),
          DataCell(Text('00', style: TextStyle(color: Colors.white))),
          DataCell(Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit, color: Colors.blue),
                onPressed: () => _showDialog(context, 'Update'),
              ),
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () => _showDialog(context, 'Delete'),
              ),
            ],
          )),
        ]);
      }),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}

