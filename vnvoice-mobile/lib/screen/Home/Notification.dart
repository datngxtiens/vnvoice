import 'package:flutter/material.dart';

import '../../widgets/notificationCard.dart';
import '../../widgets/postCard.dart';


class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromRGBO(247, 247, 247, 1),
          centerTitle: true,
          title: Text("Thông báo", style: TextStyle(color: Colors.black),),
          elevation: 0,
          leading: Container(),

        // actions: [
        //   IconButton(onPressed: (){}, icon: Icon(Icons.messenger_outline))
        // ],
      ),
      body: Container(
        color: Color.fromRGBO(247, 247, 247, 1),
        child: ListView.builder(

            itemCount: 10, // :)))
            itemBuilder: (context, index) {
              bool isMark = index%2==0? true:false;
              return notificationCard(
                isMark: isMark
              ); // :))) snap là data thay cho hard code
            }
        ),
      ),
    );
  }
}