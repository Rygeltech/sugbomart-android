import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';
import 'package:after_layout/after_layout.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AfterLayoutMixin<Home> {

  Future<void> _launched;
  String _phone = '';


  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }


  // Future<void> _launchInWebViewOrVC(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(
  //       url,
  //       forceSafariVC: true,
  //       forceWebView: true,
  //       headers: <String, String>{'my_header_key': 'my_header_value'},
  //     );
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  // Future<void> _launchInWebViewWithJavaScript(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(
  //       url,
  //       forceSafariVC: true,
  //       forceWebView: true,
  //       enableJavaScript: true,
  //     );
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  // Future<void> _launchInWebViewWithDomStorage(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(
  //       url,
  //       forceSafariVC: true,
  //       forceWebView: true,
  //       enableDomStorage: true,
  //     );
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  // Future<void> _launchUniversalLinkIos(String url) async {
  //   if (await canLaunch(url)) {
  //     final bool nativeAppLaunchSucceeded = await launch(
  //       url,
  //       forceSafariVC: false,
  //       universalLinksOnly: true,
  //     );
  //     if (!nativeAppLaunchSucceeded) {
  //       await launch(
  //         url,
  //         forceSafariVC: true,
  //       );
  //     }
  //   }
  // }

  // Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
  //   if (snapshot.hasError) {
  //     return Text('Error: ${snapshot.error}');
  //   } else {
  //     return const Text('');
  //   }
  // }

  // Future<void> _makePhoneCall(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  final globalKey = GlobalKey<ScaffoldState>();
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  WebViewPlusController _pluscontroller;/*declaration for WebViewPlusController*/
  String html ="zzzz";

  @override
  Widget build(BuildContext html) {
    return new Scaffold(
      key: globalKey,
      // appBar: new AppBar(
      //   title: new Text('${html}'),
      // ),
      body: SafeArea(
        child: WebViewPlus(
          initialUrl: 'https://sugbomart.com/',
          javascriptMode: JavascriptMode.unrestricted,
          gestureNavigationEnabled: true,
          onWebViewCreated: (WebViewController webViewController){
            _controller.complete(webViewController);
            this._pluscontroller = webViewController;
          },


          /*Ari mo gawas ang Updated Output sa Webview Sir*/
          onPageFinished: (String url) {
            // var thingtoRemove = "document.querySelecto rAll('.messengermessageus--fixed facebook-message-us-button')[0];";
            // _controller.evaluateJavascript("document.querySelector('#messageus_button > img.messageus_unhovered')[0].style.display = 'none';");
            // _controller.evaluateJavascript("document.querySelector('#messageus_button > img.messageus_hovered')[0].style.display = 'none';");
            // this._pluscontroller.evaluateJavascript("var z = document.getElementsByClassName('cart-count cart-badge--desktop');"
            //     // "document.getElementsByClassName('h1  section-header--left')[0].innerHTML = z[0].innerHTML;"
            // );
            // _z = _pluscontroller.evaluateJavascript("var z");
            print(html);
          },
          navigationDelegate: (request) {
            return _buildNavigationDecision(request);
          },
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){
      //     readJS(html);
      //   },
      //   child: Text(
      //     '${html}',
      //   ),
      // ),
    );
  }

  void afterFirstLayout(BuildContext context) {
    // Calling the same function "after layout" to resolve the issue.
    _readJS();
  }

  /*Function ni para sa pag output sa cartNumber*/
  void _readJS() async{
    html = await _pluscontroller.evaluateJavascript("document.getElementsByClassName('cart-count cart-badge--desktop')[0].innerHTML");
    print(html);

    setState(() {
      print(html);
    });
  }

  NavigationDecision _buildNavigationDecision(NavigationRequest request) {
    const String toLaunch = 'https://www.messenger.com/t/104467195013003/?ref=messenger_commerce_1163199097047119_https%3A%2F%2Fsugbomart.com%2F&messaging_source=source%3Apages%3Amessage_shortlink';
    if(request.url.contains('messenger')){
      globalKey.currentState.showSnackBar(
        SnackBar(
          content: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue[800]),
              ),
              onPressed: () => setState(() {
                _launched = _launchInBrowser(toLaunch);
              }),
              child: Text(
                'Launch app',
                style: TextStyle(
                  fontSize: 13.0,
                  letterSpacing: 2.0,
                  color: (Colors.white),
                ),
              )
          ),
        ),
      );
      return NavigationDecision.prevent;
    }
    return NavigationDecision.navigate;
  }
}