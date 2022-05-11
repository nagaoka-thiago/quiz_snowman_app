import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
          fixedSize: const Size(250, 70)),
      onPressed: widget.onPressed,
      child: Text(
        widget.text,
        style:
            GoogleFonts.robotoMono(fontWeight: FontWeight.bold, fontSize: 32),
      ),
    );
  }
}

Color _handleButtonColor(ButtonStatus status) {
  switch (status) {
    case ButtonStatus.correct:
      return Colors.green;
    case ButtonStatus.wrong:
      return Colors.red;
    case ButtonStatus.idle:
      return const Color.fromARGB(255, 101, 48, 217);
  }
}
