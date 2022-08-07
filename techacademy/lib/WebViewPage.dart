import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:techacademy/control.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({Key? key}) : super(key: key);
  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {

  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }
  late WebViewController _controller;

  final Completer<WebViewController> _controllerCompleter =
  Completer<WebViewController>();


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        if (await _controller.canGoBack()) {
          _controller.goBack();
          return Future.value(false);
        } else {
          AwesomeDialog(
            btnOk: InkWell(
              onTap: () {
                SystemNavigator.pop();
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(7)),
                child: Text(
                  language() == "ar" ? "الخروج" : "exit",
                  style: const TextStyle(
                      fontFamily: "font", fontSize: 15, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            btnCancel: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(7)),
                child: Text(
                  language() == "ar" ? "الغاء" : "cancel",
                  style: const TextStyle(
                      fontFamily: "font", fontSize: 15, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            context: context,
            dialogType: DialogType.WARNING,
            animType: AnimType.BOTTOMSLIDE,
            body: Column(
              children: [
                Text(
                  language() == "ar" ? "مغادرة التطبيق" : "Leave the app",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20, fontFamily: "font"),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    language() == "ar" ? "هل تريد فعلا الخروج من التطبيق ?" : "Do you really want to exit the app ?",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontFamily: "font", fontSize: 13),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ).show();
          return Future.value(true);
        }
      },
      child: Scaffold(body: SafeArea(
        child: WebView(
          initialUrl: urlWeb(),
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controllerCompleter.future.then((value) => _controller = value);
            _controllerCompleter.complete(webViewController);
          },
        ),
      ),),
    );
  }
}
