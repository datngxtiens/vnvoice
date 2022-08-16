import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vnvoicemobile/provider/userProvider.dart';
import 'package:vnvoicemobile/screen/SignIn.dart';
import 'package:vnvoicemobile/screen/Home/Home.dart';

import 'package:provider/provider.dart';

class StandbyScreen extends StatefulWidget {
  const StandbyScreen({Key? key}) : super(key: key);

  @override
  State<StandbyScreen> createState() => _StandbyScreenState();
}

class _StandbyScreenState extends State<StandbyScreen> {

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: FutureBuilder(
        future: _navigateToIntroduction(userProvider),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          return const Center(
            child: Text(
              "VNVoice",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.bold),
            ),
          );
        },
      ),
      backgroundColor: const Color.fromRGBO(218, 81, 82, 1),
    );
  }

  Future<void> _navigateToIntroduction(UserProvider userProvider) async {
    await Future.delayed(const Duration(seconds: 5)).then((value) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) {
          if (userProvider.isSignedIn()) {
            return const HomeScreenLayout();
          } else {
            return const SignIn();
          }
        })
      );
    });
  }
}
