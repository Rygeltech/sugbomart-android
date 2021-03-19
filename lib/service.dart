import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

class service extends StatefulWidget {
  @override
  _serviceState createState() => _serviceState();
}

class _serviceState extends State<service> {
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: globalKey,
      // appBar: new AppBar(
      //   title: new Text("Service Page"),
      // ),
      body: SafeArea(
        child: WebView(
          initialUrl: 'https://sugbomart.com/collections/services',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController){
            _controller.complete(webViewController);
          },
          navigationDelegate: (request) {
            return _buildNavigationDecision(request);
          },
        ),
      ),
    );
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
