import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/user_api.dart';
import '../widgets/global/global_button.dart';
import 'main_page.dart';

class RegisterPageWidget extends StatefulWidget {
  const RegisterPageWidget({Key? key}) : super(key: key);

  @override
  State<RegisterPageWidget> createState() => _RegisterPageWidgetState();
}

class _RegisterPageWidgetState extends State<RegisterPageWidget> {
  late TextEditingController firstNameController;

  late TextEditingController lastNameController;

  late TextEditingController emailController;

  late TextEditingController passwordController;

  late TextEditingController confirmPasswordController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  hasEightCaracter() {
    if (passwordController.text.length >= 8) {
      return const Icon(Icons.check_circle);
    } else {
      return const Icon(Icons.block);
    }
  }

  hasSpecialCaracter() {
    if (passwordController.text.contains(RegExp('^[a-zA-Z0-9_]*')) == false &&
        passwordController.text.isNotEmpty) {
      return const Icon(Icons.check_circle);
    } else {
      return const Icon(Icons.block);
    }
  }

  hasUpperCaseCaracter() {
    if (passwordController.text.toLowerCase() == passwordController.text && passwordController.text.contains(RegExp(r'[a-z]'))) {
      return const Icon(Icons.check_circle);
    } else {
      return const Icon(Icons.block);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
                children: [
                  Padding(
                      padding: const EdgeInsets.all(32),
                      child: Image.asset('lib/Assets/ideas.png',
                          height: (MediaQuery.of(context).size.height -
                                  bottom * 2) *
                              0.1)),
                  SizedBox(
                    width: 280,
                    child: Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextField(
                          controller: firstNameController,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              labelText: "FIRST NAME")),
                    ),
                  ),
                  SizedBox(
                      height:
                          (MediaQuery.of(context).size.height - bottom) * 0.01),
                  SizedBox(
                    width: 280,
                    child: Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextField(
                          controller: lastNameController,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              labelText: "LAST NAME")),
                    ),
                  ),
                  SizedBox(
                      height:
                          (MediaQuery.of(context).size.height - bottom) * 0.01),
                  SizedBox(
                    width: 280,
                    child: Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              labelText: "E-MAIL")),
                    ),
                  ),
                  SizedBox(
                      height:
                          (MediaQuery.of(context).size.height - bottom) * 0.01),
                  SizedBox(
                    width: 280,
                    child: Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              labelText: "PASSWORD")),
                    ),
                  ),
                  SizedBox(
                      height:
                          (MediaQuery.of(context).size.height - bottom) * 0.01),
                  SizedBox(
                    width: 280,
                    child: Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextField(
                          controller: confirmPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              labelText: "CONFIRM YOUR PASSWORD")),
                    ),
                  ),
                  SizedBox(
                      height:
                          (MediaQuery.of(context).size.height - bottom * 2) *
                              0.02),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            hasEightCaracter(),
                            const Text("At least 8 caracters")
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            hasSpecialCaracter(),
                            const Text(
                                "At least 1 special caracter (Ex: !,@,%,&)")
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            hasUpperCaseCaracter(),
                            const Text("At least 1 Uppercase letter")
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                      height:
                          (MediaQuery.of(context).size.height - bottom * 2) *
                              0.03),
                  GlobalButton(
                    text: 'REGISTER',
                    onPressed: () async {
                      if (passwordController.text.length < 8) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                "Password must have at leat 8 caracters!",
                                style: GoogleFonts.robotoMono(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            );
                          },
                        );

                        return;
                      }
                      if (!passwordController.text
                          .contains(RegExp('^[a-zA-Z0-9_]*'))) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                "Password must have at least a num-alphabetical carater!",
                                style: GoogleFonts.robotoMono(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            );
                          },
                        );

                        return;
                      }
                      if (passwordController.text.toLowerCase() ==
                          passwordController.text) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                "Password must have at least 1 uppercase letter!",
                                style: GoogleFonts.robotoMono(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            );
                          },
                        );

                        return;
                      }
                      try {
                        if (firstNameController.text.isNotEmpty &&
                            lastNameController.text.isNotEmpty &&
                            emailController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty &&
                            confirmPasswordController.text.isNotEmpty) {
                          if (passwordController.text ==
                              confirmPasswordController.text) {
                            Response response = await Dio().post(
                                "https://academy-auth.herokuapp.com/register",
                                data: {
                                  "first_name": firstNameController.text,
                                  "last_name": lastNameController.text,
                                  "email": emailController.text,
                                  "password": passwordController.text
                                });

                            UserApi user = UserApi.fromJson(response.data);

                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(user.sId)
                                .set({
                              "id": user.sId,
                              "first_name": user.firstName,
                              "last_name": user.lastName,
                              "email": user.email,
                              "password": user.password,
                              "quizes": []
                            });
                            final snackBar = SnackBar(
                              content:
                                  const Text('User registered with success!'),
                              action: SnackBarAction(
                                label: 'Ok',
                                onPressed: () {},
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MainPage(user: user)));
                          } else {
                            final snackBar = SnackBar(
                              content: const Text('Passwords do not match.'),
                              action: SnackBarAction(
                                label: 'Ok',
                                onPressed: () {},
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        } else {
                          final snackBar = SnackBar(
                            content: const Text('You need to fill all fields.'),
                            action: SnackBarAction(
                              label: 'Ok',
                              onPressed: () {},
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      } on DioError catch (e) {
                        final snackBar = SnackBar(
                          content: Text(e.response!.data),
                          action: SnackBarAction(
                            label: 'Ok',
                            onPressed: () {
                              // Some code to undo the change.
                            },
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                  )
                ],
              ),
            ),
          )),
    );
  }
}
