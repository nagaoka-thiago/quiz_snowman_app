import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_snowman_app/pages/main_page.dart';
import 'package:quiz_snowman_app/pages/profile_page.dart';
import 'package:quiz_snowman_app/pages/register_page.dart';
import '../models/user_api.dart';
import '../widgets/global/global_button.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({Key? key}) : super(key: key);

  @override
  State<LoginPageWidget> createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var bottom = MediaQuery.of(context).viewInsets.bottom;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 191, 126, 174),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: Image.asset(
                    'lib/Assets/ideas.png',
                    height: (MediaQuery.of(context).size.height - bottom) * 0.3,
                  ),
                ),
                SizedBox(
                  width: 280,
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        hintText: 'E-MAIL'),
                  ),
                ),
                SizedBox(
                  height: (MediaQuery.of(context).size.height - bottom) * 0.02,
                ),
                SizedBox(
                  width: 280,
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      hintText: 'PASSWORD',
                    ),
                  ),
                ),
                SizedBox(
                  height: (MediaQuery.of(context).size.height - bottom) * 0.02,
                ),
                
                SizedBox(
                  height: (MediaQuery.of(context).size.height - bottom) * 0.02,
                ),
                GlobalButton(
                  text: 'LOGIN',
                  onPressed: () async {
                    try {
                      Response response = await Dio().post(
                          "https://academy-auth.herokuapp.com/login",
                          data: {
                            "email": emailController.text,
                            "password": passwordController.text
                          });

                      UserApi user = UserApi.fromJson(response.data);

                      final snackBar = SnackBar(
                        content: const Text('Logged in!'),
                        action: SnackBarAction(
                          label: 'Ok',
                          onPressed: () {},
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainPage(user: user)));
                    } on DioError catch (e) {
                      if (e.response!.statusCode == 400) {
                        final snackBar = SnackBar(
                          content: const Text('Invalid e-mail and password!'),
                          action: SnackBarAction(
                            label: 'Ok',
                            onPressed: () {
                              // Some code to undo the change.
                            },
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }
                  },
                ),
                SizedBox(
                  height: (MediaQuery.of(context).size.height - bottom) * 0.02,
                ),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const RegisterPageWidget()));
                    },
                    child: Text('Register',
                        style: GoogleFonts.robotoMono(
                            fontWeight: FontWeight.bold, fontSize: 16)))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
