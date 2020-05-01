import 'dart:convert';

import 'package:costlivingapp/auth/login.dart';
import 'package:costlivingapp/models/authapi.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  String phone;

  @override
  void initState() {
    _loadUserData();
    super.initState();
  }

  _loadUserData() async{
    SharedPreferences store = await SharedPreferences.getInstance();
    var user = jsonDecode(store.getString('user'));

    if(user != null){
      setState(() {
        phone = user['phone'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Dashboard: ${phone}'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.power_settings_new, color: Colors.white),
            onPressed: (){
              logout();
            },
          )
        ],
      ),
    );
  }

  void logout() async{
    var res = await Authapi().getData('/logout');
    var body = json.decode(res.body);
    if(body['success']){
      SharedPreferences store = await SharedPreferences.getInstance();
      store.remove('user');
      store.remove('token');
      Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage())
      );
    }
  }
}


