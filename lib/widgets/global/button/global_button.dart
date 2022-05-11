import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'button_status.dart';

class GlobalButton extends StatefulWidget {
  final Function() onPressed;
  final ButtonStatus? status;
  final String text;
  const GlobalButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      this.status = ButtonStatus.idle})
      : super(key: key);

  @override
  State<GlobalButton> createState() => _GlobalButtonState();
}

class _GlobalButtonState extends State<GlobalButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: _handleButtonColor(widget.status!),
          minimumSize: const Size(250, 70)),
      onPressed: widget.onPressed,
      child: AutoSizeText(
        widget.text,
        textAlign: TextAlign.center,
        minFontSize: 20,
        style:
            GoogleFonts.robotoMono(fontWeight: FontWeight.bold),
      ),
    );
  }
}

Color _handleButtonColor(ButtonStatus status) {
  switch (status) {
    case ButtonStatus.correct:
      return const Color.fromARGB(255, 0, 78, 3);
    case ButtonStatus.wrong:
      return const Color.fromARGB(255, 93, 6, 0);
    case ButtonStatus.idle:
      return const Color.fromARGB(255, 101, 48, 217);
  }
}
