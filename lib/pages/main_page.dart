import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:quiz_snowman_app/pages/leaderboard_page.dart';
import 'package:quiz_snowman_app/pages/profile_page.dart';
import 'package:quiz_snowman_app/widgets/mainpage_widgets/main_body.dart';
import 'package:http/http.dart' as http;

import '../models/user_api.dart';

class MainPage extends StatefulWidget {
  final UserApi user;

  const MainPage({Key? key, required this.user}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  int bottomSelectedIndex = 0;
  // String? fcmToken;

  final PageController controller = PageController(
    initialPage: 0,
    keepPage: true,
  );

  void loadFCM() async {
    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.high,
      );

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      /// Create an Android Notification Channel.
      ///
      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

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
    loadFCM();
    listenFCM();
    getToken();
    FirebaseMessaging.instance.subscribeToTopic("quiz");
    sendPushMessage();
  }

  void listenFCM() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: 'launch_background',
            ),
          ),
        );
      }
    });
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) => print(token));
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

  void sendPushMessage() async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAA2mxdJug:APA91bEkQ683Foa5NAiaErtm-7qrz0Osz-eBr9mIa54AJr9AxRKDaQ0FjAZOvWEDLBUhDSJThs6-ZVk6UyBs3dQKOtN50ROB0GQjpbH2X0vy5LnSmpHkl2-0u88BHqfv6A6KxWLquSFu',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': 'Welcome to the best quiz App in the world',
              'title': 'HELLO'
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": "/topics/quiz",
          },
        ),
      );
    } catch (e) {
      print("error push notification");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 191, 126, 174),
      body: SafeArea(child: buildPageView()),
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
