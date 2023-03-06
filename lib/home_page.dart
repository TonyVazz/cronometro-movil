import 'package:flutter/material.dart';

import 'cronometro.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.yellow,
          body: Center(
            child: Container(
              alignment: Alignment.center,
              child: Cronometro(),
            ),
          )),
    );
  }
}
