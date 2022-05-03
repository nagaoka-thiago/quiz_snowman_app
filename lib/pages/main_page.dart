import 'package:flutter/material.dart';
import 'package:quiz_snowman_app/widgets/mainpage_widgets/botton_navegation_bar.dart';
import 'package:quiz_snowman_app/widgets/mainpage_widgets/main_body.dart';

class MainPage extends StatelessWidget {
  const MainPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: MainPageBody(),
        bottomNavigationBar: BottonNavegationBarGlobal(),
      ),
    );
  }
}