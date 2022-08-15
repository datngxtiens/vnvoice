import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
