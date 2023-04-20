import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String errors = '';

  void initState() {
    // checkIfUserIsGuest();
  }

  storeToken(String token) async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      var _counter = prefs.setString('token', token)
          .then((bool success) {
          return token;
        });
    });
  }
  storeUser(Map user) async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      var name = prefs.setString('token', user['first_name'])
          .then((bool success) {
        return user;
      });
      var lastName = prefs.setString('token', user['last_name'])
          .then((bool success) {
        return user;
      });
      var avatar = prefs.setString('token', user['avatar'])
          .then((bool success) {
        return user;
      });

    });
  }
  grabUserData(token) async {
    var url = Uri.https('www.tlancer.net:5000', '/api/user');
    Response response = await post(url,
        headers: {HttpHeaders.acceptHeader: 'application/json', HttpHeaders.authorizationHeader: token});
    Map respData = jsonDecode(response.body);
    storeUser(respData);
    print(respData);
  }
  login() async {
    Map data = {'email': email.text, 'password': password.text};
    var url = Uri.https('www.tlancer.net:5000', '/api/login');
    Response response = await post(url,
        body: data, headers: {HttpHeaders.acceptHeader: 'application/json'});
    Map respData = jsonDecode(response.body);
    if (respData.containsKey('token')) {
      String Bearer = 'Bearer ' + respData['token'];
      storeToken(Bearer);
      setState(() {
        errors = '';
      });
      Navigator.pushNamed(context, '/user/courses');
      grabUserData(Bearer);
    }

    if (respData.containsKey('message')) {
      setState(() {
        errors = respData['message'];
      });
    }
    if(response.statusCode == 401){
      print(respData);
      setState(() {
        errors = respData['error'];
      });
    }
  }

  getToken() async {
    final SharedPreferences prefs = await _prefs;
    final String? counter = prefs.getString('token');
  }

  checkIfUserIsGuest() async {
    final SharedPreferences prefs = await _prefs;
    final String? counter = prefs.getString('token');
    if (counter != null) {
      Navigator.pushNamed(context, '/courses');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 150, horizontal: 0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 26.0),
        child: Column(
          children: [
            TextField(
              controller: email,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              obscureText: true,
              controller: password,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF8A7CEE),
                minimumSize: const Size.fromHeight(50), // NEW
              ),
              onPressed: () {
                login();
                getToken();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Login',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                  )
                ],
              ),
            ),
            const SizedBox(height: 12),

            Text(errors, style: TextStyle(color: Colors.red))
          ],
        ),
      ),
    );
  }
}
