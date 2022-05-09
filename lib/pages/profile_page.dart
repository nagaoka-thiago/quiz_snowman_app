import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_snowman_app/models/user_api.dart';
import 'package:quiz_snowman_app/widgets/global/global_button.dart';

class ProfilePageWidget extends StatefulWidget {
  final UserApi user;
  const ProfilePageWidget({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfilePageWidget> createState() => _ProfilePageWidgetState();
}

class _ProfilePageWidgetState extends State<ProfilePageWidget> {
  late bool isEdit;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    isEdit = false;
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var bottom = MediaQuery.of(context).viewInsets.bottom;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 191, 126, 174),
        body: Container(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.all(24),
                    child: Image.asset(
                      'lib/Assets/ideas.png',
                      height:
                          (MediaQuery.of(context).size.height - bottom * 2) *
                              0.2,
                    )),
                Container(
                  padding: const EdgeInsets.all(16),
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: const Color.fromRGBO(101, 48, 217, 0.37),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('NAME: ',
                          style: GoogleFonts.robotoMono(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 3),
                      Text(widget.user.firstName!,
                          style: GoogleFonts.robotoMono(
                              color: Colors.white, fontSize: 18)),
                      const SizedBox(height: 12),
                      Text('LAST NAME: ',
                          style: GoogleFonts.robotoMono(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 3),
                      Text(widget.user.lastName!,
                          style: GoogleFonts.robotoMono(
                              color: Colors.white, fontSize: 18)),
                      const SizedBox(height: 12),
                      Text('E-MAIL: ',
                          style: GoogleFonts.robotoMono(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 3),
                      Text(widget.user.email!,
                          style: GoogleFonts.robotoMono(
                              color: Colors.white, fontSize: 18)),
                      const SizedBox(height: 12),
                      isEdit
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: TextField(
                                  controller: passwordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      hintText: 'PASSWORD'),
                                  style: GoogleFonts.robotoMono(
                                      fontSize: 16, color: Colors.black)))
                          : const Text(''),
                      const SizedBox(height: 10),
                      isEdit
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: TextField(
                                  controller: confirmPasswordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      hintText: 'CONFIRM PASSWORD'),
                                  style: GoogleFonts.robotoMono(
                                      fontSize: 16, color: Colors.black)))
                          : const Text('')
                    ],
                  ),
                ),
                SizedBox(
                    height: (MediaQuery.of(context).size.height - bottom * 2) *
                        0.04),
                Container(
                    child: isEdit
                        ? GlobalButton(
                            onPressed: () async {
                              if (passwordController.text.isNotEmpty &&
                                  confirmPasswordController.text.isNotEmpty) {
                                if (passwordController.text.compareTo(
                                        confirmPasswordController.text) ==
                                    0) {
                                  UserApi newUser = widget.user;
                                  newUser.password = passwordController.text;
                                  try {
                                    Response response = await Dio().patch(
                                        'https://academy-auth.herokuapp.com/update',
                                        data: {
                                          'email': newUser.email,
                                          'new_password': newUser.password
                                        },
                                        options: Options(headers: {
                                          'x-access-token': newUser.token
                                        }));
                                    UserApi userReturned =
                                        UserApi.fromJson(response.data);

                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(userReturned.sId)
                                        .update({
                                      "password": userReturned.password
                                    });
                                    final snackBar = SnackBar(
                                      content: const Text(
                                          'User\'s password updated successfully.'),
                                      action: SnackBarAction(
                                        label: 'Ok',
                                        onPressed: () {},
                                      ),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } on DioError catch (e) {
                                    final snackBar = SnackBar(
                                      content: Text(e.message),
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
                                    content: const Text(
                                        'Your passwords don\'t match eachother.'),
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
                                  content: const Text(
                                      'You need to fill your new password and confirm it.'),
                                  action: SnackBarAction(
                                    label: 'Ok',
                                    onPressed: () {},
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                setState(() {
                                  isEdit = false;
                                });
                              }
                            },
                            text: 'UPDATE')
                        : GlobalButton(
                            text: 'EDIT INFO',
                            onPressed: () {
                              setState(() {
                                isEdit = true;
                              });
                            },
                          ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
