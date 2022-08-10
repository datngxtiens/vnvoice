import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/utils.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  FocusNode _focusNode = FocusNode();
  TextEditingController _controller = TextEditingController();
  List<Widget> functionComponent = [];
  int selectedFunction = 0;
  Uint8List? _file;
  List<Uint8List> listFile=[];
  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      debugPrint("Focus: ${_focusNode.hasFocus.toString()}");
      // if (!_focusNode.hasFocus) {
      //   FocusScope.of(context).requestFocus(_focusNode);
      // }
    });
  }

  _selectImage(BuildContext context) async {
    return showDialog(context: context, builder: (context){
      return SimpleDialog(
        title: const Text('Create a Post'),
        children: [
          SimpleDialogOption(
            padding: const EdgeInsets.all(20),
            child: const Text("Take a photo"),
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
            child: const Text("Choose a photo"),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tạo bài viết", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
            icon: Icon(Icons.close, color: Colors.grey.withOpacity(0.5),),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child:Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Container(
                  color: Colors.blueAccent,
                  child: RaisedButton(
                    color: Color.fromRGBO(218, 81, 82, 1),
                    child: Text("Tiếp", style: TextStyle(color: Colors.white),),
                    onPressed: () {},
                  ),
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
                  // Tieu de
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
                      cursorColor: Color.fromRGBO(218, 81, 82, 1),
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  // duong dan
                  Container(
                    color: Colors.white,
                    child: TextFormField(
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Đường dẫn"
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: 2,
                      minLines: 1,
                      focusNode: _focusNode,
                      controller: _controller,
                      cursorColor: Color.fromRGBO(218, 81, 82, 1),
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                    ),
                  ),
                  // Anh
                  Container(
                    height: 100,
                    child: ListView.builder(
                        itemCount: listFile.length+1,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) {
                          return index!=listFile.length?Container(
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
                                        child: Icon(Icons.close, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ):GestureDetector(
                            onTap:() {
                              _selectImage(context);
                            },
                            child: DottedBorder(
                              dashPattern: [6, 3],
                              strokeCap: StrokeCap.square,
                              color: Colors.black,
                              strokeWidth: 1,
                              child: Container(
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
                  ),
                  // noi dung
                  Container(
                    color: Colors.white,
                    child: TextFormField(
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Nội dung"
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: 20,
                      minLines: 15,
                      focusNode: _focusNode,
                      controller: _controller,
                      cursorColor: Color.fromRGBO(218, 81, 82, 1),
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                    ),
                  ),

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
          height: _focusNode.hasFocus?120:150,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
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
                  4: FixedColumnWidth(_focusNode.hasFocus?15:0)
                },
                children: [
                  TableRow(
                    children: [
                      Column(
                        children: [
                          Container(
                            child: MaterialButton(
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                _controller.clear();
                                setState((){
                                  selectedFunction =1;
                                });

                              },
                              color: selectedFunction!=1?Colors.white70:Color.fromRGBO(218, 81, 82, 1),
                              textColor: selectedFunction==1?Colors.white:Colors.black,
                              child:  Icon(
                                Icons.text_fields,
                                size: 20,
                              ),
                              padding: EdgeInsets.all(15),
                              shape: CircleBorder(),
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
                              FocusScope.of(context).unfocus();
                              _controller.clear();
                              setState((){
                                selectedFunction =2;
                              });

                            },
                            color: selectedFunction!=2?Colors.white70:Color.fromRGBO(218, 81, 82, 1),
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
                              FocusScope.of(context).unfocus();
                              _controller.clear();
                              setState((){
                                selectedFunction =3;
                              });

                            },
                            color: selectedFunction!=3?Colors.white70:Color.fromRGBO(218, 81, 82, 1),
                            textColor: selectedFunction==3?Colors.white:Colors.black,
                            child:  Icon(
                              Icons.image,
                              size: 20,
                            ),
                            padding: EdgeInsets.all(15),
                            shape: const CircleBorder(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:8.0),
                            child: Text("Hình ảnh"),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          MaterialButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              _controller.clear();
                              setState((){
                                selectedFunction =4;
                              });

                            },
                            color: selectedFunction!=4?Colors.white70:Color.fromRGBO(218, 81, 82, 1),
                            textColor: selectedFunction==4?Colors.white:Colors.black,
                            child:  Icon(
                              Icons.video_collection_rounded,
                              size: 20,
                            ),
                            padding: EdgeInsets.all(15),
                            shape: CircleBorder(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:8.0),
                            child: Text("Video"),
                          )
                        ],
                      ),
                      _focusNode.hasFocus?GestureDetector(
                        onTap: (){
                          FocusScope.of(context).unfocus();
                          _controller.clear();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top:20.0),
                          child: Icon(Icons.arrow_drop_down,),
                        ),
                      ):Container()
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
