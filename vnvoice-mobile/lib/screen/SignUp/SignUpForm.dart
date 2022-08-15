import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:vnvoicemobile/models/response.dart';
import 'package:vnvoicemobile/requests/users.dart';
import 'package:vnvoicemobile/screen/SignUp/AuthenNow.dart';
import 'package:vnvoicemobile/screen/SignUp/OTP.dart';
import 'package:vnvoicemobile/utils/utils.dart';

import '../../Widgets/textFieldInput.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);


  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool _isLoading = false;
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _numberPhoneController = TextEditingController();
  final TextEditingController _CCCDController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _createAccountOnPressed() async {
    setState(() {
      _isLoading = true;
    });
    final email = _emailController.text;
    final password = _passwordController.text;
    final username = _usernameController.text;

    print("Start sign up ${email} - ${password}");
    var signUpResult = await Amplify.Auth.signUp(
        username: email,
        password: password,
        options: CognitoSignUpOptions(
          userAttributes: {
            CognitoUserAttributeKey.email: email
          }
        )
    );
    print("Done sign up ${signUpResult}");
    try {
      if (signUpResult.isSignUpComplete) {
        Future<UserInfoResponse> userInfo = createAccount(email, username, password);

        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context)=> OTPScreen(
                email: email,
                username: username
              )
          ),
        );
      }
    } catch(e) {
      print("Error signup coginito ${e}");
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          "Đăng ký",
          style: TextStyle(
              fontSize: 30,
              color: Colors.black,
              fontWeight: FontWeight.bold
          ),
        ),
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
            icon: Icon(Icons.arrow_back, color:Color.fromRGBO(218, 81, 82, 1))),
        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
      ),

      body: SingleChildScrollView(
        child: Container(

          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children:  [
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  "Vui lòng điền các thông tin để hoàn tất quá trình thiết lập tài khoản",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      letterSpacing: 1.3,

                  ),
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.only(top: 20),
              //   child: TextFieldInput(
              //     textEditingController: _fullnameController,
              //     hintText: "Họ và tên",
              //     textInputType: TextInputType.text,
              //     icon: Icon(Icons.person, color: Colors.black),
              //     havePrefixIcon: false,
              //   ),
              // ),
              // Padding(
              //   padding: EdgeInsets.only(top: 20),
              //   child: TextFieldInput(
              //     textEditingController: _CCCDController,
              //     hintText: "Số CCCD",
              //     textInputType: TextInputType.text,
              //     icon: Icon(Icons.person, color: Colors.black),
              //     havePrefixIcon: false,
              //   ),
              // ),
              // Padding(
              //   padding: EdgeInsets.only(top: 20),
              //   child: TextFieldInput(
              //     textEditingController: _numberPhoneController,
              //     hintText: "Số điện thoại",
              //     textInputType: TextInputType.text,
              //     icon: Icon(Icons.person, color: Colors.black),
              //     havePrefixIcon: false,
              //   ),
              // ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: TextFieldInput(
                  textEditingController: _emailController,
                  hintText: "Email",
                  textInputType: TextInputType.text,
                  icon: Icon(Icons.person, color: Colors.black),
                  havePrefixIcon: false,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: TextFieldInput(
                  textEditingController: _usernameController,
                  hintText: "Tên người dùng",
                  textInputType: TextInputType.text,
                  icon: Icon(Icons.person, color: Colors.black),
                  havePrefixIcon: false,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: TextFieldInput(
                  textEditingController: _passwordController,
                  hintText: "Mật khẩu",
                  textInputType: TextInputType.text,
                  icon: Icon(Icons.person, color: Colors.black),
                  havePrefixIcon: false,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: TextFieldInput(
                  textEditingController: _passwordController,
                  hintText: "Nhập lại mật khẩu",
                  textInputType: TextInputType.text,
                  icon: Icon(Icons.person, color: Colors.black),
                  havePrefixIcon: false,
                ),
              ),
              const SizedBox(height: 40,),
              InkWell(
                onTap: _createAccountOnPressed,
                child: Container(
                  child: _isLoading? const Center(child: CircularProgressIndicator(color: Colors.white,),):const Text("Đăng ký",
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
            ],
          ),
        ),
      ),
    );
  }
}



