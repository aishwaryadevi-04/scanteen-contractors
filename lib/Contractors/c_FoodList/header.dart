import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContractorHeader extends StatelessWidget {
  const ContractorHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 77, 16, 0),
          child: Text(
            'Frost Bite',
            style: GoogleFonts.inter(
              textStyle: const TextStyle(
                color: Color(0xFFFCD9B8),
              ),
              fontSize: 35,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Divider(
              color: const Color(0xFFBDBDBD).withOpacity(0.1),
              thickness: 1.0,
            ),
          ]),
        ),
      ],
    );
  }
}
