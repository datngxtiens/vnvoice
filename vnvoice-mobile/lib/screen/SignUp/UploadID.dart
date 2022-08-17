import 'dart:convert';
import 'dart:typed_data';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:vnvoicemobile/requests/citizens.dart';
import 'package:vnvoicemobile/screen/SignUp/AuthenNow.dart';
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
  XFile? _fileFront;
  XFile? _fileBehind;
  int selected = 0;
  bool _isLoading = false;
  var uuid = const Uuid();


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
              XFile file = await pickImageXfile(ImageSource.camera);
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
              XFile file = await pickImageXfile(ImageSource.gallery);
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

  Future<void> createAndUploadFile(XFile file1, XFile file2) async {

    // Upload the file to S3
    setState((){
      _isLoading = true;
    });

    // Uint8List imageInUnit8List_front = file1;// store unit8List image here ;
    // final tempDir_front = await getTemporaryDirectory();
    // File fileImg_front = await File('${tempDir_front.path}/image_front.png').create();
    // fileImg_front.writeAsBytesSync(imageInUnit8List_front);
    File fileImg_front =  File(file1.path);
    File fileImg_back = File(file2.path);
    // Uint8List imageInUnit8List_back = file2;// store unit8List image here ;
    // final tempDir_back = await getTemporaryDirectory();
    // File fileImg_back = await File('${tempDir_back.path}/image_back.png').create();
    // fileImg_back.writeAsBytesSync(imageInUnit8List_back);


    try {
      var imageId = uuid.v1();
      final UploadFileResult result_front = await Amplify.Storage.uploadFile(
          local: fileImg_front,
          key: 'cardId/${imageId}_front',
          onProgress: (progress) {
            debugPrint('Fraction completed: ${progress.getFractionCompleted()}');
          }
      );

      final UploadFileResult result_back = await Amplify.Storage.uploadFile(
          local: fileImg_back,
          key: 'cardId/${imageId}_back',
          onProgress: (progress) {
            debugPrint('Fraction completed: ${progress.getFractionCompleted()}');
          }
      );
      debugPrint('Successfully uploaded file: ${result_front.key}');

      final response = getCitizenId(imageId.toString());
      
      response.then((result) {
        if (result.statusCode == 200) {
          Map<String, dynamic> data = jsonDecode(result.body);
          String citizenId = data["citizen_id"];

          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => StartFaceIDScreen(citizenId: citizenId,)
            ),
          );
        } else {
          showSnackBar("Hệ thống không thể nhận dạng. Vui lòng thử lại.", context);
        }
      });
    } on StorageException catch (e) {
      debugPrint('Error uploading file: $e');
    }
    setState((){
      _isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {

      return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text(
              "Xác thực căn cước công dân",
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
                          border: Border.all(color: const Color.fromRGBO(218, 81, 82, 1), width: 2)
                      ),
                      child: _fileFront==null?
                      Column(
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
                      ):Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: FileImage(File(_fileFront!.path)),
                                    fit: BoxFit.cover
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
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: const Color.fromRGBO(218, 81, 82, 1), width: 2),
                      ),
                      child: _fileBehind==null?Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.camera_alt),
                          Text(
                            "Mặt sau",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black
                            ),
                          ),
                        ],
                      ): Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: FileImage(File(_fileBehind!.path)),
                                    fit: BoxFit.cover
                                  )
                                )),
                          ),
                    )
                ),
              ),

              const SizedBox(height: 40,),
              InkWell(
                onTap: () {

                },
                child: GestureDetector(
                  onTap: (){
                    createAndUploadFile(_fileFront!, _fileBehind!);
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
                    child: _isLoading? const Center(child: CircularProgressIndicator(color: Colors.white,),):const Text("Xác thực",
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
}
