
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../splash/screen/landing_screen.dart';
import '../../main.dart';


class HomeScreenPage extends StatefulWidget {
  @override
  _HomeScreenPageState createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  List<dynamic> _products = [];
  bool _isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    const String baseUrl = 'https://prethewram.pythonanywhere.com/api/';
    const String endpoint = 'parts_categories/';
    final String url = '$baseUrl$endpoint';

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      setState(() {
        errorMessage = 'Authentication token not found. Please log in again.';
        _isLoading = false;
      });
      return;
    }

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 10)); // Added timeout

      if (response.statusCode == 200) {
        setState(() {
          _products = jsonDecode(response.body);
          _isLoading = false;
        });
      } else if (response.statusCode == 401) {
        // Token might be expired, handle it accordingly
        setState(() {
          errorMessage = 'Session expired. Please log in again.';
          _isLoading = false;
        });
        // Optionally log out the user
        logoutUser(context);
      } else {
        setState(() {
          errorMessage = 'Failed to fetch products: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        errorMessage = 'Error fetching products: $error';
        _isLoading = false;
      });
    }
  }

  Future<void> logoutUser(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LandingScreenPage()),
          (Route<dynamic> route) => false,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
            child: const Icon(Icons.arrow_back,color: Colors.white,)),
        backgroundColor: Colors.indigo,
        title: const Center(child: Text('Products',style: TextStyle(fontWeight: FontWeight.w900,color: Colors.white),)),actions: [GestureDetector(
        onTap: () {
          logoutUser(context);
        },
        child: Padding(
          padding:  EdgeInsets.only(right: w*0.03),
          child: Row(
            children: [
              Text("LogOut",style: TextStyle( fontWeight: FontWeight.w500,fontSize: w*0.04,color: Colors.red),),
              SizedBox(width: w*0.01
              ),
              const Icon(Icons.logout_sharp,color: Colors.red,)
            ],
          ),
        ),
      )],),
      body: _isLoading
          ? const Center(
          child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
          ? Center(child: Text(errorMessage))
          : GridView.builder(
        padding: const EdgeInsets.all(10.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final product = _products[index];
          return ProductCard(
              product:
              product);
        },
      ),
    );
  }
}


class ProductCard extends StatelessWidget {
  final dynamic product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Image.network(
              product['image'] ??
                  'https://via.placeholder.com/150', // Default image if null
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product['name'] ?? 'Unnamed Product',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '\$${product['price'] ?? 'N/A'}',
              style: const TextStyle(color: Colors.indigo),
            ),
          ),
        ],
      ),
    );
  }
}
