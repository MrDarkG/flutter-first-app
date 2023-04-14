import 'package:flutter/material.dart';
import 'package:tt/pages/guest/detailedCourse.dart';
import 'package:tt/pages/home.dart';

void main() => runApp(MaterialApp(

  initialRoute: '/home',
  routes: {
    '/' : (context) => const Home(),
    '/home' : (context) => const Home(),
    // '/courses' : (context) => DetailedCourse()
  },
));
