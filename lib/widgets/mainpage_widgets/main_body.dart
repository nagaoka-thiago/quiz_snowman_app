import 'package:flutter/material.dart';

class MainPageBody extends StatefulWidget {
  const MainPageBody({ Key? key }) : super(key: key);

  @override
  State<MainPageBody> createState() => _MainPageBodyState();
}

class _MainPageBodyState extends State<MainPageBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 191, 126, 174),
    );
  }
}