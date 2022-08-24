import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../provider/userProvider.dart';
import 'CreateChannel.dart';
import 'CreatePost.dart';
import 'HomePage.dart';

class HomeScreenLayout extends StatefulWidget {
  const HomeScreenLayout({Key? key}) : super(key: key);

  @override
  State<HomeScreenLayout> createState() => _HomeScreenLayoutState();
}

class _HomeScreenLayoutState extends State<HomeScreenLayout> {
  int _itemSelected = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  void onTap(int indexItem) {
    if (indexItem != 2) _pageController.jumpToPage(indexItem);
  }

  void onPageChanged(int page) {
    setState(() {
      _itemSelected = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    User? currentUser = Provider.of<UserProvider>(context).getUser();

    debugPrint("Current User: ${currentUser!.username}");

    void bottomSheet(context) {
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          height: 120,
          color: Colors.white,
          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  _pageController.jumpToPage(3);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => CreateChannelScreen()
                    ),
                  ).then((value) {
                    Navigator.pop(context);
                    _pageController.jumpToPage(0);
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: const [
                      Icon(Icons.add_business_outlined, color: Colors.black,),
                      SizedBox(width: 20,),
                      Text("Tạo kênh")
                    ],
                  ),
                ),
              ),

              GestureDetector(
                onTap: () async {
                  _pageController.jumpToPage(3);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const CreatePostScreen()
                    ),
                  ).then((value) {
                    Navigator.pop(context);
                    _pageController.jumpToPage(0);
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: const [
                      Icon(Icons.post_add, color: Colors.black,),
                      SizedBox(width: 20,),
                      Text("Tạo bài viết")
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      });
    }

    return Scaffold(
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: onPageChanged,
          children: homeScreenItems,
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          currentIndex: _itemSelected,
          onTap: onTap,
          selectedItemColor: const Color.fromRGBO(218, 81, 82, 1),
          unselectedItemColor: Colors.grey.withOpacity(0.5),
          items: [
            const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Trang chủ"),
            const BottomNavigationBarItem(icon: Icon(Icons.trending_up), label: "Xu hướng"),
            BottomNavigationBarItem(
                icon: Builder(
                  builder: (context) {
                    return GestureDetector(
                        onTap: () {
                            bottomSheet(context);
                        },
                        child: const Icon(Icons.add_circle_outline)
                    );
                  }
                ),
                label: "Thêm"
            ),
            const BottomNavigationBarItem(icon: Icon(Icons.message), label: "Tin nhắn"),
            const BottomNavigationBarItem(icon: Icon(Icons.notifications), label:"Thông báo"),
          ],
        ),
    );
  }
}