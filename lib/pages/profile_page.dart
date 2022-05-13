import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_snowman_app/models/user_api.dart';
import 'package:quiz_snowman_app/pages/login_page.dart';
import 'package:quiz_snowman_app/widgets/global/button/global_button.dart';
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
    super.initState();

    isEdit = false;
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
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
                    padding: const EdgeInsets.only(right: 10, top: 5),
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
                  Text(
                    'NAME: ',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.robotoMono(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 3),
                  Text(widget.user.firstName!,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.robotoMono(
                          color: Colors.white, fontSize: 18)),
                  const SizedBox(height: 12),
                  Text('LAST NAME: ',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.robotoMono(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 3),
                  Text(widget.user.lastName!,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.robotoMono(
                          color: Colors.white, fontSize: 18)),
                  const SizedBox(height: 12),
                  Text('E-MAIL: ',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.robotoMono(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 3),
                  Text(widget.user.email!,
                      textAlign: TextAlign.center,
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
                            return Column(
                              children: [
                                Text(
                                    'Average score: ' +
                                        ((score / scoreList.length) * 100)
                                            .toStringAsFixed(2) +
                                        '%',
                                    style: GoogleFonts.robotoMono(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 16),
                                FaIcon(
                                  (score / scoreList.length) * 100 >= 90
                                      ? FontAwesomeIcons.a
                                      : (score / scoreList.length) * 100 >=
                                                  80 &&
                                              (score / scoreList.length) * 100 <
                                                  90
                                          ? FontAwesomeIcons.b
                                          : (score / scoreList.length) * 100 >=
                                                      70 &&
                                                  (score / scoreList.length) *
                                                          100 <
                                                      80
                                              ? FontAwesomeIcons.c
                                              : (score / scoreList.length) *
                                                              100 >=
                                                          60 &&
                                                      (score /
                                                                  scoreList
                                                                      .length) *
                                                              100 <
                                                          70
                                                  ? FontAwesomeIcons.d
                                                  : FontAwesomeIcons.f,
                                  color:
                                      const Color.fromARGB(255, 242, 169, 80),
                                  size: 56,
                                ),
                              ],
                            );
                          } else {
                            return Text('No quizes have been answered yet.',
                                style: GoogleFonts.robotoMono(
                                    fontSize: 16, color: Colors.white));
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
                                      title: Column(
                                        children: [
                                          const Icon(
                                            Icons.history,
                                            color: Color.fromARGB(
                                                255, 242, 169, 80),
                                            size: 60,
                                          ),
                                          Text(
                                            'Scoreboard',
                                            style: GoogleFonts.robotoMono(
                                                color: Colors.white,
                                                fontSize: 35,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      backgroundColor: const Color.fromARGB(
                                          255, 152, 94, 191),
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
                                                scores.sort((e1, e2) =>
                                                    (e1 as Map)
                                                        .keys
                                                        .toList()[0]
                                                        .compareTo((e2 as Map)
                                                            .keys
                                                            .toList()[0]));

                                                return SingleChildScrollView(
                                                  child: SizedBox(
                                                    height: MediaQuery.of(context).size.height * 0.9,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.9,
                                                    child: ListView.builder(
                                                      itemCount: scores.length,
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
                                                                    .toList()[0]
                                                                as double;
                                                        return ListTile(
                                                          title: Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.95,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(16),
                                                            decoration: BoxDecoration(
                                                                color: const Color.fromARGB(
                                                                    255, 191, 126, 174),
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        50),
                                                                border: const Border(
                                                                    bottom: BorderSide(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            242,
                                                                            169,
                                                                            80)),
                                                                    top: BorderSide(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            242,
                                                                            169,
                                                                            80)),
                                                                    right: BorderSide(color: Color.fromARGB(255, 242, 169, 80)),
                                                                    left: BorderSide(color: Color.fromARGB(255, 242, 169, 80)))),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                    date.toString() +
                                                                        ': ' +
                                                                        (score *
                                                                                100)
                                                                            .toStringAsFixed(
                                                                                1) +
                                                                        '%',
                                                                    style: GoogleFonts.robotoMono(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                                const SizedBox(
                                                                    width: 16),
                                                                FaIcon(
                                                                    score * 100 >=
                                                                            90
                                                                        ? FontAwesomeIcons
                                                                            .a
                                                                        : score * 100 >= 80 &&
                                                                                score * 100 < 90
                                                                            ? FontAwesomeIcons.b
                                                                            : score * 100 >= 70 && score * 100 < 80
                                                                                ? FontAwesomeIcons.c
                                                                                : score * 100 >= 60 && score * 100 < 70
                                                                                    ? FontAwesomeIcons.d
                                                                                    : FontAwesomeIcons.f,
                                                                    color: const Color.fromARGB(255, 242, 169, 80))
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                return Text(
                                                    'No quizes have been answered yet.',
                                                    style:
                                                        GoogleFonts.robotoMono(
                                                            fontSize: 16,
                                                            color:
                                                                Colors.white));
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
            Column(
              children: [
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
                                      .update(
                                          {"password": userReturned.password});
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
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          },
                          text: 'UPDATE')
                      : GlobalButton(
                          text: 'CHANGE PASSWORD',
                          onPressed: () {
                            setState(() {
                              isEdit = true;
                            });
                          },
                        ),
                ),
                const SizedBox(
                  height: 25,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
