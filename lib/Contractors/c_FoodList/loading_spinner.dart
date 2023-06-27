import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
       backgroundColor: Color(0xFF17181D),
        body: Center(
            child: SpinKitFadingCube( color: Color(0xFFE09145), size: 60.0)));
  }
}
