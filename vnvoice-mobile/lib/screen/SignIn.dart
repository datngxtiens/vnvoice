import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

import '../Widgets/textFieldInput.dart';
import '../utils/utils.dart';
import 'Home/Home.dart';
import 'SignUp/UploadID.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
              Container(
              padding: EdgeInsets.symmetric(vertical: 100),
              child: const Text(
                "VNVoice",
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(218, 81, 82, 1)
                ),
              ),
          ),
          TextFieldInput(
              textEditingController: _usernameController,
              hintText: "Tên đăng nhập",
              textInputType: TextInputType.text,
              icon: Icon(Icons.person, color: Colors.black),
          ),

          const SizedBox(height: 40,),
          TextFieldInput(
              textEditingController: _passwordController,
              hintText: "Mật khẩu",
              textInputType: TextInputType.text,
              isPass: true,
              icon: Icon(Icons.security, color: Colors.black,),
          ),
          const SizedBox(height: 20,),

          Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text("Quên mật khẩu?",
                  style: TextStyle(
                      color: Colors.blueAccent
                  ),
                )
              ],
          ),
          // const Text("Quên mật khẩu?",
          //   style: TextStyle(
          //       color: Colors.lightBlue
          //   ),
          // ),

          const SizedBox(height: 20,),

          InkWell(
              onTap: () async{
                final email = _usernameController.text;
                final password = _passwordController.text;
                try {
                    final signInRes = await Amplify.Auth.signIn(username: email, password: password);
                    if(signInRes.isSignedIn) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context)=> const MobileScreenLayout()
                        ),
                      );
                    }
                } catch(e) {
                  print(e);
                  showSnackBar(":) leu leu nham pass", context);

                }

              },
              child: Container(
                child: const Text("Đăng nhập",
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
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
              ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Image.asset("assets/fb.png",
                    width: 50,
                    height: 50,
                  )
                ),
                const SizedBox(width: 10,),
                Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Image.asset("assets/google.png",
                      width: 50,
                      height: 50,
                    )
                ),
              ]
          ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text(
                      "Chưa có tài khoản ?",
                      style: TextStyle(
                          color: Colors.grey
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 30),
                  ),
                  const SizedBox(width: 10,),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context)=> UploadIDScreen(

                            )
                        ),
                      );
                    },
                    child: Container(
                      child: const Text("Đăng ký tại đây.", style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent),),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  )
                ],
              ),
              ],
          ),
            ),
        ),
      ),
    );
  }
}
