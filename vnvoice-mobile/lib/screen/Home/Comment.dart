import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vnvoicemobile/requests/posts.dart';

import '../../Widgets/textFieldInput.dart';
import '../../models/comment.dart';
import '../../models/user.dart';
import '../../provider/userProvider.dart';
import '../../widgets/commentCard.dart';
import '../../widgets/postCard.dart';
import 'Feed.dart';


class CommentScreen extends StatefulWidget {
  final String postId;
  final String type;
  final String title;
  final String text;
  final List<String> images;
  final String username;
  final String channel;
  final int totalComments;
  int totalSigners;
  bool upIconToggle;
  bool downIconToggle;
  int upvotes;
  int downvotes;
  String status;
  String authorImgUrl;

  CommentScreen({
    Key? key,
    required this.title,
    required this.postId,
    required this.type,
    required this.text,
    required this.images,
    required this.upvotes,
    required this.downvotes,
    required this.username,
    required this.channel,
    required this.totalComments,
    required this.authorImgUrl,
    this.status = 'Active',
    this.totalSigners = 0,
    this.upIconToggle = false,
    this.downIconToggle = false,
  }) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  late Future<CommentList> futureComment;

  @override
  void initState() {
    super.initState();
    futureComment = getPostComment(widget.postId);
  }

  final TextEditingController _commentController = TextEditingController();

  Widget getTextWidgets(List<Comment>? comments) {
    return Column(
        children: comments!.map((item) {
          return Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(color: Colors.grey.withOpacity(0.5), width: 1),
                ),
              ),
              padding: const EdgeInsets.only(top: 8.0, left: 20),
              child: Column(
                children: [
                  CommentCard(
                    authorImgUrl: item.authorImgUrl == null ? '' : item.authorImgUrl!,
                    commentId: item.commentId == null ? '' : item.commentId!,
                    authorId: item.authorId == null ? '': item.authorId!,
                    authorName: item.author == null ? 'Username' : item.author!,
                    commentText: item.description == null ? 'Lorem ipsum dolor sit amet' : item.description!,
                  ),
                  item.commentChildren!.isNotEmpty ? getTextWidgets(item.commentChildren) : Container()
                ],
              ),
            );
        }).toList()
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
                width: MediaQuery.of(context).size.width * 0.83,
                height: 50,
                child: TextFieldInput(
                  hintText: 'Bình luận',
                  textInputType: TextInputType.text,
                  textEditingController: _commentController,
                  icon: const Icon(Icons.person, color: Colors.black),
                  havePrefixIcon: false,
                ),
              ),
              IconButton(onPressed: (){
                String comment = _commentController.text;

                // postId, userId, comment, replyTo
                // createComment(
                //     widget.postId, '53d7e653-2e64-4827-a3d7-a0765ad0c563',
                //     comment, ''
                // );
                debugPrint("Commented: $comment");
                _commentController.clear();
                FocusManager.instance.primaryFocus?.unfocus();
              }, icon: const Icon(Icons.send,))
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PostCard(
                authorImgUrl: widget.authorImgUrl,
                postId: widget.postId,
                type: widget.type,
                upvotes: widget.upvotes,
                downvotes: widget.downvotes,
                username: widget.username,
                channel: widget.channel,
                title: widget.title,
                text: widget.text,
                status: widget.status,
                images: widget.images,
                totalComments: widget.totalComments,
                totalSigners: widget.totalSigners,
                isPetition: widget.type == "petition" ? true: false,
            ),
            FutureBuilder<CommentList>(
              future: futureComment,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return getTextWidgets(snapshot.data!.commentList);
                } else {
                  return const SizedBox(
                    child: Center(
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                  ) ;
                }
              },
            )
          ],
        ),
      ),
    );
  }
}


