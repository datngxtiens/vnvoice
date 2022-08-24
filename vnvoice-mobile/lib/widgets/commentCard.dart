import 'dart:math';

import "package:flutter/material.dart";
import 'package:intl/intl.dart';

class CommentCard extends StatefulWidget {
  String authorId;
  String commentId;
  String authorName;
  String commentText;
  String authorImgUrl;
  String createdAt;

  final random = Random();

  CommentCard({
    Key? key,
    required this.authorId,
    required this.commentId,
    required this.authorName,
    required this.commentText,
    required this.authorImgUrl,
    required this.createdAt,
  }) : super(key: key);

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  bool isReply = false;
  @override
  Widget build(BuildContext context) {
    // int minDate = 1660755600000;
    // int maxDate = 1660841940000;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(widget.authorImgUrl),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 5.0),
              child: Text(
                  widget.authorName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            const Icon(Icons.circle, size: 5,),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                widget.createdAt != "ngay lúc này" ?
                "at ${DateFormat('hh:mm dd-MM').format(DateTime.parse(widget.createdAt))}" :
                widget.createdAt,
                style: const TextStyle(fontSize: 10),),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0, top: 2.0),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                  child:  Text(widget.commentText),
              ),
              IconButton(onPressed: (){setState((){isReply=true;});}, icon:const Icon(Icons.reply)),
            ],
          ),
        )
      ],
    );
  }
}
