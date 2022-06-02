import 'dart:io';

import 'package:flutter/material.dart';
import 'package:international_recipes/src/constants/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPageScreen extends StatefulWidget {
  final String website;
  const WebPageScreen({Key? key, required this.website}) : super(key: key);

  @override
  State<WebPageScreen> createState() => _WebPageScreenState();
}

class _WebPageScreenState extends State<WebPageScreen> {
  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.yellow,
          centerTitle: true,
          title: const Text('Original Website'),
        ),
        body: WebView(
          initialUrl: widget.website,
        ),
      ),
    );
  }
}
