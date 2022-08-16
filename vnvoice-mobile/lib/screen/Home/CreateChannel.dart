import 'package:flutter/material.dart';
import 'package:vnvoicemobile/requests/channels.dart';

import 'package:http/http.dart' as http;
import '../../Widgets/textFieldInput.dart';
import 'Feed.dart';

class CreateChannelScreen extends StatefulWidget {
  const CreateChannelScreen({Key? key}) : super(key: key);

  @override
  State<CreateChannelScreen> createState() => _CreateChannelScreenState();
}

class _CreateChannelScreenState extends State<CreateChannelScreen> {
  final TextEditingController _channelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                String channelName = _channelController.text;

                // creatorId, channelName, type (if needed)
                Future<http.Response> response = createChannel('53d7e653-2e64-4827-a3d7-a0765ad0c563', channelName);

                response.then((result) {
                  if (result.statusCode == 200) {
                    final snackBar = SnackBar(
                      content: const Text('Tạo kênh thành công'),
                      action: SnackBarAction(
                        label: 'Đóng',
                        onPressed: () {},
                      ),
                      duration: const Duration(seconds: 5),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Navigator.of(context).pop(MaterialPageRoute(builder: (context) => const FeedScreen()));
                  } else {
                    final snackBar = SnackBar(
                      content: const Text('Tạo kênh không thành công'),
                      action: SnackBarAction(
                        label: 'Đóng',
                         onPressed: () {},
                      ),
                      duration: const Duration(seconds: 3),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                  child: const Text("Tạo kênh",
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
