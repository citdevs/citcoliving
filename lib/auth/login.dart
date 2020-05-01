import 'dart:convert';

import 'package:costlivingapp/pages/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:costlivingapp/models/authapi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  var phone;
  var password;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _showMsg(msg){
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'ປິດ',
        onPressed: (){

        },
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  bool _passShowHidden;
  @override
  void initState() {
    _passShowHidden = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      key: _scaffoldKey,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('images/logo.png', height: 120, width: 120),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('ເຂົ້າລະບົບ ລາຍຮັບ - ລາຍຈ່າຍ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.smartphone),
                          border: OutlineInputBorder(),
                          labelText: 'ເບີໂທລະສັບ: 20xxxxxxxx'
                        ),
                        validator: (phoneValue){
                          if(phoneValue.isEmpty){
                            return 'ກະລຸນາໃສ່ເບີ້ໂທກ່ອນ!';
                          }
                          phone = phoneValue;
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        obscureText: _passShowHidden,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(_passShowHidden ? Icons.visibility : Icons.visibility_off, color: Colors.green),
                              onPressed: (){
                                setState(() {
                                  _passShowHidden = !_passShowHidden;
                                });
                              },
                            ),
                            border: OutlineInputBorder(),
                            labelText: 'ລະຫັດຜ່ານ'
                        ),
                        validator: (passwordValue){
                          if(passwordValue.isEmpty){
                            return 'ກະລຸນາໃສ່ລະຫັດກ່ອນ!';
                          }
                          password = passwordValue;
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FlatButton(
                        child: Text(_isLoading ? 'ກຳລັງເຂົ້າລະບົບ...' : 'ເຂົ້າລະບົບ', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, decoration: TextDecoration.none)),
                        color: Colors.blue,
                        disabledColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),
                        onPressed: (){
                          if(_formKey.currentState.validate()){
                            _login();
                          }
                        }
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, '/register-page');
                  },
                    child: Text('ລົງທະບຽນໃໝ່', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
              ),
            )
          ],
        ),
      ),
    );
  }
  void _login() async{
    setState(() {
      _isLoading = true;
    });
    var data = {
      'phone' : phone,
      'password' : password
    };

    var res = await Authapi().authData(data, '/login');
    var body = json.decode(res.body);
    if(body['success']){
      SharedPreferences store = await SharedPreferences.getInstance();
      store.setString('token', json.encode(body['token']));
      store.setString('user', json.encode(body['user']));
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => DashboardPage()
      ));
    }else{
      _showMsg(body['message']);
    }

    setState(() {
      _isLoading = false;
    });
  }

}
