import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';

class Courses extends StatefulWidget {
  const Courses({Key? key}) : super(key: key);

  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  void initState() {
    // TODO
    super.initState();
    getCourses();
  }
  String query = "?page=1";
  List<dynamic> productMap = [];

  getCourses() async {
    String url = "http://demo.api.tlancer.net/api/courses/search$query";
    try {
      Response response = await get(Uri.parse(url));
      Map data = jsonDecode(response.body);
      var courseData = data['data'];
      setState(() {
        productMap = courseData;
      });
    } on Exception catch (exception) {
      setState(() {
        status = exception.toString();
      });
    }
    catch (error) {
      setState(() {
        status = error.toString();
      });
      print(status);
    }

  }
  getBodyImage(param){
    if(param == null || param == ''){
      return SizedBox(height: 4);
    }
    return ConstrainedBox (
      constraints: BoxConstraints (maxHeight: 300, maxWidth: double.infinity),
      child: Image(
          image: NetworkImage('https://tlancer.net:5000'+param),
          fit: BoxFit.cover,
      ),
    );
  }
  String status="just got initilized";
  getAvatarImage(param){
    if(param == "" || param == null  ){
      return const CircleAvatar(
        backgroundImage: NetworkImage(
            'https://tlancer.net/assets/media/student-section-home-page/bg-removebg-preview%201.png'
        ),
      );
    }
    else if(param.endsWith('.svg')){
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
      backgroundImage: NetworkImage(
          param
      ),
    );
  }
  _getBody() {
    return productMap.map((e) {
      
      return Container(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
        child: Card(
          elevation: 4,
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Text(status),
              ListTile(
                leading:getAvatarImage(e['user']['avatar']),
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
                        print(e['id']);
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(children: [
        ..._getBody(),
      ]),
    );
  }
}
