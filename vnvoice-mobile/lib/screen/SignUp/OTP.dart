import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:vnvoicemobile/screen/SignUp/AuthenNow.dart';

class OTPScreen extends StatefulWidget {
  final String userId;
  final String email;
  final String username;

  const OTPScreen({
    Key? key,
    required this.email,
    required this.username,
    required this.userId
  }) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController _channelController = TextEditingController();
  List<String> otp = List.filled(6, '0');
  final TextEditingController otpController1 = TextEditingController();
  final TextEditingController otpController2 = TextEditingController();
  final TextEditingController otpController3 = TextEditingController();
  final TextEditingController otpController4 = TextEditingController();
  final TextEditingController otpController5 = TextEditingController();
  final TextEditingController otpController6 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Xác thực OTP",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black),
        ),
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:
                [
                  _textFieldOTP(first: true, last: false, controllerElement: otpController1),
                  _textFieldOTP(first: false, last: false, controllerElement: otpController2),
                  _textFieldOTP(first: false, last: false, controllerElement: otpController3),
                  _textFieldOTP(first: false, last: false, controllerElement: otpController4),
                  _textFieldOTP(first: false, last: false, controllerElement: otpController5),
                  _textFieldOTP(first: false, last: true, controllerElement: otpController6),
                ]
                ,
              ),
            ),

            InkWell(
              onTap: () async{
                List<String> otpNumber = [
                  otpController1.text,
                  otpController2.text,
                  otpController3.text,
                  otpController4.text,
                  otpController5.text,
                  otpController6.text
                ];
                final otp = otpNumber.join();
                try {
                  var signUpRes = await Amplify.Auth.confirmSignUp(username: widget.email, confirmationCode: otp);
                  if (signUpRes.isSignUpComplete) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context)=> AuthenNowScreen(email: widget.email, userId: widget.userId,)
                      ),
                    );
                  }
                } catch(error) {
                  debugPrint("Error $error");
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
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
                  child: const Text("Xác thực",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _textFieldOTP({required bool first, required bool last, required TextEditingController controllerElement}) {
    return Container(
      height: 70,
      child: AspectRatio(
        aspectRatio: 0.8,
        child: TextField(
          controller: controllerElement,
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.isEmpty && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical.center,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.redAccent),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}