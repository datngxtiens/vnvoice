import 'dart:async';

import 'package:amplify_flutter/amplify_flutter.dart';
import "package:flutter/material.dart";
import 'package:vnvoicemobile/screen/SignIn.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

import 'amplifyconfiguration.dart';



void main () {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child:Main()));
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  bool _amplifyConfigured = false;
  AmplifyAuthCognito authCognito = AmplifyAuthCognito();

  StreamSubscription<HubEvent> hubSubscription = Amplify.Hub.listen([HubChannel.Auth], (hubEvent) {
    switch(hubEvent.eventName) {
      case 'SIGNED_IN':
        print('USER IS SIGNED IN');
        break;
      case 'SIGNED_OUT':
        print('USER IS SIGNED OUT');
        break;
      case 'SESSION_EXPIRED':
        print('SESSION HAS EXPIRED');
        break;
      case 'USER_DELETED':
        print('USER HAS BEEN DELETED');
        break;
    }
  });


  Future<void> _configAmplify() async {
    if(!_amplifyConfigured) {

    }
    try{
      await Amplify.addPlugins([
        authCognito
      ]);
      await Amplify.configure(amplifyconfig);
      print("configure");
      setState((){
        _amplifyConfigured = true;
      });
    } catch (e) {
      print("error: \n $e");

    }

  }
  @override
  void initState() {
    super.initState();
    _configAmplify();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignIn(),
      // home: StreamBuilder(
      //   stream: Amplify.Hub.,
      //   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {  },
      //
      // )
    );
  }
}
