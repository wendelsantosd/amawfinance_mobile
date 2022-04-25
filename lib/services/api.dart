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
        throw Exception('Error ao carregar dados do servidor');
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

  Future<dynamic> userEmailUpdate(email) async {
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

  Future<dynamic> userPasswordUpdate(password) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final id = prefs.getString('id');
      final token = prefs.getString('token');
      final url = Uri.parse('$baseURL/user/modify-password?id=$id');

      final http.Response response = await http.patch(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {'password': password},
      );

      return response.statusCode;
    } catch (e) {
      print(e.toString());
      return (e.toString());
    }
  }

  Future<dynamic> profilePictureAttach(file) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final id = prefs.getString('id');
      final token = prefs.getString('token');
      final url = Uri.parse('$baseURL/profile-picture/create?id=$id');
      Map<String, String> headers = {'Authorization': 'Bearer $token'};

      final http.MultipartRequest request = http.MultipartRequest("POST", url);

      final http.MultipartFile multipartFile =
          await http.MultipartFile.fromPath('file', file);

      request.headers.addAll(headers);
      request.files.add(multipartFile);

      final http.StreamedResponse result = await request.send();
      return result.statusCode;
    } catch (e) {
      print(e.toString());
      return (e.toString());
    }
  }

  Future<dynamic> profilePictureDelete() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final id = prefs.getString('id');
      final token = prefs.getString('token');
      final url = Uri.parse('$baseURL/profile-picture/delete?id=$id');

      final http.Response response = await http.delete(url, headers: {
        'Authorization': 'Bearer $token',
      });

      print(response.statusCode);
      return response.statusCode;
    } catch (e) {
      print(e.toString());
      return (e.toString());
    }
  }

  Future<dynamic> getTransactions(String month, String year) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final id = prefs.getString('id');
      final token = prefs.getString('token');
      final url = Uri.parse(
          '$baseURL/transaction/list-by-user-month-year?id=$id&month=$month&year=$year');

      final http.Response response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        return jsonDecode(utf8.decode(response.bodyBytes));
      } else {
        throw Exception('Error ao carregar dados do servidor');
      }
    } catch (e) {
      print(e.toString());
      return (e.toString());
    }
  }

  Future<dynamic> getTotal(String month, String year) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final id = prefs.getString('id');
      final token = prefs.getString('token');
      final url = Uri.parse(
          '$baseURL/transaction/get-total?id=$id&month=$month&year=$year');

      final http.Response response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        return jsonDecode(utf8.decode(response.bodyBytes));
      } else {
        throw Exception('Error ao carregar dados do servidor');
      }
    } catch (e) {
      print(e.toString());
      return (e.toString());
    }
  }

  Future<dynamic> createTransaction(
      String description, double amount, String type, String category) async {
    try {
      final amountConverted = amount.toString();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      final id = prefs.getString('id');
      final token = prefs.getString('token');
      final url = Uri.parse('$baseURL/transaction/create?id=$id');

      final http.Response response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          'description': description,
          'amount': amountConverted,
          'type': type,
          'category': category,
        },
      );

      return response.statusCode;
    } catch (e) {
      print(e.toString());
      return (e.toString());
    }
  }

  Future<dynamic> getTransaction(String id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('id');
      final token = prefs.getString('token');

      final url = Uri.parse(
        '$baseURL/transaction/data?id=$id&userId=$userId',
      );

      final http.Response response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Error ao carregar dados do servidor');
      }
    } catch (e) {
      print(e.toString());
      return (e.toString());
    }
  }

  Future<dynamic> updateTransaction(String id, String description,
      double amount, String type, String category) async {
    try {
      final amountConverted = amount.toString();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('id');
      final token = prefs.getString('token');
      final url =
          Uri.parse('$baseURL/transaction/update?id=$id&userId=$userId');

      final http.Response response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          'description': description,
          'amount': amountConverted,
          'type': type,
          'category': category,
        },
      );

      return response.statusCode;
    } catch (e) {
      print(e.toString());
      return (e.toString());
    }
  }

  Future<dynamic> deleteTransaction(String id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('id');
      final token = prefs.getString('token');

      final url = Uri.parse(
        '$baseURL/transaction/delete?id=$id&userId=$userId',
      );

      final http.Response response = await http.delete(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        return response.statusCode;
      } else {
        throw Exception('Error ao carregar dados do servidor');
      }
    } catch (e) {
      print(e.toString());
      return (e.toString());
    }
  }

  Future<dynamic> createNotification() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final id = prefs.getString('id');
      final token = prefs.getString('token');

      final url = Uri.parse(
        '$baseURL/notification/create?id=$id',
      );

      final http.Response response = await http.post(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 201) {
        return response.statusCode;
      } else {
        throw Exception('Error ao carregar dados do servidor');
      }
    } catch (e) {
      print(e.toString());
      return (e.toString());
    }
  }

  Future<dynamic> getNotifications(String month, String year) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final id = prefs.getString('id');
      final token = prefs.getString('token');
      final url = Uri.parse(
          '$baseURL/notification/list-by-user-month-year?id=$id&month=$month&year=$year');

      final http.Response response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        return jsonDecode(utf8.decode(response.bodyBytes));
      } else {
        throw Exception('Error ao carregar dados do servidor');
      }
    } catch (e) {
      print(e.toString());
      return (e.toString());
    }
  }
}
