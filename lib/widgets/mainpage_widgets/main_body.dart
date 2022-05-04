import 'package:flutter/material.dart';

import '../global/global_button.dart';

class MainPageBody extends StatefulWidget {
  const MainPageBody({Key? key}) : super(key: key);

  @override
  State<MainPageBody> createState() => _MainPageBodyState();
}

class _MainPageBodyState extends State<MainPageBody> {
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
            const Padding(
              padding: EdgeInsets.all(16),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
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
