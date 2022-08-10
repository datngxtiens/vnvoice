import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';

import '../../utils/utils.dart';
import 'StartFaceID.dart';

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
      home: UploadIDScreen(),
    );
  }
}


class UploadIDScreen extends StatefulWidget {
  const UploadIDScreen({Key? key}) : super(key: key);

  @override
  State<UploadIDScreen> createState() => _UploadIDScreenState();
}

class _UploadIDScreenState extends State<UploadIDScreen> {
  Uint8List? _file;

  _selectImage(BuildContext context) async {
    return showDialog(context: context, builder: (context){
      return SimpleDialog(
        title: const Text('Tải ảnh lên'),
        children: [
          SimpleDialogOption(
            padding: const EdgeInsets.all(20),
            child: const Text("Từ camera"),
            onPressed: () async{
              Navigator.of(context).pop();
              Uint8List file = await pickImage(ImageSource.camera);
              setState(() {
                _file = file;
              });
            },
          ),

          SimpleDialogOption(
            padding: const EdgeInsets.all(20),
            child: const Text("Từ thư viện ảnh"),
            onPressed: () async{
              Navigator.of(context).pop();
              Uint8List file = await pickImage(ImageSource.gallery);
              setState(() {
                _file = file;
              });
            },
          ),
        ],
      );
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

        body: Container(

          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children:  [
              const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    "Vui lòng tải ảnh thẻ căn cước công dân (hai mặt) để xác định danh tính",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black
                    ),
                  ),
              ),
              GestureDetector(
                onTap: () => _selectImage(context),
                child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height/4.5,
                      decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt),
                          Text(
                            "Mặt trước",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black
                            ),
                          ),
                        ],
                      ),
                    )
                ),
              ),

              GestureDetector(
                onTap: () => _selectImage(context),
                child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height/4.5,
                      decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt),
                          Text(
                            "Mặt sau",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black
                            ),
                          ),
                        ],
                      ),
                    )
                ),
              ),
              const SizedBox(height: 40,),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context)=> StartFaceIDScreen(

                        )
                    ),
                  );
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


            ],
          ),
        ),
    );
  }
}
