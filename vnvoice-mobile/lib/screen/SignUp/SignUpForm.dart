import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:vnvoicemobile/screen/SignUp/OTP.dart';
import 'package:vnvoicemobile/utils/utils.dart';

import '../../Widgets/textFieldInput.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignUpForm(),
    );
  }
}


class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _numberPhoneController = TextEditingController();
  final TextEditingController _CCCDController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _createAccountOnPressed() async {
    final email = _emailController.text;
    final password = _passwordController.text;

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
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context)=> OTPScreen(
                email: email,
              )
          ),
        );
      }
    } catch(e) {
      print("Error signup coginito ${e}");
    }
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
                  "Xác nhận danh tính thành công.Vui lòng điền các thông tin còn lại để hoàn tất quá trình thiết lập tài khoản",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      letterSpacing: 1.3,

                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: TextFieldInput(
                  textEditingController: _fullnameController,
                  hintText: "Họ và tên",
                  textInputType: TextInputType.text,
                  icon: Icon(Icons.person, color: Colors.black),
                  havePrefixIcon: false,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: TextFieldInput(
                  textEditingController: _CCCDController,
                  hintText: "Số CCCD",
                  textInputType: TextInputType.text,
                  icon: Icon(Icons.person, color: Colors.black),
                  havePrefixIcon: false,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: TextFieldInput(
                  textEditingController: _numberPhoneController,
                  hintText: "Số điện thoại",
                  textInputType: TextInputType.text,
                  icon: Icon(Icons.person, color: Colors.black),
                  havePrefixIcon: false,
                ),
              ),
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
                  hintText: "Tên đăng nhập",
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
                  child: const Text("Đăng ký",
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



