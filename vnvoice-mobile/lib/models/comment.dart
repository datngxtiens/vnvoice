import 'dart:convert';

import 'package:flutter/material.dart';

class Comment {
  String? commentId;
  String? author;
  String? authorId;
  List<Comment>? commentChildren;
  String? description;
  String? authorImgUrl;
  String? createdAt;

  Comment({
    this.author,
    this.authorId,
    this.commentId,
    this.description,
    this.commentChildren,
    this.authorImgUrl,
    this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> comment) {
    List<Comment> children = [];
    if (comment.containsKey("child_comment")) {
      comment["child_comment"].forEach((cmt) {
        children.add(Comment.fromJson(cmt));
      });
    }

    debugPrint("Comment ID: ${comment["comment_id"]}");
    
    return Comment(
        authorId: comment["author_id"],
        commentId: comment["comment_id"],
        description: comment["text"],
        commentChildren: children,
        author: comment["author"],
        authorImgUrl: comment["author_img_url"],
        createdAt: comment["created_at"]
    );
  }
}

class CommentList {
  String message;
  List<Comment> commentList;

  CommentList({required this.message, required this.commentList});

  factory CommentList.fromJson(Map<String, dynamic> responseJson) {
    List<Comment> list = [];

    responseJson.forEach((key, value) {
      if (key == "data") {
        responseJson[key].forEach((comment) {
          list.add(Comment.fromJson(comment));
        });
      }
    });

    return CommentList(commentList: list, message: responseJson["message"]);
  }
}