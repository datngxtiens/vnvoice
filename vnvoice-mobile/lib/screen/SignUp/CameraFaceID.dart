import 'dart:async';
import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:vnvoicemobile/requests/citizens.dart';
import 'package:vnvoicemobile/screen/SignIn.dart';
import 'package:vnvoicemobile/utils/utils.dart';

Future<String> createAndUploadFile(String citizenId, String path) async {
  // Upload the file to S3
  try {
      File fileImg =  File(path);

      String linkToImage = "faceIdAuthen/$citizenId";
      final UploadFileResult result = await Amplify.Storage.uploadFile(
          local:fileImg ,
          key: linkToImage,
          onProgress: (progress) {
            debugPrint('Fraction completed: ${progress.getFractionCompleted()}');
          }
      );
      debugPrint('Successfully uploaded file: $linkToImage');
      return "Success";
  } on StorageException catch (e) {
    debugPrint('Error uploading file: $e');
    return "Failed";
  }
}
// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  final String citizenId;

  const TakePictureScreen({
    super.key,
    required this.camera,
    required this.citizenId
  });

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Take a picture')),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return Container(
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top:100.0, right:50, left:50, bottom: 100),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(600)),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: CameraPreview(_controller),
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });

                        try {
                          // Ensure that the camera is initialized.
                          await _initializeControllerFuture;

                          // Attempt to take a picture and get the file `image`
                          // where it was saved.
                          final image = await _controller.takePicture();

                          if (!mounted) return;

                          // If the picture was taken, display it on a new screen.
                          showSnackBar("Vui lòng đợi trong giây lát", context);
                          final check = createAndUploadFile(widget.citizenId, image.path);

                          check.then((value) {
                            if (value == "Success") {
                              setState(() {
                                isLoading = false;
                              });
                              final response = compareFaces(widget.citizenId);

                              response.then((value) {
                                if (value.statusCode == 200) {
                                  showSnackBar("Xác thực thành công. Vui lòng đăng nhập lại.", context);
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context)=> const SignIn(

                                        )
                                    ),
                                  );
                                } else {
                                  showSnackBar("Xác thực không thành công. Vui lòng thử lại.", context);
                                  return;
                                }
                              });
                            }
                          });

                        } catch (e) {
                          // If an error occurs, log the error to the console.
                          debugPrint(e.toString());
                        }
                      },
                      color: const Color.fromRGBO(218, 81, 82, 1),
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(30),
                      shape: const CircleBorder(),
                      child:  const Icon(
                        Icons.camera_alt_outlined,
                        size: 20,
                      ),
                    ),

                  ],
                )
            );
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}