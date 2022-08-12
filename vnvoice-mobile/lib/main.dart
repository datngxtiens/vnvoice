import 'dart:async';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:vnvoicemobile/provider/userProvider.dart';
import 'package:vnvoicemobile/screen/SignIn.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:provider/provider.dart';


import 'amplifyconfiguration.dart';



void main () {
  WidgetsFlutterBinding.ensureInitialized();
  runApp((Main()));
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  bool _amplifyConfigured = false;
  AmplifyAuthCognito authCognito = AmplifyAuthCognito();
  AmplifyStorageS3 storage = AmplifyStorageS3();


  Future<void> _configAmplify() async {
    if(!_amplifyConfigured) {

    }
    try{
      await Amplify.addPlugins([
        authCognito, storage
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        
      ],
      child: MaterialApp(
        home: SignIn(),
        // home: StreamBuilder(
        //   stream: Amplify.Hub.,
        //   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {  },
        //
        // )
      ),
    );
  }
}
