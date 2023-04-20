import 'package:flutter/material.dart';
import 'package:tt/pages/guest/detailedCourse.dart';
import 'package:tt/pages/home.dart';
import 'package:tt/pages/user/UserDashboard.dart';

void main() => runApp(MaterialApp(

  initialRoute: '/home',
  routes: {
    '/' : (context) => const Home(),
    '/home' : (context) => const Home(),
    '/user/courses' : (context) => const UserDashboard(),
    // '/courses' : (context) => DetailedCourse()
  },
));
