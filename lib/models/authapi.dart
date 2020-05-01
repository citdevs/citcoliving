import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Authapi {
  String serverUrl = "http://192.168.0.13:8000/api/";
  var token;

  _getToken() async {
    SharedPreferences store = await SharedPreferences.getInstance();
    token = jsonDecode(store.getString('token'))['token'];
  }

  authData(data, apiUrl) async {
    var fullUrl = serverUrl + apiUrl;
    return await http.post(
        fullUrl,
        body: jsonEncode(data),
        headers: _setHeaders());
  }

  getData(apiUrl) async {
    var fullUrl = serverUrl + apiUrl;
    await _getToken();
    return await http.get(
        fullUrl,
        headers: _setHeaders());
  }

  _setHeaders() => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
}
