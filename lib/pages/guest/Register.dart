import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirm_password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController surname = TextEditingController();
  String errors = '';

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 50, horizontal: 0),
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
              controller: name,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: surname,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Surname',
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
            TextField(
              obscureText: true,
              controller: confirm_password,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Repeat Password',
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF8A7CEE),
                minimumSize: const Size.fromHeight(50), // NEW
              ),
              onPressed: () {
                //register function
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Register',
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

            Text(errors, style: const TextStyle(color: Colors.red))
          ],
        ),
      ),
    );
  }
}
