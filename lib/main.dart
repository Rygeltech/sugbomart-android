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
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:web_scraper/web_scraper.dart';

void main() {
  runApp(MyApp());

  // final response = await http.Client().get(Uri.parse('https://sugbomart.com/'));
  //
  //   var document = parse(response.body);
  //   var element = document.getElementsByClassName('cart-count cart-badge--desktop')[0].innerHtml;
  // //   // var link = document.getElementsByClassName('cart-count cart-badge--desktop')[0].children[0];
  // //   // var text = link.text;
  //   var link = element;
  //   print(link);
  // }
  // else{
  //   throw Exception();

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

class cartNumber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}




class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {

  String txt ="zzz";
  void _getData() async {
    final response = await http.get('https://sugbomart.com/');
    dom.Document document=parser.parse(response.body);

    txt = document.getElementsByClassName('cart-count cart-badge--desktop')[0].innerHtml.replaceAll("&nbsp;", "");
    print(txt);

    setState(() {
      print(txt);
    });
  }



  WebViewPlusController _pluscontroller;/*declaration for WebViewPlusController*/
  int _currentIndex = 0;
  final List<Widget> _children = [
    Home(),
    product(),
    service(),
    search(),
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){
      //     _getData();
      //   },
      //   child: Icon(Icons.refresh),
      // ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.red,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.blue[300],
        selectedLabelStyle: TextStyle(color: Colors.blue[200]),
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
          // BottomNavigationBarItem(
          //   icon: new Badge(
          //     badgeContent: Text('${txt}',style: TextStyle(color: Colors.white),),
          //     badgeColor: Colors.blue,
          //     child: Icon(Icons.shopping_cart),
          //   ),
          //   label: "Cart",
          // ),
          // BottomNavigationBarItem(
          //   icon: new Icon(Icons.account_balance_wallet),
          //   label: "Search",
          // ),
        ],
      ),
    );
  }

  void _readJS(BuildContext html) async{
    var html = await _pluscontroller.evaluateJavascript("document.getElementsByClassName('cart-count cart-badge--desktop')[0].innerHTML");
    print('${html}');
  }

}


