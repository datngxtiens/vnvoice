import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vnvoicemobile/models/response.dart';
import 'package:vnvoicemobile/provider/userProvider.dart';
import 'package:vnvoicemobile/requests/users.dart';
import 'package:vnvoicemobile/screen/SignUp/SignUpForm.dart';

import 'package:vnvoicemobile/Widgets/textFieldInput.dart';
import 'package:vnvoicemobile/models/user.dart';
import 'package:vnvoicemobile/utils/utils.dart';
import 'package:vnvoicemobile/screen/Home/Home.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    late Future<UserInfoResponse> futureResponse;
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    User currentUser;

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
              padding: const EdgeInsets.symmetric(vertical: 100),
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
              icon: const Icon(Icons.person, color: Colors.black),
          ),

          const SizedBox(height: 40,),
          TextFieldInput(
              textEditingController: _passwordController,
              hintText: "Mật khẩu",
              textInputType: TextInputType.text,
              isPass: true,
              icon: const Icon(Icons.security, color: Colors.black,),
          ),
          const SizedBox(height: 20,),

          Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text("Quên mật khẩu?",
                  style: TextStyle(
                      color: Colors.blueAccent
                  ),
                )
              ],
          ),
          const SizedBox(height: 20,),
          InkWell(
              onTap: () async{
                setState(() {
                  _isLoading = true;
                });

                final email = _usernameController.text;
                final password = _passwordController.text;

                try {
                    await Amplify.Auth.signOut();
                    final signInRes = await Amplify.Auth.signIn(username: email, password: password);
                    final res = await Amplify.Auth.fetchAuthSession(
                      options: CognitoSessionOptions(getAWSCredentials: true)
                    );

                    if (signInRes.isSignedIn) {
                      final session = res as CognitoAuthSession;
                      debugPrint("TOKEN FROM THE COGNITO: ${session.userPoolTokens!.accessToken}");

                      futureResponse = signInUser(email, password);

                      futureResponse.then((result) {
                        if (result.message != "Đăng nhập không thành công") {
                          currentUser = User(
                              userId: result.userId,
                              imgUrl: result.imgUrl!,
                              username: result.username,
                              role: result.role
                          );
                          
                          userProvider.setUser(currentUser);

                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context)=> const HomeScreenLayout()
                            ),
                          );
                        } else {
                          showSnackBar("Tên đăng nhập hoặc mật khẩu không chính xác", context);
                        }
                      });
                    }
                } catch(e) {
                  debugPrint(e.toString());
                  showSnackBar("Tên đăng nhập hoặc mật khẩu không hợp lệ", context);
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
                child: _isLoading? const Center(child: CircularProgressIndicator(color: Colors.white,),):const Text("Đăng nhập",
                  style: TextStyle(
                      color: Colors.white
                  ),
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
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: const Text(
                      "Chưa có tài khoản ?",
                      style: TextStyle(
                          color: Colors.grey
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context)=> const SignUpForm(

                            )
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text("Đăng ký tại đây.", style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent),),
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
