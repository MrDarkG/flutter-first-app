import 'package:flutter/material.dart';
import 'package:tt/pages/home.dart';
import 'package:tt/pages/loading.dart';
import 'package:tt/pages/courses.dart';

void main() => runApp(MaterialApp(

  initialRoute: '/home',
  routes: {
    '/' : (context) => Loading(),
    '/home' : (context) => Home(),
    '/courses' : (context) => Courses()
  },
));
