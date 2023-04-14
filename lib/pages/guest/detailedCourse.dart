import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class DetailedCourse extends StatefulWidget {
  final int todos;
  const DetailedCourse({super.key, required this.todos});

  @override
  State<DetailedCourse> createState() => _DetailedCourseState();
}

class _DetailedCourseState extends State<DetailedCourse> {

  String courseName = "Tlancer";
  int courseId = 0;
  List<dynamic> productMap = [];
  bool showData = false;
  String startDate = "";
  String endDate = "";
  get events => [];
  getData(){
    setState(() {
      courseId = widget.todos;
    });
    getCourses(courseId);
  }
  Map e = {};
  getAvatarImage(param) {
    if (param == "" || param == null) {
      return const CircleAvatar(
        backgroundImage: NetworkImage(
            'https://tlancer.net/assets/media/student-section-home-page/bg-removebg-preview%201.png'),
      );
    } else if (param.endsWith('.svg')) {
      return Container(
        height: 42.0,
        width: 42.0,
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
          color: Color(0xFF8A7CEE),
        ),
        child: SvgPicture.network(
          'https://tlancer.net:5000/images/avatars/$param',
          semanticsLabel: 'Tlancer',
        ),
      );
    }
    return CircleAvatar(
      backgroundImage: NetworkImage(param),
    );
  }
  getBodyImage(param) {
    if (param == null || param == '') {
      return SizedBox(height: 4);
    }
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 300, maxWidth: double.infinity),
      child: Image(
        image: NetworkImage('https://tlancer.net:5000' + param),
        fit: BoxFit.cover,
      ),
    );
  }
  Widget _getBody() {
    // var e = productMap[0];
    if(showData) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            //set border radius more than 50% of height and width to make circle
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              ListTile(
                leading: getAvatarImage(e['user']['avatar']),
                title: Text(e['title']),
                subtitle: Text(
                  e['user']['first_name'] + " " + e['user']['last_name'],
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
                trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.share),
                ),
              ),
              getBodyImage(e['image']),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  e['description'],
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ButtonBar(
                  alignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(e['price'].toString() + ' ₾'),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailedCourse(todos:e['id']),
                          ),
                        );
                      },
                      icon: Icon(Icons.monetization_on_outlined),
                      color: Color(0xFF8A7CEE),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TableCalendar(
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: DateTime.now(),
                  rangeStartDay: DateTime.parse(startDate),
                  rangeEndDay: DateTime.parse(endDate),
                ),
              )
            ],

          ),
        ),
      );
    }
    return Text('No data found');

  }
  getCourses(int CourseId) async {
    String url =
        "http://demo.api.tlancer.net/api/courses/search?id=${CourseId}";
    print(url);
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    var courseData = data['data'];
    setState(() {
      productMap = courseData;
    });
    if(productMap.length > 0){
      setState(() {
        e = productMap[0];
        showData = true;
        courseName = e['title'];
        if(e['course_date'].length > 1){
          startDate = e['course_date'][0]['course_date'];
          endDate = e['course_date'].last['course_date'];
        }
      });
    }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(courseName),
        backgroundColor: Color(0xFF8A7CEE),
      ),
      body: SingleChildScrollView(
        child: _getBody(),
      )
      );
  }
}

