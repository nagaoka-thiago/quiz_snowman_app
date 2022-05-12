import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
                  Text('Leaderboard',
                      style: GoogleFonts.robotoMono(
                          fontSize: 35,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  Container(
                    height: 300,
                    margin: const EdgeInsets.only(top: 20),
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('leaderboard')
                            .orderBy('correctAnswers', descending: true)
                            .snapshots(),
                        builder: (context1, snapshot1) {
                          if (snapshot1.hasData) {
                            final docs = (snapshot1.data as QuerySnapshot).docs;
                            return ListView.builder(
                                itemCount: docs.length,
                                itemBuilder: (context2, i) {
                                  final mapa = docs[i].data() as Map;
                                  return FutureBuilder(
                                      future: FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(mapa['userId'])
                                          .get(),
                                      builder: (context3, snapshot2) {
                                        if (snapshot2.hasData) {
                                          final userName = ((snapshot2.data
                                                  as DocumentSnapshot)
                                              .data() as Map)['first_name'];
                                          return Text(
                                              (i + 1).toString() +
                                                  'º: ' +
                                                  userName +
                                                  ': ' +
                                                  mapa['correctAnswers']
                                                      .toString(),
                                              style: GoogleFonts.robotoMono(
                                                  fontSize: 30,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold));
                                        } else {
                                          return const Text('');
                                        }
                                      });
                                });
                          } else {
                            return const Text('');
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
