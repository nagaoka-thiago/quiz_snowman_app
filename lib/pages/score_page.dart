import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_snowman_app/models/user_api.dart';
import 'package:quiz_snowman_app/pages/main_page.dart';
import 'package:quiz_snowman_app/widgets/global/global_button.dart';

class ScorePageWidget extends StatelessWidget {
  final UserApi user;
  final double score;
  const ScorePageWidget({Key? key, required this.user, required this.score})
      : super(key: key);

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
                      Text('GOOD JOB!',
                          style: GoogleFonts.robotoMono(
                              fontSize: 36, color: Colors.white)),
                      const SizedBox(height: 68),
                      Text('GRADE',
                          style: GoogleFonts.robotoMono(
                              fontSize: 36, color: Colors.white)),
                      Text((score * 100).toString() + '%',
                          style: GoogleFonts.robotoMono(
                              fontSize: 36, color: Colors.white)),
                      const SizedBox(height: 31),
                      Text('A+',
                          style: GoogleFonts.robotoMono(
                              fontSize: 60, color: Colors.white))
                    ],
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 41),
                    child: GlobalButton(
                      text: 'HOME',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainPage(user: user)));
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