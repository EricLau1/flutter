import 'package:flutter/material.dart';
import './whatsapp_home.dart';

void main() => runApp(new FlutterWhatsApp());

class FlutterWhatsApp extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Flutter WhatsApp",
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primaryColor: new Color(0xff075E54),
        accentColor: new Color(0xff25D366),
      ),
      home: new WhatsAppHome(),
    );
  }
}