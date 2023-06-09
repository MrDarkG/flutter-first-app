import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tt/pages/guest/detailedCourse.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Courses extends StatefulWidget {
  const Courses({Key? key}) : super(key: key);

  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void initState() {
    // TODO
    super.initState();
    getCourses();
    _getPagination;
  }


  List<dynamic> productMap = [];
  int lastPage = 1;
  int current_page = 1;

  String generateQuery() {
    return "?page=$current_page";
  }
  Future<void> printToken() async {
    final SharedPreferences prefs = await _prefs;
    print(prefs.getString('token'));
  }
  getCourses() async {
    String url =
        "http://demo.api.tlancer.net/api/courses/search${generateQuery()}";
    try {
      Response response = await get(Uri.parse(url));
      Map data = jsonDecode(response.body);
      var courseData = data['data'];
      setState(() {
        productMap = courseData;
        lastPage = data['meta']['last_page'];
      });
    } on Exception catch (exception) {
      setState(() {
        status = exception.toString();
      });
    } catch (error) {
      setState(() {
        status = error.toString();
      });
    }
    
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

  String status = "";

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

  _getBody() {
    return productMap.map((e) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
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
                      icon: Icon(Icons.remove_red_eye),
                      color: Color(0xFF8A7CEE),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  ButtonStyle getColor(int index) {
    /*return ElevatedButton(
      shape: CircleBorder(),
    );*/
    if (index == current_page) {
      return ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF8A7CEE),
          foregroundColor: Color(0xFFFFFFEE),
          shape: CircleBorder()
      );
    }
    else{
      return ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFFFFFEE),
          foregroundColor: Color(0xFF8A7CEE),
          shape: CircleBorder()
      );
    }

  }

  _getPagination() {
    final growableList = List<int>.generate(
        lastPage, (int index) => index * index,
        growable: true);
    return growableList.map((e) {
      // return
      return Container(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: TextButton(
            onPressed: () {
              setState(() {
                current_page = e + 1;
                getCourses();
              });
            },
            child: Text('${e + 1}'),
            style: getColor(e +1),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(children: [
        ..._getBody(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [..._getPagination()],
        )
      ]),
    );
  }
}


class Todo {
  final String title;
  final String description;

  const Todo(this.title, this.description);
}