import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vnvoicemobile/screen/SignIn.dart';

class StandbyScreen extends StatefulWidget {
  const StandbyScreen({Key? key}) : super(key: key);

  @override
  State<StandbyScreen> createState() => _StandbyScreenState();
}

class _StandbyScreenState extends State<StandbyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _navigateToIntroduction(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          return Center(
            child: Container(
              child:Text("VNVoice", style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold), )
            ),
          );
        },
      ),
      backgroundColor: Color.fromRGBO(218, 81, 82, 1),
    );
  }

  Future<void> _navigateToIntroduction() async {
    await Future.delayed(const Duration(seconds: 5)).then((value) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context)=> const SignIn())
      );
    });
  }
}
