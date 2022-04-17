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
        SharedPreferences prefs = await SharedPreferences.getInstance();
        dynamic parse = jsonDecode(response.body);

        await prefs.setString('token', parse['token']);
        await prefs.setString('id', parse['id']);

        return response.statusCode;
      } else {
        return response.statusCode;
      }
    } catch (e) {
      print(e.toString());
      return (e.toString());
    }
  }

  Future<dynamic> register(name, email, password) async {
    try {
      final url = Uri.parse(
        '$baseURL/user/create',
      );

      final http.Response response = await http.post(url,
          body: {'name': name, 'email': email, 'password': password});

      return response.statusCode;
    } catch (e) {
      print(e.toString());
      return (e.toString());
    }
  }

  Future<dynamic> recoverPassword(email) async {
    try {
      final url = Uri.parse(
        '$baseURL/user/recover-password?email=$email',
      );

      final http.Response response = await http.get(url);

      return response.statusCode;
    } catch (e) {
      print(e.toString());
      return (e.toString());
    }
  }

  Future<dynamic> userData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final id = prefs.getString('id');
      final token = prefs.getString('token');

      final url = Uri.parse(
        '$baseURL/user/data?id=$id',
      );

      final http.Response response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return 'Ocorreu um erro';
      }
    } catch (e) {
      print(e.toString());
      return (e.toString());
    }
  }

  Future<dynamic> userUpdate(name, phone) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final id = prefs.getString('id');
      final token = prefs.getString('token');
      final url = Uri.parse('$baseURL/user/update?id=$id');

      final http.Response response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          'name': name,
          'phone': phone,
        },
      );

      return response.statusCode;
    } catch (e) {
      print(e.toString());
      return (e.toString());
    }
  }

  Future<dynamic> emailUserUpdate(email) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final id = prefs.getString('id');
      final token = prefs.getString('token');
      final url = Uri.parse('$baseURL/user/modify-email?id=$id&email=$email');

      final http.Response response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
      });

      return response.statusCode;
    } catch (e) {
      print(e.toString());
      return (e.toString());
    }
  }
}
