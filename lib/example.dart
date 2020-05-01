import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:costlivingapp/pages/dashboard.dart';
import 'package:http/http.dart' as http;

void main() async{

  //loginData();
  //registerData();
  logoutData();

  runApp(MaterialApp(
    title: 'Test API',
    home: Scaffold(
      appBar: AppBar(
        title: Text('Hello'),
      ),
    ),
  ));
}

void loginData(){
  String myUrl = "http://192.168.10.239:8000/api/login";
  http.post(myUrl,
      headers:{
        'Accept': 'application/json'
      },
      body: {
        'email': 'user@gmail.com',
        'password': '12345678',
      }).then((response){
    print('Status: ${response.statusCode}');
    print('Body: ${response.body}');

    Map mapValue = json.decode(response.body);
    print('Token: ${mapValue.values.toString()}');
  });
}

void registerData(){
  String myUrl = "http://192.168.10.239:8000/api/register";
  http.post(myUrl,
      headers:{
        'Accept':'application/json'
      },
      body: {
        'name': 'user',
        'email': 'user@gmail.com',
        'password': '12345678',
        'phone': '02058189998',
        'address': 'ຕານມີໄຊ'
      }).then((response){
    print('Status: ${response.statusCode}');
    print('Body: ${response.body}');
  });
}

void logoutData(){
  String myUrl = "http://192.168.10.239:8000/api/logout";
  http.get(myUrl,
      headers:{
        'Accept':'application/json',
        'Authorization': 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZTczNDY5NWM3OThhYmJiMDdhOWI5MDgzYTg5MTI3OTU0YWNkODdiMTZiZDA3MjhlZWZiYTU2NjU5MmE4YzdkNTg0MDk4NzNkNzg1ZjliZTgiLCJpYXQiOjE1ODc0MzUxNzksIm5iZiI6MTU4NzQzNTE3OSwiZXhwIjoxNjE4OTcxMTc5LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.rB5CieUeQ38bL1auYMvjehvouJIuV3jmsbqdfNNjj2AyS6bhjkVcOj8I2oRHVu6mO70QOzpMvX2whFnCldk4v3zRZI6R1AopiJsFPAdFjz7GvxOnuMAQz6dh1SF8-fi95OVhT1UwHRLwv3JDsKBXqeDQI2-6ACkmoExLs-r1-87Ensnxu568S-VGey2NdyhDIxMuEUGGTr37suJRNVX9595zbcYePMoMlNx6FaD5KWE45RgDt1aW0lh4Gg4kdTaWyNWHMiWMAEDG1n4UeLgg6XyBzCAQtibTGTjEQYDCabdiDx3wLv7vqzWyU_XnVAt79EBVTLkBKcP7OpNrJPusn_dwpiNNKjWiuueE1xeRbkrDf5YiF8_XEHmiiISrgK6hM9fkz3wQrGcGvB2MWBvUQ92FndhDqe6EIMLT-2EKQlUOoqgdZxXfe9Whi05bktqX1Deyoq7cswt23YnFDFFUX7QeV_KgScCJ3HHwmNZNxZq43nGk_fsuV3d1dfgnfp0u6MZhGU5EYyd4qN7yItw93MiGv3APLbCdiZxzDx1EW0wtfhGQAOe_05zlbJcWwd9QDe8tThilUjFEc-04tR-LST3L0uIIGryrRkXb5hO9mKaYW2KFnyb8XSa64mFMMixwsn64HYqnhEi_2yiylMfBq5uptbTzKfjxWZWZBuhpeH8',
      }).then((response){
    print('Status: ${response.statusCode}');
    print('Body: ${response.body}');
  });
}
