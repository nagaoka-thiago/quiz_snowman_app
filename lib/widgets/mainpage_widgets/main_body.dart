import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multiselect/multiselect.dart';
import '../global/global_button.dart';

class MainPageBody extends StatefulWidget {
  const MainPageBody({Key? key}) : super(key: key);

  @override
  State<MainPageBody> createState() => _MainPageBodyState();
}

class _MainPageBodyState extends State<MainPageBody> {
  var selectedDifficulty = "Easy";
  var selectedQuestions = "10";
  List<String> slectedCategories = [];
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
      const DropdownMenuItem(child: Text("Easy"), value: "Easy"),
      const DropdownMenuItem(child: Text("Medium"), value: "Medium"),
      const DropdownMenuItem(child: Text("Hard"), value: "Hard"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownQuestionsLimit {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("5"), value: "5"),
      const DropdownMenuItem(child: Text("10"), value: "10"),
      const DropdownMenuItem(child: Text("15"), value: "15"),
      const DropdownMenuItem(child: Text("20"), value: "20"),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 191, 126, 174),
      child: Expanded(
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
                  SizedBox(
                    width: 300,
                    child: DropDownMultiSelect(
                      onChanged: (List<String> x) {
                        setState(() {
                          slectedCategories = x;
                        });
                      },
                      options: categoryList,
                      selectedValues: slectedCategories,
                      whenEmpty: 'Categories',
                      decoration: InputDecoration(
                        filled: true,
                        iconColor: const Color.fromARGB(255, 242, 169, 80),
                        counterStyle: GoogleFonts.robotoMono(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50.0),
                            ),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 101, 48, 217),
                                width: 2)),
                        enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50.0),
                            ),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 101, 48, 217),
                                width: 2)),
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
                            child: SizedBox(
                              height: 50,
                              width: 100,
                              child: DropdownButton(
                                value: selectedDifficulty,
                                iconEnabledColor: const Color.fromARGB(255, 242, 169, 80),
                                alignment: AlignmentDirectional.center,
                                style: (GoogleFonts.robotoMono(
                                  fontWeight: FontWeight.normal,
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
                            child: SizedBox(
                              height: 50,
                              width: 50,
                              child: DropdownButton(
                                value: selectedQuestions,
                                iconEnabledColor: const Color.fromARGB(255, 242, 169, 80),
                                alignment: AlignmentDirectional.center,
                                style: (GoogleFonts.robotoMono(
                                  fontWeight: FontWeight.normal,
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
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
