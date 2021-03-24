import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_sugbomart_v1/cart.dart';
import 'package:flutter_page_sugbomart_v1/home.dart';
import 'package:flutter_page_sugbomart_v1/product.dart';
import 'package:flutter_page_sugbomart_v1/search.dart';
import 'package:flutter_page_sugbomart_v1/service.dart';
import 'cartNumber.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';
import 'package:badges/badges.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

void main()  {
  runApp(MyApp());

  // final response = await http.Client().get(Uri.parse('https://sugbomart.com/'));
  // if(response.statusCode == 200){
  //   var document = parse(response.body);
  //   var element = document.getElementsByClassName('cart-count cart-badge--desktop hidden-count')[0].parent;
  //   // var link = document.getElementsByClassName('cart-count cart-badge--desktop')[0].children[0];
  //   // var text = link.text;
  //   var link = element.text;
  //   print(link);
  // }
  // else{
  //   throw Exception();
  // }
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



  // WebViewPlusController _pluscontroller;
  // var cartOrder = this._pluscontroller.evaluateJavascript("var z = document.getElementsByClassName('cart-count cart-badge--desktop');");

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.red,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.grey,
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
            icon: new Badge(
              badgeContent: Text('1',style: TextStyle(color: Colors.white),),
              badgeColor: Colors.blue,
              child: Icon(Icons.shopping_cart),
            ),
            label: "Cart",
          ),
        ],
      ),
    );
  }
}


