import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
          body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(255, 191, 126, 174),
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(40),
                  child: Image.asset('lib/Assets/ideas.png',
                      height: (MediaQuery.of(context).size.height - bottom) *
                          0.15)),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: TextField(
                      controller: firstNameController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          labelText: "First name")),
                ),
              ),
              SizedBox(
                  height:
                      (MediaQuery.of(context).size.height - bottom) * 0.015),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: TextField(
                      controller: lastNameController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          labelText: "Last name")),
                ),
              ),
              SizedBox(
                  height:
                      (MediaQuery.of(context).size.height - bottom) * 0.015),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          labelText: "E-mail")),
                ),
              ),
              SizedBox(
                  height:
                      (MediaQuery.of(context).size.height - bottom) * 0.015),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          labelText: "Password")),
                ),
              ),
              SizedBox(
                  height:
                      (MediaQuery.of(context).size.height - bottom) * 0.015),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: TextField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          labelText: "Confirm your password")),
                ),
              ),
              SizedBox(
                  height:
                      (MediaQuery.of(context).size.height - bottom) * 0.015),
              Container(
                  margin: const EdgeInsets.only(top: 54, bottom: 20),
                  child: GlobalButton(
                    text: 'REGISTER',
                    onPressed: () async {
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
                              "password": user.password
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
                                    builder: (context) => const MainPage()));
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
                  ))
            ],
          ),
        ),
      )),
    );
  }
}
