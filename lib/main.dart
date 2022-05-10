import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/login_page.dart';
import 'package:splashscreen/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(
          seconds: 3,
          navigateAfterSeconds: const LoginPageWidget(),
          title: Text(
            'Welcome In Quiz',
            style: GoogleFonts.robotoMono(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          imageBackground: const NetworkImage(
              'https://cdn.pixabay.com/photo/2020/09/23/07/53/quiz-5595288_1280.jpg'),
          backgroundColor: Colors.white,
          styleTextUnderTheLoader: const TextStyle(),
          photoSize: 100.0,
          onClick: () {},
          loaderColor: Colors.blue),
    );
  }
}
