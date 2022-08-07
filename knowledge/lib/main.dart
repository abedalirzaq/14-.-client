import 'package:flutter/material.dart';
import 'package:knowledge/WebViewPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: WebViewPage(),
  ));
}
