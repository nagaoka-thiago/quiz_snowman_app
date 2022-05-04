import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_snowman_app/models/UserApi.dart';
import 'package:quiz_snowman_app/pages/main_page.dart';
import 'package:quiz_snowman_app/pages/register_page.dart';
import 'package:quiz_snowman_app/widgets/global/global_button.dart';

import 'package:dio/dio.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPageBodyWidget extends StatelessWidget {
  const LoginPageBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bottom = MediaQuery.of(context).viewInsets.bottom;
    TextEditingController _emailController = new TextEditingController();
    TextEditingController _passwordController = new TextEditingController();

    return Container(
      color: const Color.fromARGB(255, 191, 126, 174),
      child: Expanded(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(40),
                child: Image.asset('lib/Assets/ideas.png',
                    height:
                        (MediaQuery.of(context).size.height - bottom) * 0.10)),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      labelText: "Type your e-mail")),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, top: 19),
              child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      labelText: "Type your password")),
            ),
            Container(
                margin: const EdgeInsets.only(top: 54),
                child: GlobalButton(
                  text: 'LOGIN',
                  onPressed: () async {
                    try {
                      Response response = await Dio().post(
                          "https://academy-auth.herokuapp.com/login",
                          data: {
                            "email": _emailController.text,
                            "password": _passwordController.text
                          });

                      UserApi user = UserApi.fromJson(response.data);

                      final snackBar = SnackBar(
                        content: const Text('Logged in!'),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MainPage()));
                          },
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } on DioError catch (e) {
                      if (e.response!.statusCode == 400) {
                        final snackBar = SnackBar(
                          content: const Text('Invalid e-mail and password!'),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {
                              // Some code to undo the change.
                            },
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }
                  },
                )),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterPageWidget()));
                },
                child: Container(
                    margin: const EdgeInsets.only(top: 34),
                    child: Text('Register', style: GoogleFonts.robotoMono())))
          ],
        ),
      ),
    );
  }
}
