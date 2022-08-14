import 'dart:convert';

import 'package:flutter/material.dart';

import 'comment.dart';

class PostList {
  final List<Post> postList;
  final String message;

  PostList({required this.postList, required this.message});

  factory PostList.fromJson(Map<String, dynamic> dataList) {
    List<Post> list = [];

    for (var post in List.of(dataList["data"])) {
      try {
        Post cPost = Post.fromJson(jsonDecode(post.toString()));
        list.add(cPost);
      } catch(e) {
        debugPrint(e.toString());
      }
    }

    return PostList(postList: list, message: dataList["message"]);
  }

  @override
  String toString() {
    return postList.toString();
  }
}

class Post {
  final String postId;
  final String type;
  final String authorId;
  final String username;
  final String title;
  final String text;
  final int upvotes;
  final int downvotes;
  final String status;
  final int totalComments;
  final List<String> images;
  final String url;
  final int totalSignatures;
  final List<Comment> comments;

  Post(
      {required this.postId,
      required this.type,
      required this.authorId,
      required this.username,
      required this.upvotes,
      required this.downvotes,
      required this.status,
      required this.title,
      required this.text,
      this.totalComments = 0,
      this.images = const [],
      this.url = '',
      this.totalSignatures = 0,
      this.comments = const []});

  factory Post.fromJson(Map<String, dynamic> post) {
    int tComments = 0;
    List<String> imageList = [];
    String postUrl = '';
    int signatures = 0;
    List<Comment> commentList = [];

    if (post.containsKey("total_comments")) {
      tComments = post["total_comments"];
    }

    if (post.containsKey("images")) {
      for (var image in post["images"]) {
        imageList.add(image.toString());
      }
    }

    if (post.containsKey("url")) {
      postUrl = post["url"];
    }

    if (post.containsKey(["total_signature"])) {
      signatures = post["total_signatures"];
    }

    return Post(
      postId: post["post_id"],
      type: post["type"],
      authorId: post["author_id"],
      username: post["username"],
      upvotes: post["upvotes"],
      downvotes: post["downvotes"],
      status: post["status"],
      title: post["title"],
      text: post["text"],
      totalComments: tComments,
      images: imageList,
      url: postUrl,
      totalSignatures: signatures,
      comments: commentList
    );
  }
}
