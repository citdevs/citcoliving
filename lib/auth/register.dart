import 'dart:convert';
import 'package:costlivingapp/models/authapi.dart';
import 'package:costlivingapp/pages/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  bool _passShowHidden;

  @override
  void initState() {
    _passShowHidden = true;
    super.initState();
  }

  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  var name;
  var phone;
  var password;
  var email;
  var address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
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
                    /*
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('images/logo.png', height: 120, width: 120),
                    ),
                     */
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('ລົງທະບຽນໃໝ່', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.people),
                            border: OutlineInputBorder(),
                            labelText: 'ຊື່ ແລະ ນາມສະກຸນ'
                        ),
                        validator: (firstname){
                          if(firstname.isEmpty){
                            return 'ກະລຸນາໃສ່ຊື່ ແລະ ນາມສະກຸນກ່ອນ!';
                          }
                          name = firstname;
                          return null;
                        },
                      ),
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
                        validator: (passValue){
                          if(passValue.isEmpty){
                            return 'ກະລຸນາໃສ່ລະຫັດກ່ອນ!';
                          }
                          password = passValue;
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(),
                            labelText: 'ທີ່ຢູ່ Email'
                        ),
                        validator: (emailValue){
                          if(emailValue.isEmpty){
                            return 'ກະລຸນາໃສ່ Email ກ່ອນ!';
                          }
                          email = emailValue;
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.list),
                            border: OutlineInputBorder(),
                            labelText: 'ທີຢູ່ບ້ານ, ເມືອງ, ແຂວງ'
                        ),
                        validator: (addressValue){
                          if(addressValue.isEmpty){
                            return 'ກະລຸນາໃສ່ທີ່ຢູ່ກ່ອນ!';
                          }
                          address = addressValue;
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FlatButton(
                        child: Text(_isLoading? 'ກຳລັງລົງທະບຽນ...' : 'ລົງທະບຽນ', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, decoration: TextDecoration.none)),
                        color: Colors.blue,
                        disabledColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                        ),
                        onPressed: (){
                          if(_formKey.currentState.validate()){
                            _register();
                          }
                        },
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
                      Navigator.pushNamed(context, '/login-page');
                    },
                    child: Text('ມີບັນຊີຜູ້ໃຊ້ແລ້ວ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
              ),
            )
          ],
        ),
      ),
    );
  }
  void _register() async{
    setState(() {
      _isLoading = true;
    });

    var data = {
      'name' : name,
      'phone': phone,
      'email': email,
      'password': password,
      'address': address
    };

    var res = await Authapi().authData(data, '/register');
    var body = json.decode(res.body);
    print(body['message']);
    if(body['success']){
      SharedPreferences store = await SharedPreferences.getInstance();
      store.setString('token', json.encode(body['token']));
      store.setString('user', json.encode(body['user']));
      Navigator.push(context, MaterialPageRoute(builder: (context)=> DashboardPage()));
    }
    setState(() {
      _isLoading = false;
    });
  }
}
