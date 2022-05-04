import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GlobalButton extends StatefulWidget {
  final Function() onPressed;
  final String text;
  const GlobalButton({Key? key, required this.onPressed, required this.text})
      : super(key: key);

  @override
  State<GlobalButton> createState() => _GlobalButtonState();
}

class _GlobalButtonState extends State<GlobalButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: const Color.fromARGB(255, 116, 63, 191),
          fixedSize: const Size(250, 70)),
      onPressed: widget.onPressed,
      child: Text(
        widget.text,
        style: GoogleFonts.robotoMono(fontWeight: FontWeight.bold, fontSize: 32),
      ),
    );
  }
}
