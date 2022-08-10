import 'package:flutter/material.dart';

import 'SignUpForm.dart';

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
      home: StartFaceIDScreen(),
    );
  }
}


class StartFaceIDScreen extends StatefulWidget {
  const StartFaceIDScreen({Key? key}) : super(key: key);

  @override
  State<StartFaceIDScreen> createState() => _StartFaceIDScreenState();
}

class _StartFaceIDScreenState extends State<StartFaceIDScreen> {


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
                "Hình ảnh thẻ căn cước hợp lệ. Bắt đầu tiến hành nhận diện khuân mặt",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black
                ),
              ),
            ),

            const SizedBox(height: 40,),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context)=> SignUpForm(

                      )
                  ),
                );
              },
              child: Container(
                child: const Text("Bắt đầu",
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



