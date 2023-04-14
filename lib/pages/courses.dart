import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Courses extends StatefulWidget {
  const Courses({Key? key}) : super(key: key);
  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String coursesData = '';

  @override
  void initState(){
    // TODO
    super.initState();
    getAuthToken();

  }
  getAuthToken() async {
    final SharedPreferences prefs = await _prefs;
    final String? counter = prefs.getString('token');
    setState(() {
      coursesData = counter??"";
    });
    print(counter);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(coursesData)
          ]

        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xFF8A7CEE),
      ),
    );
  }
}
