import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_snowman_app/models/user_api.dart';
import 'package:quiz_snowman_app/pages/login_page.dart';
import 'package:quiz_snowman_app/widgets/global/global_button.dart';
import 'package:intl/intl.dart';

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

    return Container(
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
                      (MediaQuery.of(context).size.height - bottom * 2) * 0.2,
                )),
            Container(
              padding: const EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color.fromRGBO(101, 48, 217, 0.37),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const LoginPageWidget()));
                        },
                        icon: const Icon(Icons.logout_outlined)),
                  ),
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
                  const SizedBox(height: 10),
                  FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('users')
                          .doc(widget.user.sId)
                          .get(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          final data = snapshot.data;
                          final scores = data['quizes'] as List;

                          if (scores.isNotEmpty) {
                            final scoreList = scores
                                .map((score) =>
                                    (score as Map).values.toList()[0])
                                .toList();
                            final score =
                                scoreList.reduce((acc, el) => acc + el);
                            return Text(
                                'Average score: ' +
                                    ((score / scoreList.length) * 100)
                                        .toStringAsFixed(2) +
                                    '%',
                                style: GoogleFonts.robotoMono(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold));
                          } else {
                            return Text('No quizes have been answered yet.',
                                style: GoogleFonts.robotoMono());
                          }
                        }
                        return const Text('');
                      }),
                  isEdit
                      ? const Text('')
                      : InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                      title: Text(
                                        'Scoreboard',
                                        style: GoogleFonts.robotoMono(
                                            color: Colors.white, fontSize: 35),
                                        textAlign: TextAlign.center,
                                      ),
                                      backgroundColor:
                                          const Color.fromRGBO(101, 48, 217, 1),
                                      content: FutureBuilder(
                                          future: FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(widget.user.sId)
                                              .get(),
                                          builder: (context,
                                              AsyncSnapshot snapshot) {
                                            if (snapshot.hasData) {
                                              final data = snapshot.data;
                                              final scores =
                                                  data['quizes'] as List;

                                              if (scores.isNotEmpty) {
                                                return SingleChildScrollView(
                                                  child: SizedBox(
                                                    height: 300,
                                                    width: 300,
                                                    child: ListView.builder(
                                                        itemCount:
                                                            scores.length,
                                                        itemBuilder:
                                                            (context, i) {
                                                          final date = DateFormat(
                                                                  'dd/MM')
                                                              .format(DateTime
                                                                  .parse(((scores[
                                                                              i]
                                                                          as Map)
                                                                      .keys
                                                                      .toList()[0])));
                                                          final score =
                                                              (scores[i] as Map)
                                                                  .values
                                                                  .toList()[0];
                                                          return ListTile(
                                                              title: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50),
                                                                border: const Border(
                                                                    bottom: BorderSide(
                                                                        color: Colors
                                                                            .white),
                                                                    top: BorderSide(
                                                                        color: Colors
                                                                            .white),
                                                                    right: BorderSide(
                                                                        color: Colors
                                                                            .white),
                                                                    left: BorderSide(
                                                                        color: Colors
                                                                            .white))),
                                                            child: Text(
                                                                date.toString() +
                                                                    ': ' +
                                                                    (score * 100)
                                                                        .toString() +
                                                                    '%',
                                                                style: GoogleFonts.robotoMono(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                          ));
                                                        }),
                                                  ),
                                                );
                                              } else {
                                                return Text(
                                                    'No quizes have been answered yet.',
                                                    style: GoogleFonts
                                                        .robotoMono());
                                              }
                                            }
                                            return const Text('');
                                          }));
                                });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Text('See scores',
                                style: GoogleFonts.robotoMono(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          )),
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
                                    borderSide:
                                        const BorderSide(color: Colors.black),
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
                                    borderSide:
                                        const BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  hintText: 'CONFIRM PASSWORD'),
                              style: GoogleFonts.robotoMono(
                                  fontSize: 16, color: Colors.black)))
                      : const Text(''),
                ],
              ),
            ),
            SizedBox(
                height:
                    (MediaQuery.of(context).size.height - bottom * 2) * 0.04),
            Container(
              child: isEdit
                  ? GlobalButton(
                      onPressed: () async {
                        if (passwordController.text.isNotEmpty &&
                            confirmPasswordController.text.isNotEmpty) {
                          if (passwordController.text
                                  .compareTo(confirmPasswordController.text) ==
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
                                  .update({"password": userReturned.password});
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
                              setState(() {
                                isEdit = false;
                              });
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
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
