import 'package:flutter/material.dart';

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
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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

      body: Container(

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
                textEditingController: _fullnameController,
                hintText: "Số CCCD",
                textInputType: TextInputType.text,
                icon: Icon(Icons.person, color: Colors.black),
                havePrefixIcon: false,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: TextFieldInput(
                textEditingController: _fullnameController,
                hintText: "Số điện thoại",
                textInputType: TextInputType.text,
                icon: Icon(Icons.person, color: Colors.black),
                havePrefixIcon: false,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: TextFieldInput(
                textEditingController: _fullnameController,
                hintText: "Email",
                textInputType: TextInputType.text,
                icon: Icon(Icons.person, color: Colors.black),
                havePrefixIcon: false,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: TextFieldInput(
                textEditingController: _fullnameController,
                hintText: "Tên đăng nhập",
                textInputType: TextInputType.text,
                icon: Icon(Icons.person, color: Colors.black),
                havePrefixIcon: false,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: TextFieldInput(
                textEditingController: _fullnameController,
                hintText: "Mật khẩu",
                textInputType: TextInputType.text,
                icon: Icon(Icons.person, color: Colors.black),
                havePrefixIcon: false,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: TextFieldInput(
                textEditingController: _fullnameController,
                hintText: "Nhập lại mật khẩu",
                textInputType: TextInputType.text,
                icon: Icon(Icons.person, color: Colors.black),
                havePrefixIcon: false,
              ),
            ),
            const SizedBox(height: 40,),
            InkWell(
              onTap: () {},
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
    );
  }
}



