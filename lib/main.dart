import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_sugbomart_v1/cart.dart';
import 'package:flutter_page_sugbomart_v1/home.dart';
import 'package:flutter_page_sugbomart_v1/product.dart';
import 'package:flutter_page_sugbomart_v1/search.dart';
import 'package:flutter_page_sugbomart_v1/service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: MyBottomNavigationBar(),
    );
  }
}





class MyBottomNavigationBar extends StatefulWidget {
  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}



class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {



  int _currentIndex = 0;
  final List<Widget> _children = [
    Home(),
    product(),
    service(),
    search(),
    cart(),
  ];

  void onTappedBar(int index)
  {
    setState(() {
      _currentIndex = index;
    });
  }

  int cartOrder = 0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTappedBar,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.food_bank),
            label: "Products",
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.handyman),
            label: "Services",
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.shopping_cart),
            label: "Cart" + "$cartOrder",
          ),
        ],
      ),
    );
  }
}


