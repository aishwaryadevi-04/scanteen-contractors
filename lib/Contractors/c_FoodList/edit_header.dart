import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 110, 0, 0),
              child: Text(
                'Edit item',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  textStyle: const TextStyle(
                    color: Color(0xFFFCD9B8),
                  ),
                  fontSize: 30,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 17),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 19, 16, 0),
              child: Text(
                'Please fill all the fields',
                style: GoogleFonts.inter(
                  textStyle: const TextStyle(
                    color: Color(0XFF757575),
                  ),
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
         Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Divider(
                      color: const Color(0xFFBDBDBD).withOpacity(0.1),
                      thickness: 1.0,
                    ),
                  ]),
            ),
            const SizedBox(height: 61),
      ],
    );
  }
}
