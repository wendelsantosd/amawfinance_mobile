import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  final String baseURL = 'http://192.168.1.8:3333';

  Future<dynamic> login(email, password) async {
    try {
      final url = Uri.parse(
        '$baseURL/user/auth',
      );

      final http.Response response = await http.post(url, body: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        print(response.body);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        dynamic parse = jsonDecode(response.body);

        await prefs.setString('token', parse['token']);
        await prefs.setString('id', parse['id']);

        return response.statusCode;
      } else if (response.statusCode == 401 || response.statusCode == 404) {
        return response.statusCode;
      } else {
        return 'Ocorreu um erro';
      }
    } catch (e) {
      print(e.toString());
      return (e.toString());
    }
  }

  Future<dynamic> googleLogin(idToken, name) async {
    try {
      final url = Uri.parse(
        '$baseURL/user/google-auth',
      );

      final http.Response response = await http.post(url, body: {
        'idToken': idToken,
        'name': name,
        'isMobile': 'true',
      });

      if (response.statusCode == 200) {
        print(response.body);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        dynamic parse = jsonDecode(response.body);

        await prefs.setString('token', parse['token']);
        await prefs.setString('id', parse['id']);

        return response.statusCode == 200;
      } else {
        return 'Ocorreu um erro';
      }
    } catch (e) {
      print(e.toString());
      return (e.toString());
    }
  }
}
