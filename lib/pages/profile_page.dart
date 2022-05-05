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
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.all(40),
                    child: Image.asset(
                      'lib/Assets/ideas.png',
                      height:
                          (MediaQuery.of(context).size.height - bottom) * 0.2,
                    )),
                const SizedBox(height: 30),
                Container(
                    margin: const EdgeInsets.only(left: 36, right: 18),
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    width: MediaQuery.of(context).size.width,
                    height: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: const Color.fromRGBO(101, 48, 217, 0.37),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('First name: ' + widget.user.firstName!,
                            style: GoogleFonts.robotoMono(
                                color: Colors.white, fontSize: 20)),
                        const SizedBox(height: 5),
                        Text('Last name: ' + widget.user.lastName!,
                            style: GoogleFonts.robotoMono(
                                color: Colors.white, fontSize: 20)),
                        const SizedBox(height: 5),
                        Text('E-mail: ',
                            style: GoogleFonts.robotoMono(
                                color: Colors.white, fontSize: 20)),
                        const SizedBox(height: 5),
                        Text(widget.user.email!,
                            style: GoogleFonts.robotoMono(
                                color: Colors.white, fontSize: 20)),
                        const SizedBox(height: 10),
                        isEdit
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: TextField(
                                    controller: passwordController,
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        hintText: 'Password'),
                                    style: GoogleFonts.robotoMono(
                                        fontSize: 20, color: Colors.black)))
                            : const Text(''),
                        const SizedBox(height: 10),
                        isEdit
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: TextField(
                                    controller: confirmPasswordController,
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        hintText: 'Confirm password'),
                                    style: GoogleFonts.robotoMono(
                                        fontSize: 20, color: Colors.black)))
                            : const Text('')
                      ],
                    )),
                Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    child: isEdit
                        ? GlobalButton(
                            onPressed: () {
                              //Dio().patch()
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
