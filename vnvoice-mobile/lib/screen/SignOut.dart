import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vnvoicemobile/models/response.dart';
import 'package:vnvoicemobile/provider/userProvider.dart';
import 'package:vnvoicemobile/requests/users.dart';
import 'package:vnvoicemobile/screen/SignIn.dart';
import 'package:vnvoicemobile/screen/SignUp/SignUpForm.dart';

import 'package:vnvoicemobile/Widgets/textFieldInput.dart';
import 'package:vnvoicemobile/models/user.dart';
import 'package:vnvoicemobile/utils/utils.dart';
import 'package:vnvoicemobile/screen/Home/Home.dart';

class SignOut extends StatefulWidget {
  const SignOut({Key? key}) : super(key: key);

  @override
  State<SignOut> createState() => _SignOutState();
}

class _SignOutState extends State<SignOut> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    late Future<UserInfoResponse> futureResponse;
    final UserProvider userProvider = Provider.of<UserProvider>(context);


    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                const SizedBox(height: 20,),
                InkWell(
                  onTap: () async{
                    setState(() {
                      _isLoading = true;
                    });

                    try {
                      await Amplify.Auth.signOut();
                      userProvider.user = null;

                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context)=> const SignIn()
                        ),
                      );
                    } catch(e) {
                      debugPrint(e.toString());
                    }
                    setState(() {
                      _isLoading = false;
                    });

                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 22),
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(40),
                        ),
                      ),
                      color: Color.fromRGBO(218, 81, 82, 1),
                    ),
                    child: _isLoading? const Center(child: CircularProgressIndicator(color: Colors.white,),):const Text("Dang xuat",
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
