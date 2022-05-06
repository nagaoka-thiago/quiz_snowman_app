import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_snowman_app/models/question_api.dart';
import 'package:quiz_snowman_app/widgets/global/global_button.dart';

class QuestionPageWidget extends StatefulWidget {
  final Future<List<QuestionApi>> questions;
  const QuestionPageWidget({Key? key, required this.questions})
      : super(key: key);

  @override
  State<QuestionPageWidget> createState() => _QuestionPageWidgetState();
}

class _QuestionPageWidgetState extends State<QuestionPageWidget> {
  late int current;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    current = 1;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 191, 126, 174),
          body: FutureBuilder(
              future: widget.questions,
              builder: (context, snapshot) {
                List<QuestionApi> questions = [];
                List<String> alternatives = [];
                if (snapshot.hasData) {
                  questions = snapshot.data as List<QuestionApi>;
                  alternatives = [
                    questions[current - 1].correctAnswer!,
                    ...questions[current - 1].incorrectAnswers!
                  ];
                  return Container(
                      height: MediaQuery.of(context).size.height,
                      margin:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            margin: const EdgeInsets.only(bottom: 20),
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: const Color.fromRGBO(101, 48, 217, 0.37),
                            ),
                            child: Column(children: [
                              Text('Question ' + current.toString(),
                                  style: GoogleFonts.robotoMono(
                                      fontSize: 20, color: Colors.white)),
                              const SizedBox(height: 20),
                              Text(
                                questions[current - 1].question!,
                                style: GoogleFonts.robotoMono(
                                    fontSize: 20, color: Colors.white),
                                textAlign: TextAlign.justify,
                              )
                            ]),
                          ),
                          SizedBox(
                            height: 450,
                            child: ListView.builder(
                                itemCount: alternatives.length,
                                itemBuilder: (context, i) {
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: GlobalButton(
                                        onPressed: () {
                                          if (current < questions.length) {
                                            setState(() {
                                              current++;
                                            });
                                          } else {}
                                        },
                                        text: alternatives[i]),
                                  );
                                }),
                          ),
                        ],
                      ));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              })),
    );
  }
}
