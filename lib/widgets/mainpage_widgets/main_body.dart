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

  List<int> numberOfQuestion = [
    5,
    10,
    15,
    20,
  ];

  List<String> difficultyLevel = [
    "Easy",
    "Medium",
    "Hard",
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
              padding: const EdgeInsets.all(24),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('lib/Assets/ideas.png'))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: DropDownMultiSelect(
                  onChanged: (List<String> x) {
                    setState(() {
                      slectedCategories = x;
                    });
                  },
                  options: categoryList,
                  selectedValues: slectedCategories,
                  whenEmpty: 'Select Something'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Difficulty:",style: GoogleFonts.robotoMono(fontWeight: FontWeight.bold, fontSize: 20, color: const Color.fromARGB(255, 242, 169, 80))),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: SizedBox(
                        height: 50,
                        width: 100,
                        child: DropdownButton(
                          value: selectedDifficulty,
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
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    height: 50,
                    width: 100,
                    child: DropdownButton(
                      value: selectedQuestions,
                      items: dropdownQuestionsLimit,
                      onChanged: (String? newValue) {
                        setState(
                          () {
                            selectedQuestions = newValue!;
                          },
                        );
                      },
                      enableFeedback: true,
                      iconEnabledColor: Colors.red,

                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(24),
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
