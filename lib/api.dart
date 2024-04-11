import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

var URL_API = 'shift.naliv.kz';

Future<bool> login(String token) async {
  var url = Uri.https(URL_API, '/api/employee/login.php');
  var response = await http.post(
    url,
    body: json.encode({'token': token}),
    headers: {"Content-Type": "application/json"},
  );
  var data = jsonDecode(response.body);
  // print(response.statusCode);
  print(response.body);
  if (response.statusCode == 202) {
    final prefs = await SharedPreferences.getInstance();
    setToken(data);

    return true;
  } else {
    return false;
  }
  return false;
}

Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token') ?? null;
  print(123);

  print(token);
  return token;
}

Future<bool> setToken(Map data) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', data['token']);
  final token = prefs.getString('token') ?? false;
  print(token);
  return token == false ? false : true;
}

Future<Map> enroll(String token) async {
  String? token = await getToken();
  if (token != null) {
    var url = Uri.https(URL_API, '/api/employee/enroll.php');
    var response = await http.post(
      url,
      body: json.encode({'token': token}),
      headers: {"Content-Type": "application/json", "AUTH": token},
    );
    var data = jsonDecode(response.body);
    print(data);
    print(token);
    return data;
  }

  return {};
}



Future<Map?> attend(String operation, String shift_id) async {
  String? token = await getToken();
  if (token != null) {
    var url = Uri.https(URL_API, '/api/employee/attend.php');
    var response = await http.post(
      url,
      body: json.encode({'operation': operation, 'shift_id':shift_id}),
      headers: {"Content-Type": "application/json", "AUTH": token},
    );
    var data = jsonDecode(response.body);
    print(data);
    print(token);
    return data;
  }

  return {};
}