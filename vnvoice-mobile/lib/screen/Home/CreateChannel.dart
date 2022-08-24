import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vnvoicemobile/provider/userProvider.dart';
import 'package:vnvoicemobile/requests/channels.dart';

import 'package:http/http.dart' as http;
import 'package:vnvoicemobile/screen/Home/Channel.dart';
import 'package:vnvoicemobile/utils/utils.dart';
import '../../Widgets/textFieldInput.dart';
import '../../models/user.dart';
import 'Feed.dart';

class CreateChannelScreen extends StatefulWidget {
  String channelName = '';

 CreateChannelScreen({
    Key? key,
    this.channelName = 'Kênh mới'
  }) : super(key: key);

  @override
  State<CreateChannelScreen> createState() => _CreateChannelScreenState();
}

class _CreateChannelScreenState extends State<CreateChannelScreen> {
  final TextEditingController _channelController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    User? currentUser = Provider.of<UserProvider>(context).getUser();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Tạo kênh", style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Color.fromRGBO(218, 81, 82, 1),),
          onPressed: () {
            Navigator.of(context).pop(MaterialPageRoute(builder: (context) => const FeedScreen()));
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFieldInput(
                textEditingController: _channelController,
                hintText: "Nhập tên kênh",
                textInputType: TextInputType.text,
                icon: const Icon(Icons.add_box_outlined, color: Colors.black),
                havePrefixIcon: false,
              ),
            ),
            InkWell(
              onTap: () {
                if (_isLoading) {
                  return;
                }

                setState(() {
                  _isLoading = true;
                  widget.channelName = _channelController.text;
                });

                String channelName = _channelController.text;

                // creatorId, channelName, type (if needed)
                Future<http.Response> response = createChannel(
                    currentUser!.userId,
                    channelName
                );

                response.then((result) {
                  if (result.statusCode == 200) {
                    showSnackBar('Tạo kênh thành công', context);

                    setState(() {
                      _isLoading = false;
                    });

                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChannelScreen(channelName: widget.channelName)));
                  } else {
                    showSnackBar('Tạo kênh thành không công', context);
                  }
                });
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
                  child: _isLoading ?
                  const Center(
                    child: SizedBox(
                      height: 20.0,
                      width: 20.0,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3.0,
                      ),
                    ),
                  ):
                  const Text("Tạo kênh",
                    style: TextStyle(
                        color: Colors.white,
                      fontSize: 16
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
