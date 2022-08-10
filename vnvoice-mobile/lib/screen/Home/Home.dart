import "package:flutter/material.dart";

import 'CreateChannel.dart';
import 'CreatePost.dart';
import 'HomePage.dart';




class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
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
    if(indexItem!=2) _pageController.jumpToPage(indexItem);


  }

  void onPageChanged(int page) {
    setState(() {
      _itemSelected = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    // models.User user = Provider.of<UserProvider>(context).getUser;
    void bottomSheet(context) {

      showModalBottomSheet(context: context, builder: (context){
        return Container(
          height: 120,
          color: Colors.white,
          child: Column(
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context)=> CreateChannelScreen(

                        )
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Icon(Icons.post_add, color: Colors.black,),
                      const SizedBox(width: 20,),
                      Text("Tạo kênh")
                    ],
                  ),
                ),
              ),

              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context)=> CreatePostScreen(

                        )
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Icon(Icons.post_add, color: Colors.black,),
                      const SizedBox(width: 20,),
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
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: onPageChanged,
          children: homeScreenItems,
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          currentIndex: _itemSelected,
          onTap: onTap,
          selectedItemColor: Color.fromRGBO(218, 81, 82, 1),
          unselectedItemColor: Colors.grey.withOpacity(0.5),
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Trang chủ"),
            BottomNavigationBarItem(icon: Icon(Icons.trending_up), label: "Xu hướng"),
            BottomNavigationBarItem(
                icon: Builder(
                  builder: (context) {
                    return GestureDetector(
                        onTap: () {
                            bottomSheet(context);
                        },
                        child: Icon(Icons.add_circle_outline)
                    );
                  }
                ),
                label: "Thêm"
            ),
            BottomNavigationBarItem(icon: Icon(Icons.message), label: "Tin nhắn"),
            BottomNavigationBarItem(icon: Icon(Icons.notifications), label:"Thông báo"),
          ],
        ),
    );
  }
}