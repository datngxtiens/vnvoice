import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'CameraFaceID.dart';

class StartFaceIDScreen extends StatefulWidget {
  final String citizenId;

  const StartFaceIDScreen({Key? key, required this.citizenId}) : super(key: key);

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
              fontSize: 25,
              color: Colors.black,
              fontWeight: FontWeight.bold
          ),
        ),
        leading: IconButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back, color:Color.fromRGBO(218, 81, 82, 1))),
        backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
      ),

      body: Container(

        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children:  [
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "Hình ảnh thẻ căn cước hợp lệ. Bắt đầu tiến hành nhận diện khuôn mặt",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black
                ),
              ),
            ),

            const SizedBox(height: 40,),
            InkWell(
              onTap: () async {
                final cameras = await availableCameras();
                final frontCamera = cameras[1];

                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => (
                          TakePictureScreen(
                              camera: frontCamera,
                              citizenId: widget.citizenId
                          )
                      )
                  ),
                );
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
                child: const Text("Bắt đầu",
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}



