import 'dart:async';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vnvoicemobile/models/user.dart';
import 'package:vnvoicemobile/provider/userProvider.dart';

import '../../widgets/postCard.dart';
import 'package:vnvoicemobile/models/post.dart';
import 'package:vnvoicemobile/requests/posts.dart';

import '../SignIn.dart';


class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreen();
}

class _FeedScreen extends State<FeedScreen> with SingleTickerProviderStateMixin {

  bool isLoading = false;
  late Future<PostList> futurePost;
  bool isCollapsed = true;
  late double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _menuScaleAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    futurePost = getAllPost();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 1).animate(_controller);
    _menuScaleAnimation = Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0)).animate(_controller);
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    User? currentUser = Provider.of<UserProvider>(context).getUser();

    return Stack(
      children: [
        AnimatedPositioned(
          duration: duration,
          top: 0,
          bottom: 0,
          left: isCollapsed ? 0 : -0.8 * screenWidth,
          right: isCollapsed ? 0 : 0.8 * screenWidth,
          child: Scaffold(
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isCollapsed) {
                          _controller.forward();
                        } else {
                          _controller.reverse();
                        }
                        isCollapsed = !isCollapsed;
                      });
                    },
                    child: CircleAvatar(
                      foregroundImage: NetworkImage(currentUser!.imgUrl),
                    ),
                  ),
                )
              ],
            ),
            body: Container(
              color: Colors.white,
              child: FutureBuilder<PostList>(
                future: futurePost,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        physics: !isCollapsed?const NeverScrollableScrollPhysics():const ScrollPhysics(),
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
                            upIconToggle: post.hasLiked,
                            isFavorite: index < 4 ? true : false,
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
          ),
        ),
        sideBarMenu(context, currentUser)
      ],
    );
  }

  Widget sideBarMenu(context, User? currentUser) {
    double w = MediaQuery.of(context).size.width*0.2;
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding: EdgeInsets.only(left: w+10, right: 10, top: 30),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              // mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(Icons.close, color: Colors.grey.withOpacity(0.5),size: 30,),
                    onPressed: () {  },
                  ),
                ),
                CircleAvatar(
                  radius: 90,
                  foregroundImage: NetworkImage(currentUser!.imgUrl),
                ),
                const SizedBox(height: 10,),
                Text(currentUser.username, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                const SizedBox(height: 10,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    color: Color.fromRGBO(218, 81, 82, 1),
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      try {
                        await Amplify.Auth.signOut();
                        userProvider.user = null;

                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => const SignIn()
                          ),
                        );
                      } catch(e) {
                        debugPrint(e.toString());
                      }
                    },
                    child: const Text("Đăng xuất ngay",
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),

                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.5),
                        width: 1.0,
                      ),
                    ),

          ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(onPressed: (){}, icon: Icon(Icons.person_pin, color: Colors.grey.withOpacity(0.8),)),
                      const Text("Trang cá nhân", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.5),
                        width: 1.0,
                      ),
                    ),

                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(onPressed: (){}, icon: Icon(Icons.add_circle, color: Colors.grey.withOpacity(0.8),)),
                      const Text("Tạo kênh", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.5),
                        width: 1.0,
                      ),
                    ),

                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(onPressed: (){}, icon: Icon(Icons.bookmark, color: Colors.grey.withOpacity(0.8),)),
                      const Text("Đã lưu", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.5),
                        width: 1.0,
                      ),
                    ),

                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(onPressed: (){}, icon: Icon(Icons.history, color: Colors.grey.withOpacity(0.8),)),
                      const Text("Lịch sử", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.5),
                        width: 1.0,
                      ),
                    ),

                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(onPressed: (){}, icon: Icon(Icons.drive_file_rename_outline_rounded, color: Colors.grey.withOpacity(0.8),)),
                      const Text("Bản nháp", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.5),
                        width: 1.0,
                      ),
                    ),

                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(onPressed: (){}, icon: Icon(Icons.settings, color: Colors.grey.withOpacity(0.8),)),
                      const Text("Cài đặt", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}