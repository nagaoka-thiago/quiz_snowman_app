import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/user_api.dart';
import '../widgets/global/button/global_button.dart';
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
    super.initState();

    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  hasEightCaracter() {
    if (passwordController.text.length >= 8) {
      return const Icon(
        Icons.check_circle,
        color: Color.fromARGB(255, 23, 121, 27),
      );
    } else {
      return const Icon(
        Icons.block,
        color: Color.fromARGB(255, 113, 26, 20),
      );
    }
  }

  hasSpecialCaracter() {
    if (passwordController.text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')) &&
        passwordController.text.isNotEmpty) {
      return const Icon(
        Icons.check_circle,
        color: Color.fromARGB(255, 23, 121, 27),
      );
    } else {
      return const Icon(
        Icons.block,
        color: Color.fromARGB(255, 113, 26, 20),
      );
    }
  }

  hasUpperCaseCaracter() {
    if (passwordController.text.isNotEmpty &&
        passwordController.text.contains(RegExp(r'[A-Z]')) == true) {
      return const Icon(
        Icons.check_circle,
        color: Color.fromARGB(255, 23, 121, 27),
      );
    } else {
      return const Icon(
        Icons.block,
        color: Color.fromARGB(255, 113, 26, 20),
      );
    }
  }

  @override
  void dispose() {
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
                        height:
                            (MediaQuery.of(context).size.height - bottom * 2) *
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
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            hintText: "FIRST NAME")),
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
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            hintText: "LAST NAME")),
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
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            hintText: "E-MAIL")),
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
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            hintText: "PASSWORD")),
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
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            hintText: "CONFIRM YOUR PASSWORD")),
                  ),
                ),
                SizedBox(
                    height: (MediaQuery.of(context).size.height - bottom * 2) *
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
                          const Text("8 caracters")
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          hasSpecialCaracter(),
                          const Text("1 special caracter (Ex: !,@,%,&)")
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          hasUpperCaseCaracter(),
                          const Text("1 Uppercase letter")
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                    height: (MediaQuery.of(context).size.height - bottom * 2) *
                        0.03),
                GlobalButton(
                  text: 'REGISTER',
                  onPressed: () async {
                    if (passwordController.text.length < 8) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor:
                                const Color.fromARGB(255, 191, 126, 174),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            title: Text(
                              "Password must have at leat 8 caracters!",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.robotoMono(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                              ),
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
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            backgroundColor:
                                const Color.fromARGB(255, 191, 126, 174),
                            title: Text(
                              "Password must have at least a num-alphabetical carater!",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.robotoMono(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white),
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
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            backgroundColor:
                                const Color.fromARGB(255, 191, 126, 174),
                            title: Text(
                              "Password must have at least 1 uppercase letter!",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.robotoMono(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white),
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
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                backgroundColor:
                                    const Color.fromARGB(255, 191, 126, 174),
                                title: Text(
                                  'User registered with success!',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.robotoMono(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                              );
                            },
                          );
                          Future.delayed(
                              const Duration(milliseconds: 300), () {});
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainPage(user: user)));
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                backgroundColor:
                                    const Color.fromARGB(255, 191, 126, 174),
                                title: Text(
                                  'Passwords do not match!',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.robotoMono(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                              );
                            },
                          );
                        }
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              backgroundColor:
                                  const Color.fromARGB(255, 191, 126, 174),
                              title: Text(
                                'Fill all of the fields!',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.robotoMono(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white),
                              ),
                            );
                          },
                        );
                      }
                    } on DioError catch (e) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            backgroundColor:
                                const Color.fromARGB(255, 191, 126, 174),
                            title: Text(
                              e.response!.data,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.robotoMono(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                          );
                        },
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
