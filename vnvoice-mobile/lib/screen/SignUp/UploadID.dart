import 'dart:typed_data';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import '../../utils/utils.dart';
import 'StartFaceID.dart';
import 'package:path_provider/path_provider.dart';



class UploadIDScreen extends StatefulWidget {
  const UploadIDScreen({Key? key}) : super(key: key);

  @override
  State<UploadIDScreen> createState() => _UploadIDScreenState();
}

class _UploadIDScreenState extends State<UploadIDScreen> {
  Uint8List? _fileFront;
  Uint8List? _fileBehind;
  int selected = 0;

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
                if(selected==1) {
                  _fileFront = file;
                } else if(selected==2) {
                  _fileBehind =file;
                }
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
                if(selected==1) {
                  _fileFront = file;
                } else if(selected==2) {
                  _fileBehind =file;
                }
              });
            },
          ),
        ],
      );
    });
  }

  Future<void> createAndUploadFile(Uint8List file1, Uint8List file2) async {

    // Upload the file to S3
    Uint8List imageInUnit8List = file1;// store unit8List image here ;
    final tempDir = await getTemporaryDirectory();
    File fileImg = await File('${tempDir.path}/image.png').create();
    fileImg.writeAsBytesSync(imageInUnit8List);

    Uint8List imageInUnit8List2 = file2;// store unit8List image here ;
    final tempDir2 = await getTemporaryDirectory();
    File fileImg2 = await File('${tempDir2.path}/image.png').create();
    fileImg2.writeAsBytesSync(imageInUnit8List2);

    try {
      final UploadFileResult result = await Amplify.Storage.uploadFile(
          local:fileImg ,
          key: 'a/ExampleKey1',
          onProgress: (progress) {
            print('Fraction completed: ${progress.getFractionCompleted()}');
          }
      );

      final UploadFileResult result2 = await Amplify.Storage.uploadFile(
          local:fileImg2 ,
          key: 'a/ExampleKey2',
          onProgress: (progress) {
            print('Fraction completed: ${progress.getFractionCompleted()}');
          }
      );
      print('Successfully uploaded file: ${result.key}');
    } on StorageException catch (e) {
      print('Error uploading file: $e');
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
                onTap: (){
                  setState((){
                    selected = 1;
                  });
                  _selectImage(context);
                },

                child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height/4.5,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: Color.fromRGBO(218, 81, 82, 1), width: 2)
                      ),
                      child: _fileFront==null?
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
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
                      ):Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: MemoryImage(_fileFront!),
                                    fit: BoxFit.fill
                                )
                            )
                        ),
                      ),
                    )
                ),
              ),

              GestureDetector(
                onTap: () {
                  setState((){
                    selected = 2;
                  });
                  _selectImage(context);
                },
                child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height/4.5,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: Color.fromRGBO(218, 81, 82, 1), width: 2),
                      ),
                      child: _fileBehind==null?Container(
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
                      ): Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: MemoryImage(_fileBehind!),
                                    fit: BoxFit.fill
                                  )
                                )),
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
                child: GestureDetector(
                  onTap: (){
                    createAndUploadFile(_fileFront!, _fileBehind!);
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
              ),
            ],
          ),
        ),
    );
  }
}
