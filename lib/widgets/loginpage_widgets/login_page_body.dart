import 'package:flutter/material.dart';

class LoginPageBodyWidget extends StatelessWidget {
  const LoginPageBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 191, 126, 174),
      child: Expanded(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(40),
              child: Container(
                height: 200,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('lib/Assets/ideas.png'))),
              ),
            ),
            const TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Type your e-mail"))
          ],
        ),
      ),
    );
  }
}
