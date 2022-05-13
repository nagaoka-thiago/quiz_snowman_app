import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:quiz_snowman_app/pages/leaderboard_page.dart';
import 'package:quiz_snowman_app/pages/profile_page.dart';
import 'package:quiz_snowman_app/widgets/mainpage_widgets/main_body.dart';

import '../models/user_api.dart';

class MainPage extends StatefulWidget {
  final UserApi user;

  const MainPage({Key? key, required this.user}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int bottomSelectedIndex = 0;

  final PageController controller = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget buildPageView() {
    return PageView(
      controller: controller,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        MainPageBody(user: widget.user),
        const LeaderboardPageWidget(),
        ProfilePageWidget(user: widget.user),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void pageChanged(int index) {
    setState(
      () {
        bottomSelectedIndex = index;
      },
    );
  }

  void bottomTapped(int index) {
    setState(
      () {
        bottomSelectedIndex = index;
        controller.animateToPage(index,
            duration: const Duration(milliseconds: 500), curve: Curves.ease);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 191, 126, 174),
      body: buildPageView(),
      bottomNavigationBar: CurvedNavigationBar(
        index: bottomSelectedIndex,
        onTap: (index) {
          bottomTapped(index);
        },
        items: const <Widget>[
          Icon(
            Icons.quiz,
            size: 50,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          Icon(
            Icons.leaderboard,
            size: 50,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          Icon(
            Icons.person,
            size: 50,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ],
        buttonBackgroundColor: const Color.fromARGB(255, 152, 94, 191),
        color: const Color.fromARGB(255, 152, 94, 191),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
