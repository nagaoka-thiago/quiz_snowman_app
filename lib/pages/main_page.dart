import 'package:flutter/material.dart';
import 'package:quiz_snowman_app/widgets/mainpage_widgets/botton_navegation_bar.dart';
import 'package:quiz_snowman_app/widgets/mainpage_widgets/main_body.dart';

import '../models/user_api.dart';

class MainPage extends StatelessWidget {
  final UserApi user;
  const MainPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: MainPageBody(user: user),
        bottomNavigationBar: const BottonNavegationBarGlobal(),
      ),
    );
  }
}
