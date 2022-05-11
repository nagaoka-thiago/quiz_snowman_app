import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multiselect/multiselect.dart';
import 'package:quiz_snowman_app/functions/questions.dart';
import 'package:quiz_snowman_app/pages/question_page.dart';
import '../../models/user_api.dart';
import '../global/button/global_button.dart';

class MainPageBody extends StatefulWidget {
  final UserApi user;
  const MainPageBody({Key? key, required this.user}) : super(key: key);

  @override
  State<MainPageBody> createState() => _MainPageBodyState();
}

class _MainPageBodyState extends State<MainPageBody> {
  var selectedDifficulty = "Easy";
  var selectedQuestions = "10";
  List<String> selectedCategories = [];
  List<String> categoryList = [
    "Arts & Literature",
    "Film & TV",
    "Food & Drink",
    "General Knowledge",
    "Geography",
    "History",
    "Music",
    "Science",
    "Society & Culture",
    "Sport & Leisure",
  ];

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          child: Text(
            "Easy",
            textAlign: TextAlign.center,
          ),
          value: "Easy"),
      const DropdownMenuItem(
          child: Text(
            "Medium",
            textAlign: TextAlign.center,
          ),
          value: "Medium"),
      const DropdownMenuItem(
          child: Text(
            "Hard",
            textAlign: TextAlign.center,
          ),
          value: "Hard"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownQuestionsLimit {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          child: Text(
            "5",
            textAlign: TextAlign.center,
          ),
          value: "5"),
      const DropdownMenuItem(
          child: Text(
            "10",
            textAlign: TextAlign.center,
          ),
          value: "10"),
      const DropdownMenuItem(
          child: Text(
            "15",
            textAlign: TextAlign.center,
          ),
          value: "15"),
      const DropdownMenuItem(
          child: Text(
            "20",
            textAlign: TextAlign.center,
          ),
          value: "20"),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(32),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('lib/Assets/ideas.png'))),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                  color: Color.fromARGB(255, 152, 94, 191)),
              child: Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "CATEGORIES:",
                    style: GoogleFonts.robotoMono(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50))),
                      width: 300,
                      child: DropDownMultiSelect(
                        onChanged: (List<String> x) {
                          setState(() {
                            selectedCategories = x;
                          });
                        },
                        options: categoryList,
                        selectedValues: selectedCategories,
                        whenEmpty: 'Categories',
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          filled: true,
                          counterStyle: GoogleFonts.robotoMono(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "DIFFICULTY:",
                            style: GoogleFonts.robotoMono(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50))),
                              height: 50,
                              width: 110,
                              child: Center(
                                child: DropdownButton(
                                  underline: const SizedBox(),
                                  value: selectedDifficulty,
                                  dropdownColor:
                                      const Color.fromARGB(255, 152, 94, 191),
                                  iconEnabledColor:
                                      const Color.fromARGB(255, 242, 169, 80),
                                  alignment: AlignmentDirectional.center,
                                  style: (GoogleFonts.robotoMono(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color:
                                        const Color.fromARGB(255, 242, 169, 80),
                                  )),
                                  items: dropdownItems,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedDifficulty = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "LEVEL:",
                            style: GoogleFonts.robotoMono(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50))),
                              height: 50,
                              width: 70,
                              child: Center(
                                child: DropdownButton(
                                  underline: const SizedBox(),
                                  dropdownColor:
                                      const Color.fromARGB(255, 152, 94, 191),
                                  value: selectedQuestions,
                                  iconEnabledColor:
                                      const Color.fromARGB(255, 242, 169, 80),
                                  alignment: AlignmentDirectional.center,
                                  style: (GoogleFonts.robotoMono(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color:
                                        const Color.fromARGB(255, 242, 169, 80),
                                  )),
                                  items: dropdownQuestionsLimit,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedQuestions = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: GlobalButton(
                text: 'Create Quiz',
                onPressed: () {
                  String categoriesToPath = selectedCategories
                      .map((category) => category
                          .toLowerCase()
                          .replaceAll(' ', '_')
                          .replaceAll('&', 'and'))
                      .toList()
                      .join(',');
                  String difficultyToPath = selectedDifficulty.toLowerCase();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => QuestionPageWidget(
                              user: widget.user,
                              questions: getQuestions(categoriesToPath,
                                  selectedQuestions, difficultyToPath))));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
