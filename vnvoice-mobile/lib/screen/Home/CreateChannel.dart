import 'package:flutter/material.dart';

import '../../Widgets/textFieldInput.dart';
import 'Feed.dart';

class CreateChannelScreen extends StatefulWidget {
  const CreateChannelScreen({Key? key}) : super(key: key);

  @override
  State<CreateChannelScreen> createState() => _CreateChannelScreenState();
}

class _CreateChannelScreenState extends State<CreateChannelScreen> {
  TextEditingController _channelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Tạo kênh", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Color.fromRGBO(218, 81, 82, 1),),
          onPressed: () {
            Navigator.of(context).pop(MaterialPageRoute(builder: (context)=>FeedScreen()));
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
                  hintText: "Nhập tên kênh",
                  textInputType: TextInputType.text,
                  icon: Icon(Icons.person, color: Colors.black),
                  havePrefixIcon: false,
                ),
              ),
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: const Text("Tạo kênh",
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
