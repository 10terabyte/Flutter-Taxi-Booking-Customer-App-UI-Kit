import 'dart:async';

import 'package:flutter/material.dart';
import 'package:com_basoft_customer_ba/app_router.dart';
import 'package:com_basoft_customer_ba/theme/style.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsConditionsScreen extends StatefulWidget {
  @override
  _TermsConditionsScreenState createState() => _TermsConditionsScreenState();
}

class _TermsConditionsScreenState extends State<TermsConditionsScreen> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  final _key = UniqueKey();
  int indexStack = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.of(context).pushReplacementNamed(AppRoute.homeScreen);
          },
        ),
      ),
      body: IndexedStack(
        index: indexStack,
        children: <Widget>[
          // WebView(
          //   key: _key,
          //   initialUrl: 'https://flutter.dev/tos',
          //   javascriptMode: JavascriptMode.unrestricted,
          //   onWebViewCreated: (WebViewController webViewController) {
          //     _controller.complete(webViewController);
          //   },
          //   onPageFinished: (String value){
          //     setState(() {
          //       indexStack = 0;
          //     });
          //   },
          // ),
          Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
            ),
          )
        ],
      ),
    );
  }
}
