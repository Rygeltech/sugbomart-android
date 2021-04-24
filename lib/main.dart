import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sugbomart/cart.dart';
import 'package:sugbomart/home.dart';
import 'package:sugbomart/product.dart';
import 'package:sugbomart/search.dart';
import 'package:sugbomart/service.dart';
import 'cartNumber.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';
import 'package:badges/badges.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:web_scraper/web_scraper.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter_offline/flutter_offline.dart';

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
      debugShowCheckedModeBanner: false,
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




class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> with AfterLayoutMixin<MyBottomNavigationBar> {

  String txt ="zzz";

  void _getData() async {
    final response = await http.get('https://sugbomart.com/');
    dom.Document document=parser.parse(response.body);

    txt = document.getElementsByClassName('cart-count cart-badge--desktop ')[0].innerHtml.replaceAll("&nbsp;", "");
    // print(txt);

    setState(() {
      print(txt);
    });
  }

  void _getCart() async {
  }

  void showHelloWorld() {
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        content: new Text('Hello World'),
        actions: <Widget>[
          new FlatButton(
            child: new Text('DISMISS'),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }

  void afterFirstLayout(BuildContext context) {
    // Calling the same function "after layout" to resolve the issue.
    // showHelloWorld();
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
      _currentIndex= index;
    });
  }


  // WebViewPlusController _pluscontroller;
  // var cartOrder = this._pluscontroller.evaluateJavascript("var z = document.getElementsByClassName('cart-count cart-badge--desktop');");

  Future<bool> _onBackPressed(){
    return showDialog(
        context: context,
        builder: (context)=>AlertDialog(
          title: Text("Do you really want to exit SugboMart App?"),
          actions: <Widget>[
            TextButton(
              child: Text("No"),
              onPressed: ()=>Navigator.pop(context, false),
            ),
            TextButton(
              child: Text("Yes"),
              onPressed: ()=>Navigator.pop(context, true),
            ),
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: new Scaffold(
           body: SafeArea(
             child: _children[_currentIndex],
           ),
          // Builder(
          //   builder: (BuildContext context) {
          //     return OfflineBuilder(
          //       connectivityBuilder: (BuildContext context,
          //           ConnectivityResult connectivity, Widget child) {
          //         final bool connected =
          //             connectivity != ConnectivityResult.none;
          //         return Stack(
          //           fit: StackFit.expand,
          //           children: [
          //             child,
          //             Positioned(
          //               left: 0.0,
          //               right: 0.0,
          //               height: 24.0,
          //               child: AnimatedContainer(
          //                 duration: const Duration(milliseconds: 2000),
          //                 color:
          //                 connected ? Color(0xFF00EE44) : Color(0xFF872E0C),
          //                 child: connected
          //                     ?  Row(
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   children: <Widget>[
          //                     Text(
          //                       "ONLINE",
          //                       style: TextStyle(color: Colors.white,fontSize: 20.0),
          //                     ),
          //                     SizedBox(
          //                       width: 12.0,
          //                     ),
          //                   ],
          //                 )
          //                     : Row(
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   children: <Widget>[
          //                     Text(
          //                       "OFF LINE",
          //                       style: TextStyle(color: Colors.white,fontSize: 20.0),
          //                     ),
          //                     SizedBox(
          //                       width: 10.0,
          //                     ),
          //                     SizedBox(
          //                       width: 10.0,
          //                       height: 10.0,
          //                       child: CircularProgressIndicator(
          //                         strokeWidth: 2.0,
          //                         valueColor:
          //                         AlwaysStoppedAnimation<Color>(
          //                             Colors.white),
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //           ],
          //         );
          //       },
          //       child: Center(
          //         child: _children[_currentIndex],
          //       ),
          //     );
          //   },
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
            ],
          )
      ),
    );


    //_children[_currentIndex],

  }


  void _readJS(BuildContext html) async{
    var html = await _pluscontroller.evaluateJavascript("document.getElementsByClassName('cart-count cart-badge--desktop')[0].innerHTML");
    print('${html}');
  }

}


