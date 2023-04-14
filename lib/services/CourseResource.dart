import 'dart:io';
import 'package:http/http.dart';
import 'dart:convert';

class CourseResource {
  String url;
  List? courseData;

  CourseResource({required this.url});

  getToken() async {
  }
  Future<void> getData() async {
    var url = Uri.https('www.tlancer.net:5000', this.url);
    Response response = await get(url,
        headers: {HttpHeaders.authorizationHeader: getToken() });
    Map data = jsonDecode(response.body);
    courseData = data['data'];
  }
}
