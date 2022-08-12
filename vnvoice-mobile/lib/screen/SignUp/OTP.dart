import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:vnvoicemobile/screen/SignUp/AuthenNow.dart';

import '../../Widgets/textFieldInput.dart';
import '../Home/Home.dart';

class OTPScreen extends StatefulWidget {
  final email;
  const OTPScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController _channelController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Xác thực OTP", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Color.fromRGBO(218, 81, 82, 1),),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: TextFieldInput(
                  textEditingController: _channelController,
                  hintText: "Nhập mã xác thực",
                  textInputType: TextInputType.text,
                  icon: Icon(Icons.person, color: Colors.black),
                  havePrefixIcon: false,
                ),
              ),
              InkWell(
                onTap: () async{
                  final otp = _channelController.text;
                  try {
                    var signUpRes = await Amplify.Auth.confirmSignUp(username: widget.email, confirmationCode: otp);
                    if(signUpRes.isSignUpComplete) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context)=> AuthenNowScreen()
                        ),
                      );
                    }
                  } catch(error) {

                  };
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: const Text("Xác thực",
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
