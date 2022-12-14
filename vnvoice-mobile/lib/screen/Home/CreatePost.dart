import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:vnvoicemobile/models/post.dart';
import 'package:vnvoicemobile/requests/channels.dart';
import 'package:vnvoicemobile/requests/posts.dart';
import 'package:vnvoicemobile/screen/Home/Home.dart';
import 'package:vnvoicemobile/screen/Home/PostTo.dart';


import 'package:vnvoicemobile/models/channel.dart';

import '../../models/user.dart';
import '../../provider/userProvider.dart';
import '../../utils/utils.dart';

class CreatePostScreen extends StatefulWidget {

  const CreatePostScreen({
    Key? key
  }) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final FocusNode _focusNode = FocusNode();
  final FocusNode _desFocusNode = FocusNode();
  final FocusNode _linkFocusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _desController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();
  List<Widget> functionComponent = [];
  int selectedFunction = 0;

  bool _isLoading = false;

  List<Channel> channels = [];

  late Future<ChannelList> futureChannel;

  String nameChannel = "Chọn kênh";
  String channelId = "";
  String postType = "";

  Uint8List? _file;
  List<Uint8List> listFile=[];
  var uuid = const Uuid();

  List<String> listImg = [];

  @override
  void initState() {
    super.initState();
    futureChannel = getAllChannel();

    listImg = [];

    futureChannel.then((value) {
      setState(() {
        channels = value.channels;
      });
    });

    _focusNode.addListener(() {
      debugPrint("Focus: ${_focusNode.hasFocus.toString()}");
    });
    _desFocusNode.addListener(() {
      debugPrint("_desFocusNode: ${_focusNode.hasFocus.toString()}");
    });
    _linkFocusNode.addListener(() {
      debugPrint("_linkFocusNode: ${_focusNode.hasFocus.toString()}");
    });
  }

  _selectImage(BuildContext context) async {
    return showDialog(context: context, builder: (context){
      return SimpleDialog(
        title: const Text('Thêm hình ảnh'),
        children: [
          SimpleDialogOption(
            padding: const EdgeInsets.all(20),
            child: const Text("Chụp ảnh"),
            onPressed: () async{
              Navigator.of(context).pop();
              Uint8List file = await pickImage(ImageSource.camera);
              setState(() {
                listFile.add(file);
                _file = listFile[0];
              });
            },
          ),

          SimpleDialogOption(
            padding: const EdgeInsets.all(20),
            child: const Text("Chọn từ kho ảnh"),
            onPressed: () async{
              Navigator.of(context).pop();
              List<Uint8List> file = await pickImages(ImageSource.gallery);
              setState(() {
                _file = file[0];
                listFile.addAll(file);
              });
            },
          ),
        ],
      );
    });
  }

  Future<String> createPostAndUploadFile(List<Uint8List> list, User? currentUser) async {
    // Upload the file to S3
    try {
      for (int i = 0; i < list.length; i++) {
        Uint8List imageInUnit8List = list[i];// store unit8List image here ;
        final tempDir = await getTemporaryDirectory();
        File fileImg = await File('${tempDir.path}/image.png').create();
        fileImg.writeAsBytesSync(imageInUnit8List);
        var uuidImg = uuid.v1();
        String linkToImage = "postImg/$uuidImg";
        final UploadFileResult result = await Amplify.Storage.uploadFile(
            local:fileImg ,
            key: linkToImage,
            onProgress: (progress) {
              debugPrint('Fraction completed: ${progress.getFractionCompleted()}');
            }
        );

        String url = "https://faceid65548-staging.s3.amazonaws.com/public/$linkToImage";
        debugPrint("New URL: $url");
        listImg.add(url);
      }
      return "Success";
    } on StorageException catch (e) {
      debugPrint('Error uploading file: $e');
      return "Failed";
    }
  }

