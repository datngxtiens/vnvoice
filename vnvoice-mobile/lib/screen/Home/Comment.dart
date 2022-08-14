import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Widgets/textFieldInput.dart';
import '../../data/commentFake.dart';
import '../../models/commentModel.dart';
import '../../models/userModel.dart';
import '../../provider/userProvider.dart';
import '../../widgets/commentCard.dart';
import '../../widgets/postCard.dart';
import 'Feed.dart';


class CommentScreen extends StatefulWidget {
  const CommentScreen({Key? key}) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  CommentModel comment = commentFake;
  final TextEditingController _commentController = TextEditingController();
  Widget getTextWidgets(List<CommentModel>? comments)
  {
    return Container(
      child: Column(
          children: comments!.map((item) {
            return Container(
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(color: Colors.grey.withOpacity(0.5), width: 1),
                  ),
                      ),
                padding: const EdgeInsets.only(top:8.0, left: 20),
                child: Column(
                  children: [
                    CommentCard(),
                    item.commentChildren!.isNotEmpty? getTextWidgets(item.commentChildren):Container()
                  ],
                ),
              );
          }).toList()
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color.fromRGBO(218, 81, 82, 1),),
          onPressed: () {
            Navigator.of(context).pop(MaterialPageRoute(builder: (context) => FeedScreen()));
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width*0.83,
                height: 50,
                child: TextFieldInput(
                  hintText: 'Bình luận',
                  textInputType: TextInputType.text,
                  textEditingController: _commentController,
                  icon: Icon(Icons.person, color: Colors.black),
                  havePrefixIcon: false,
                ),
              ),
              IconButton(onPressed: (){}, icon: Icon(Icons.send,))
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              PostCard(snap: null),
              getTextWidgets(comment.commentChildren),
            ],
          )
        ),
      ),
    );
  }
}


