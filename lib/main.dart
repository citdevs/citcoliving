import 'dart:convert';

import 'package:costlivingapp/auth/login.dart';
import 'package:costlivingapp/auth/register.dart';
import 'package:costlivingapp/pages/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      routes: <String, WidgetBuilder>{
        '/login-page': (context) => LoginPage(),
        '/register-page': (context) => RegisterPage(),
        '/dashboard-page': (context) => DashboardPage()
      },
    );
  }
}
