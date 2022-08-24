import 'dart:convert';

import 'package:flutter/material.dart';
import 'comment.dart';

class PostList {
  final List<Post> postList;
  final String message;

  PostList({required this.postList, required this.message});

  factory PostList.fromJson(Map<String, dynamic> dataList) {
    List<Post> list = [];

    dataList.forEach((key, value) {
      if (key == "data") {
        dataList[key].forEach((post) {
          list.add(Post.fromJson(post));
        });
      }
    });
    return PostList(postList: list, message: dataList["message"]);
  }

  // @override
  // String toString() {
  //   return postList.toString();
  // }
}


class Post {
  final String postId;
  final String type;
  final String authorId;
  final String username;
  final String channel;
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
  final String authorImgUrl;
  final bool hasLiked;

  Post({
      required this.postId,
      required this.type,
      required this.authorId,
      required this.username,
      required this.channel,
      required this.upvotes,
      required this.downvotes,
      required this.status,
      required this.title,
      required this.text,
      this.authorImgUrl = 'https://vnvoice-data.s3.amazonaws.com/image/avatar/anonymous.png',
      this.totalComments = 0,
      this.images = const [],
      this.url = '',
      this.totalSignatures = 0,
      this.comments = const [],
      this.hasLiked = false
  });

  factory Post.fromJson(Map<String, dynamic> post) {
    int tComments = 0;
    List<String> imageList = [];
    String postUrl = '';
    int signatures = 0;
    List<Comment> commentList = [];

    debugPrint("Post ID: ${post["post_id"]}");

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

    if (post.containsKey("total_signature")) {
      signatures = post["total_signature"];
    }

    return Post(
        postId: post["post_id"],
        type: post["type"],
        authorId: post["author_id"],
        username: post["username"],
        channel: post["channel_name"],
        upvotes: post["upvotes"],
        downvotes: post["downvotes"],
        status: post["status"],
        title: post["title"],
        text: post["text"],
        authorImgUrl: post["author_img_url"],
        hasLiked: post["has_liked"],
        totalComments: tComments,
        images: imageList,
        url: postUrl,
        totalSignatures: signatures,
        comments: commentList,
    );
  }
}

class PostBasicInfo {
  String authorId;
  String channelId;
  String title;
  String text;
  String surveyUrl;
  List<String> imgUrls;

  PostBasicInfo({
    required this.authorId, required this.channelId, required this.title,
    required this.text, this.surveyUrl = '', this.imgUrls = const []});

  Map<String, dynamic> toJson() => {
    "author_id": authorId,
    "channel_id": channelId,
    "title": title,
    "text": text,
    "survey_url": surveyUrl,
    "img_url": imgUrls
  };
}
