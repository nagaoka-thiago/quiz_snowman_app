import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:collection/collection.dart";

class LeaderboardPageWidget extends StatefulWidget {
  const LeaderboardPageWidget({Key? key}) : super(key: key);

  @override
  State<LeaderboardPageWidget> createState() => _LeaderboardPageWidgetState();
}

class _LeaderboardPageWidgetState extends State<LeaderboardPageWidget> {
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
                  const FaIcon(
                    FontAwesomeIcons.crown,
                    color: Color.fromARGB(255, 242, 169, 80),
                    size: 60,
                  ),
                  Text('Leaderboard',
                      style: GoogleFonts.robotoMono(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  Container(
                    height: 250,
                    margin: const EdgeInsets.only(top: 20),
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('leaderboard')
                            //.orderBy('correctAnswers', descending: true)
                            .snapshots(),
                        builder: (context1, snapshot1) {
                          if (snapshot1.hasData) {
                            var docs = (snapshot1.data as QuerySnapshot).docs;

                            Map docsByUserId = groupBy(
                                docs,
                                (el) => ((el as DocumentSnapshot).data()
                                    as Map)['userId']);

                            Map groupedAndSum = {};
                            docsByUserId.forEach((key, value) {
                              int sum = 0;
                              for (var element in (value as List)) {
                                sum = sum + (element['correctAnswers'] as int);
                              }
                              groupedAndSum[key] = sum;
                            });

                            List groupedAndSumSorted = groupedAndSum.entries
                                .sorted((a, b) => b.value.compareTo(a.value));

                            return ListView.builder(
                                itemCount: groupedAndSumSorted.length,
                                itemBuilder: (context2, i) {
                                  return FutureBuilder(
                                      future: FirebaseFirestore.instance
                                          .collection('users')
                                          .doc((groupedAndSumSorted[i]
                                                  as MapEntry)
                                              .key)
                                          .get(),
                                      builder: (context3, snapshot2) {
                                        if (snapshot2.hasData) {
                                          final userName = ((snapshot2.data
                                                  as DocumentSnapshot)
                                              .data() as Map)['first_name'];
                                          return Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 191, 126, 174),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(50),
                                                ),
                                                border: Border.all(
                                                    color: Colors.amber),
                                              ),
                                              child: Center(
                                                child: Text(
                                                    (i + 1).toString() +
                                                        'º ' +
                                                        userName +
                                                        ': ' +
                                                        (groupedAndSumSorted[i]
                                                                as MapEntry)
                                                            .value
                                                            .toString(),
                                                    textAlign: TextAlign.center,
                                                    style:
                                                        GoogleFonts.robotoMono(
                                                            fontSize: 20,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                              ),
                                            ),
                                          );
                                        } else {
                                          return const Text('');
                                        }
                                      });
                                });
                          } else {
                            return const CircularProgressIndicator();
                          }
                        }),
                  )
                ],
              ),
            )
          ],
        )));
  }
}
