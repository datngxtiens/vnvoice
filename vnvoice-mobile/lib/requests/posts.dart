import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vnvoicemobile/models/comment.dart';
import 'package:vnvoicemobile/requests/urls.dart';
import 'package:vnvoicemobile/models/post.dart';

Future<PostList> getAllPost() async {
  final response = await http.get(Uri.parse(VnVoiceUri.getAllPost));

  if (response.statusCode == 200) {
    PostList list = PostList.fromJson(jsonDecode(response.body, ));

    return list;
  } else {
    debugPrint("No post found");

    return PostList(postList: [], message: "No post found.");
  }
}

Future<CommentList> getPostComment(String postId) async {
  final response = await http.get(Uri.parse("${VnVoiceUri.getPostDetail}?id=$postId"));

  if (response.statusCode == 200) {
    return CommentList.fromJson(jsonDecode(response.body));
  } else {
    return CommentList(message: "No comment", commentList: []);
  }
}

Future<http.Response> votePost(String postId, String action) async {
  final response = await http.put(Uri.parse("${VnVoiceUri.votePost}?id=$postId&type=$action"));

  return response;
}

Future<http.Response> createComment(String postId, String authorId, String comment, String replyTo) async {
  final response = await http.post(
    Uri.parse(VnVoiceUri.createComment),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'author_id': authorId,
      'post_id': postId,
      'text': comment,
      'reply_to': replyTo
    }),
  );

  return response;
}
