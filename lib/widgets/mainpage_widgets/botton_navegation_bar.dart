import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottonNavegationBarGlobal extends StatelessWidget {
  const BottonNavegationBarGlobal({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: const Color.fromARGB(255, 191, 126, 174),
      height: 60,
      items: const <Widget>[
        Icon(Icons.quiz, size: 50, color: Color.fromARGB(255, 255, 255, 255),),
        Icon(Icons.person, size: 50, color: Color.fromARGB(255, 255, 255, 255),)
      ],
      buttonBackgroundColor:  const Color.fromARGB(255, 152, 94, 191),
      color: const Color.fromARGB(255, 152, 94, 191),
    );
  }
}