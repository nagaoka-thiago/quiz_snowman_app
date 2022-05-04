import 'package:flutter/material.dart';

import '../widgets/loginpage_widgets/login_page_body.dart';

class LoginPageWidget extends StatelessWidget {
  const LoginPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(body: LoginPageBodyWidget()),
    );
  }
}
