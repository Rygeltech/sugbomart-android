import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class cartNumber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebViewPlus(
          initialUrl: 'https://www.sugbomart.com/cart',
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
