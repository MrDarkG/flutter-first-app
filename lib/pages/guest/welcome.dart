import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  static const textStyle = TextStyle(
    fontSize: 50.0,
    fontFamily: 'NotoSans',
  );
  static const colors = [
    Color(0xFF8A7CEE),
    Colors.white,
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 200, horizontal: 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: Center(
              child: AnimatedTextKit(
                  animatedTexts: [
                    FlickerAnimatedText('Hello', textStyle: const TextStyle(
                      fontFamily: 'NotoSans',
                      fontSize: 20
                    )),
                  ],
                  totalRepeatCount: 1,
                  pause: const Duration(milliseconds: 1000),
                  displayFullTextOnTap: true,
                  stopPauseOnTap: true,
                ),
            ),
          ),
          Flexible(
            child: Center(
              child: AnimatedTextKit(
                  animatedTexts: [
                    ColorizeAnimatedText('Tlancer', textStyle: textStyle, colors: colors),

                  ],
                  totalRepeatCount: 1,
                  pause: const Duration(milliseconds: 1000),
                  displayFullTextOnTap: true,
                  stopPauseOnTap: true,
                ),
            ),
          )
        ],
      ),
    );
  }
}
