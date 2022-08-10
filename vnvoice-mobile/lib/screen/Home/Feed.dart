import 'package:flutter/material.dart';

import '../../widgets/postCard.dart';


class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text("VNVoice", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 30),),
        elevation: 0,

        // actions: [
        //   IconButton(onPressed: (){}, icon: Icon(Icons.messenger_outline))
        // ],
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
            itemCount: 3, // :)))
            itemBuilder: (context, index) {
              return PostCard(snap: null); // :))) snap là data thay cho hard code
            }
        ),
      ),
    );
  }
}