import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ContractorHeader extends StatefulWidget {
  ContractorHeader({super.key});

  @override
  State<ContractorHeader> createState() => _ContractorHeaderState();
}
String? contractorName = '';
 Future getContractorName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? contractorDetails = prefs.getString('contractor details');

    if (contractorDetails != null) {
      Map<String, dynamic> contractorData = jsonDecode(contractorDetails);
      contractorName = contractorData['contractorName'];
    }
  }
class _ContractorHeaderState extends State<ContractorHeader> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 77, 16, 0),
          child: Text(
            '$contractorName',
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
