import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ShowSnackBar(message, context) {
  final snackBar = SnackBar(
    backgroundColor: Colors.black54,
    elevation: 3,
    duration: Duration(seconds: 3),
    content: Text(
      message,
      style: GoogleFonts.notoSans(
        textStyle: TextStyle(
          fontSize: 16.5,
          fontWeight: FontWeight.bold,
          foreground: Paint()
            ..shader = LinearGradient(colors: [
              Colors.pinkAccent,
              Colors.deepPurpleAccent,
              Colors.red,
            ]).createShader(
              Rect.fromLTWH(5.0, 5.0, 200.0, 50.0),
            ),
        ),
      ),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