  @override
  Widget build(BuildContext context) {
    User? currentUser = Provider.of<UserProvider>(context).getUser();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tạo bài viết", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
            icon: const Icon(Icons.close, color: Colors.grey,),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Container(
                color: Colors.blueAccent,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: _isLoading ?
                        const Color.fromRGBO(220,220,220, 1) :
                        const Color.fromRGBO(218, 81, 82, 1),
                    minimumSize: const Size(110.0, 10.0)
                  ),
                  child: _isLoading ?
                    const Text("Đang tải...", style: TextStyle(color: Colors.white),) :
                    const Text("Đăng tải", style: TextStyle(color: Colors.white),),
                  onPressed: () {
                    if (_isLoading) {
                      return;
                    }

                    setState(() {
                      _isLoading = true;
                    });

                    final check = createPostAndUploadFile(listFile, currentUser);

                    check.then((value) {
                      if (value == "Success") {
                        if (channelId == "") {
                          showSnackBar("Hãy chọn một kênh để đăng bài viết này", context);
                          return;
                        }

                        if (selectedFunction == 1) {
                          postType = "petition";
                        } else if (selectedFunction == 2) {
                          postType = "survey";
                        } else if (selectedFunction == 3) {
                          postType = "text";
                        }

                        if (postType == "") {
                          showSnackBar("Hãy chọn một loại bài viết", context);
                          return;
                        }

                        final newPost = PostBasicInfo(
                            authorId: currentUser!.userId,
                            channelId: channelId,
                            title: _controller.text,
                            text: _desController.text,
                            surveyUrl: _linkController.text,
                            imgUrls: listImg
                        );

                        String jsonBody = jsonEncode(newPost);

                        debugPrint(jsonBody);

                        final response = createPost(postType, jsonBody);

                        response.then((value) {
                          setState(() {
                            _isLoading = false;
                          });

                          if (value.statusCode == 200) {
                            showSnackBar("Tạo bài đăng thành công", context);
                            Navigator.of(context).pop(
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreenLayout()
                                )
                            );
                          }
                        });
                      }
                    });
                  },
                ),
              ),
            ),
          ),

        ],
      ),
      body:SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap:() async {
                      final res = await Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PostToScreen(
                              channels: channels,
                              nameChannel: nameChannel,
                              channelId: channelId,
                          )
                      ));

                      final response = json.decode(res);

                      setState(() {
                        nameChannel = response["channelName"];
                        channelId = response["channelId"];
                      });

                    },
                    child: Container(
                      color: Colors.white,
                      child: Row(
                        children: [
                          const SizedBox(width: 5,),
                          Text(nameChannel),
                          IconButton(
                              onPressed: (){},
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.redAccent,
                              )
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Tiêu đề"
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      minLines: 2,
                      focusNode: _focusNode,
                      controller: _controller,
                      cursorColor: const Color.fromRGBO(218, 81, 82, 1),
                      style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  selectedFunction == 2 ? Container(
                    color: Colors.white,
                    child: TextFormField(
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Đường dẫn"
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: 2,
                      minLines: 1,
                      focusNode: _linkFocusNode,
                      controller: _linkController,
                      cursorColor: const Color.fromRGBO(218, 81, 82, 1),
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                    ),
                  ) : Container(),
                  // Anh
                  selectedFunction >= 3 ? Container(
                    color: Colors.white,
                    height: 104,
                    child: ListView.builder(
                        itemCount: listFile.length + 1,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) {
                          return index!=listFile.length ? Container(
                            margin: const EdgeInsets.only(right: 30),
                            child: Stack(
                              children: [
                                Container(
                                  //margin: const EdgeInsets.only(right:50),
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    image: DecorationImage(
                                        image: MemoryImage(listFile[index]),
                                        fit: BoxFit.cover
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: (){
                                      setState((){
                                        listFile.removeAt(index);
                                      });
                                    },
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: CircleAvatar(
                                        radius: 14.0,
                                        backgroundColor: Colors.white.withOpacity(0.5),
                                        child: const Icon(Icons.close, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ) : GestureDetector(
                            onTap:() {
                              _selectImage(context);
                            },
                            child: DottedBorder(
                              dashPattern: const [6, 3],
                              strokeCap: StrokeCap.square,
                              color: Colors.black,
                              strokeWidth: 1,
                              child: const SizedBox(
                                height: 100,
                                width: 100,
                                child: Center(
                                  child: Icon(Icons.add),
                                ),
                              ),
                            ),
                          );
                        }
                    ),
                  ) : Container(),
                  // noi dung
                  selectedFunction != 0 ? Container(
                    color: Colors.white,
                    child: TextFormField(
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Nội dung"
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: 20,
                      minLines: 15,
                      focusNode: _desFocusNode,
                      controller: _desController,
                      cursorColor: const Color.fromRGBO(218, 81, 82, 1),
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                    ),
                  ) : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        // padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)),
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: const EdgeInsets.all(10),
          height: _focusNode.hasFocus? 120 : 150,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              !_focusNode.hasFocus? const Align(
                alignment: Alignment.center,
                child: Text("Bạn đang nghĩ gì?",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)
              ):Container(),
              const SizedBox(height: 15,),
              Table(
                columnWidths: {
                  4: FixedColumnWidth(_focusNode.hasFocus?15:15)
                },
                children: [
                  TableRow(
                    children: [
                      Column(
                        children: [
                          MaterialButton(
                            onPressed: () {
                              // FocusScope.of(context).unfocus();
                              // _controller.clear();
                              setState((){
                                selectedFunction = 1;
                              });

                            },
                            color: selectedFunction != 1 ? Colors.white70 : const Color.fromRGBO(218, 81, 82, 1),
                            textColor: selectedFunction==1?Colors.white:Colors.black,
                            padding: const EdgeInsets.all(15),
                            shape: const CircleBorder(),
                            child: const Icon(
                              Icons.text_fields,
                              size: 20,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top:8.0),
                            child: Text("Đơn kiến nghị"),
                          )
                        ],
                      ),

                      Column(
                        children: [
                          MaterialButton(
                            onPressed: () {
                              // FocusScope.of(context).unfocus();
                              // _controller.clear();
                              setState((){
                                selectedFunction =2;
                              });

                            },
                            color: selectedFunction!=2?Colors.white70:const Color.fromRGBO(218, 81, 82, 1),
                            textColor: selectedFunction==2?Colors.white:Colors.black,
                            padding: const EdgeInsets.all(15),
                            shape: const CircleBorder(),
                            child:  const Icon(
                              Icons.link,
                              size: 20,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top:8.0),
                            child: Text("Khảo sát"),
                          )
                        ],
                      ),

                      Column(
                        children: [
                          MaterialButton(
                            onPressed: () {
                              // FocusScope.of(context).unfocus();
                              // _controller.clear();
                              setState((){
                                selectedFunction =3;
                              });

                            },
                            color: selectedFunction!=3?Colors.white70:const Color.fromRGBO(218, 81, 82, 1),
                            textColor: selectedFunction==3?Colors.white:Colors.black,
                            padding: const EdgeInsets.all(15),
                            shape: const CircleBorder(),
                            child:  const Icon(
                              Icons.image,
                              size: 20,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top:8.0),
                            child: Text("Hình ảnh"),
                          )
                        ],
                      ),

                      Column(
                        children: [
                          MaterialButton(
                            onPressed: () {
                              // FocusScope.of(context).unfocus();
                              // _controller.clear();
                              setState((){
                                selectedFunction =4;
                              });

                            },
                            color: selectedFunction!=4?Colors.white70:const Color.fromRGBO(218, 81, 82, 1),
                            textColor: selectedFunction==4?Colors.white:Colors.black,
                            padding: const EdgeInsets.all(15),
                            shape: const CircleBorder(),
                            child:  const Icon(
                              Icons.video_collection_rounded,
                              size: 20,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top:8.0),
                            child: Text("Video"),
                          )
                        ],
                      ),

                      _focusNode.hasFocus||_linkFocusNode.hasFocus||_desFocusNode.hasFocus?GestureDetector(
                        onTap: (){
                          FocusScope.of(context).unfocus();
                          _controller.clear();
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(top:20.0),
                          child: Icon(Icons.arrow_drop_down,),
                        ),
                      ):Container(width: 15,)
                    ]
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
