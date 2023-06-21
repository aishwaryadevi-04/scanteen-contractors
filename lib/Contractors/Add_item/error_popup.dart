import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ErrorPopup extends StatefulWidget {
  const ErrorPopup({super.key});

  @override
  State<ErrorPopup> createState() => _ErrorPopupState();
}

class _ErrorPopupState extends State<ErrorPopup> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0XFF2B2B2B),
      content: Container(
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Food already exists!',
              style: GoogleFonts.inter(
                textStyle: const TextStyle(
                  color: Color(0xFFFCD9B8),
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            child: Text(
              'OK',
              style: GoogleFonts.inter(
                textStyle: const TextStyle(
                  color: Color(0xFFE09145),
                  fontSize: 18,
                ),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }
}
