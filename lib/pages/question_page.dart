import 'dart:async';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_snowman_app/models/question_api.dart';
import 'package:quiz_snowman_app/models/user_api.dart';
import 'package:quiz_snowman_app/pages/score_page.dart';
import 'package:quiz_snowman_app/widgets/global/button/button_status.dart';
import 'package:quiz_snowman_app/widgets/global/button/global_button.dart';
import 'package:percent_indicator/percent_indicator.dart';

class QuestionPageWidget extends StatefulWidget {
  final Future<List<QuestionApi>> questions;
  final UserApi user;
  final String difficulty;
  const QuestionPageWidget(
      {Key? key,
      required this.questions,
      required this.user,
      required this.difficulty})
      : super(key: key);

  @override
  State<QuestionPageWidget> createState() => _QuestionPageWidgetState();
}

class _QuestionPageWidgetState extends State<QuestionPageWidget> {
  late int current;
  late int correctAnswers;

  List<ButtonStatus?> _buttonStatus = [
    ButtonStatus.idle,
    ButtonStatus.idle,
    ButtonStatus.idle,
    ButtonStatus.idle
  ];
  final CountDownController _controller = CountDownController();

  @override
  void initState() {
    super.initState();

    current = 1;
    correctAnswers = 0;
  }

  int duration(quizDifficulty) {
    if (quizDifficulty == "Easy") {
      return 30;
    } else if (quizDifficulty == "Medium") {
      return 20;
    } else {
      return 15;
    }
  }

  void _resetButtons() {
    _buttonStatus = [
      ButtonStatus.idle,
      ButtonStatus.idle,
      ButtonStatus.idle,
      ButtonStatus.idle
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 191, 126, 174),
        body: SingleChildScrollView(
          child: FutureBuilder<List<QuestionApi>>(
            future: widget.questions,
            builder: (context, snapshot) {
              List<QuestionApi> questions = [];

              if (snapshot.hasData) {
                questions = snapshot.data!;
                return Container(
                    height: MediaQuery.of(context).size.height,
                    margin: const EdgeInsets.only(
                      top: 20,
                      left: 20,
                      right: 20,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          LinearPercentIndicator(
                            percent: current / questions.length,
                            lineHeight: 24,
                            curve: Curves.easeOutCirc,
                            barRadius: const Radius.circular(16),
                            animationDuration: 500,
                            animateFromLastPercent: true,
                            animation: true,
                            progressColor:
                                const Color.fromARGB(255, 242, 169, 80),
                            backgroundColor: Colors.white,
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(16),
                            margin: const EdgeInsets.only(bottom: 20),
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: const Color.fromRGBO(101, 48, 217, 0.37),
                            ),
                            child: Column(
                              children: [
                                Text('QUESTION ' + current.toString(),
                                    style: GoogleFonts.robotoMono(
                                        fontSize: 24,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 20),
                                Text(
                                  questions[current - 1].question!,
                                  style: GoogleFonts.robotoMono(
                                      fontSize: 20, color: Colors.white),
                                  textAlign: TextAlign.justify,
                                ),
                                Container(
                                  alignment: Alignment.bottomRight,
                                  child: CircularCountDownTimer(
                                      width: 30,
                                      height: 30,
                                      duration: duration(widget.difficulty),
                                      strokeWidth: 8,
                                      isReverse: true,
                                      controller: _controller,
                                      isTimerTextShown: false,
                                      onComplete: () async {
                                        for (int j = 0;
                                            j < _buttonStatus.length;
                                            j++) {
                                          if (questions[current - 1]
                                                  .alternatives[j] ==
                                              questions[current - 1]
                                                  .correctAnswer) {
                                            setState(() {
                                              _buttonStatus[j] =
                                                  ButtonStatus.correctOption;
                                            });
                                          }
                                        }
                                        await Future.delayed(
                                          const Duration(seconds: 1),
                                        );
                                        _resetButtons();
                                        if (current < questions.length) {
                                          setState(() {
                                            current++;
                                            _resetButtons();
                                            _controller.restart();
                                          });
                                        } else {
                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(widget.user.sId)
                                              .update({
                                            "quizes": FieldValue.arrayUnion([
                                              {
                                                DateTime.now().toString():
                                                    correctAnswers /
                                                        questions.length
                                              }
                                            ])
                                          });
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ScorePageWidget(
                                                          user: widget.user,
                                                          score: correctAnswers /
                                                              questions
                                                                  .length)));
                                        }
                                      },
                                      fillColor: const Color.fromARGB(
                                          255, 242, 169, 80),
                                      ringColor: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 450,
                            child: ListView.builder(
                                itemCount:
                                    questions[current - 1].alternatives.length,
                                itemBuilder: (context, i) {
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: GlobalButton(
                                        status: _buttonStatus[i],
                                        onPressed: () async {
                                          if (current <= questions.length) {
                                            if (questions[current - 1]
                                                    .alternatives[i] ==
                                                questions[current - 1]
                                                    .correctAnswer) {
                                              setState(() {
                                                _buttonStatus[i] =
                                                    ButtonStatus.correct;
                                                correctAnswers++;
                                              });
                                            } else {
                                              for (int j = 0;
                                                  j < _buttonStatus.length;
                                                  j++) {
                                                if (questions[current - 1]
                                                        .alternatives[j] ==
                                                    questions[current - 1]
                                                        .correctAnswer) {
                                                  setState(
                                                    () {
                                                      _buttonStatus[j] =
                                                          ButtonStatus
                                                              .correctOption;
                                                    },
                                                  );
                                                }
                                              }
                                              setState(() {
                                                _buttonStatus[i] =
                                                    ButtonStatus.wrong;
                                              });
                                            }
                                            await Future.delayed(
                                                const Duration(seconds: 1));
                                            _resetButtons();
                                            if (current + 1 <=
                                                questions.length) {
                                              setState(() {
                                                current++;
                                                _controller.restart();
                                              });
                                            } else {
                                              FirebaseFirestore.instance
                                                  .collection('users')
                                                  .doc(widget.user.sId)
                                                  .update({
                                                "quizes":
                                                    FieldValue.arrayUnion([
                                                  {
                                                    DateTime.now().toString():
                                                        correctAnswers /
                                                            questions.length
                                                  }
                                                ])
                                              });
                                              FirebaseFirestore.instance
                                                  .collection('leaderboard')
                                                  .doc()
                                                  .set({
                                                'userId':
                                                    widget.user.sId.toString(),
                                                'correctAnswers': correctAnswers
                                              });
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ScorePageWidget(
                                                              user: widget.user,
                                                              score: correctAnswers /
                                                                  questions
                                                                      .length)));
                                            }
                                          }
                                        },
                                        text: questions[current - 1]
                                            .alternatives[i]),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
