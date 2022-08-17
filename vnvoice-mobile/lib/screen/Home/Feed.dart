import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vnvoicemobile/screen/SignOut.dart';

import '../../widgets/postCard.dart';
import 'package:vnvoicemobile/models/post.dart';
import 'package:vnvoicemobile/requests/posts.dart';


class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreen();
}

class _FeedScreen extends State<FeedScreen> {
  bool isLoading = false;
  late Future<PostList> futurePost;

  @override
  void initState() {
    super.initState();
    futurePost = getAllPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        centerTitle: false,
        title: const Text("VNVoice",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30),
        ),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: (){
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => const SignOut()
                    )
                );
              },
              icon: const Icon(Icons.person),iconSize: 45,)
        ],

        // actions: [
        //   IconButton(onPressed: (){}, icon: Icon(Icons.messenger_outline))
        // ],
      ),
      body: Container(
        color: Colors.white,
        child: FutureBuilder<PostList>(
          future: futurePost,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data?.postList.length,
                  itemBuilder: (context, index) {
                    Post post = snapshot.data!.postList[index];

                    return PostCard(
                      postId: post.postId,
                      type: post.type,
                      upvotes: post.upvotes,
                      downvotes: post.downvotes,
                      username: post.username,
                      authorImgUrl: post.authorImgUrl,
                      channel: post.channel,
                      title: post.title,
                      text: post.text,
                      images: post.images,
                      totalComments: post.totalComments,
                      totalSigners: post.totalSignatures,
                      status: post.status,
                      isPetition: post.type == "petition" ? true: false,
                      upIconToggle: index % 3 == 0 ? true : false,
                      isFavorite: index < 3 ? true : false,
                    );
                  }
              );
            } else {
              return const SizedBox(
                height: double.infinity,
                width: double.infinity,

                child: Center(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              );
            }
          },
        )
      ),
    );
  }
}