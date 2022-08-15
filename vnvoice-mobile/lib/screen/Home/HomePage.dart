import "package:flutter/material.dart";

import 'CreateChannel.dart';
import 'CreatePost.dart';
import 'Feed.dart';
import 'Notification.dart';
import 'Trending.dart';


const homeScreenItems = [
  FeedScreen(),
  TrendingScreen(),
  NotificationScreen(),
  const Text("Tin nhắn"),
  NotificationScreen(),
  CreateChannelScreen(),
  CreatePostScreen(),
];