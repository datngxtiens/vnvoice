// import 'package:flutter/material.dart';
//
// import '../../widgets/postCard.dart';
// import '../../widgets/trendingCard.dart';
//
//
// class ChannelScreen extends StatefulWidget {
//   const ChannelScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ChannelScreen> createState() => _ChannelScreenState();
// }
//
// class _ChannelScreenState extends State<ChannelScreen> with TickerProviderStateMixin{
//   @override
//   Widget build(BuildContext context) {
//     TabController _tabController = TabController(length: 3, vsync: this);
//
//     return Scaffold(
//       // appBar: AppBar(
//       //   backgroundColor: Color.fromRGBO(247, 247, 247, 1),
//       //   centerTitle: false,
//       //   title: Text("Kỳ thi THPTQG", style: TextStyle(color: Colors.redAccent),),
//       //   elevation: 0,
//       //   leading: IconButton(
//       //     onPressed: (){},
//       //     icon: Icon(Icons.arrow_back, color: Colors.black,),
//       //   ),
//       //
//       //   // actions: [
//       //   //   IconButton(onPressed: (){}, icon: Icon(Icons.messenger_outline))
//       //   // ],
//       // ),
//       body: Container(
//         child: Column(
//           children: [
//             Container(
//               child: Align(
//                 alignment: Alignment.center,
//                   child: TabBar(
//                     labelPadding: const EdgeInsets.only(left: 20, right: 20),
//                     controller: _tabController,
//                     labelColor: Colors.black,
//                     unselectedLabelColor: Colors.grey,
//                     isScrollable: true,
//                     indicatorSize: TabBarIndicatorSize.label,
//                     tabs: [
//                       Tab(text: "Bài viết",),
//                       Tab(text: "Thành viên (38473)",),
//                       Tab(text: "Giới thiệu",),
//                     ],
//                   ),
//                 ),
//             ),
//             Expanded(
//               child: Container(
//                 padding: const EdgeInsets.only(left: 10),
//                 // height: MediaQuery.of(context).size.height*0.75,
//                 width: double.infinity,
//                 child: TabBarView(
//                   controller: _tabController,
//                   children: [
//                     ListView.builder(
//                         itemCount: 10, // :)))
//                         itemBuilder: (context, index) {
//                           return  PostCard(snap: null,); // :))) snap là data thay cho hard code
//                         }),
//                     ListView.builder(
//                         itemCount: 10, // :)))
//                         itemBuilder: (context, index) {
//                           return  trendingCard(index: index); // :))) snap là data thay cho hard code
//                         }),
//                     ListView.builder(
//                         itemCount: 10, // :)))
//                         itemBuilder: (context, index) {
//                           return  trendingCard(index: index); // :))) snap là data thay cho hard code
//                         }),
//
//                   ],
//                 ),
//               ),
//             ),
//
//
//     ])
//     ));
//   }
// }

import 'package:flutter/material.dart';

import '../../widgets/postCard.dart';
import '../../widgets/trendingCard.dart';


class ChannelScreen extends StatefulWidget {
  const ChannelScreen({Key? key}) : super(key: key);

  @override
  State<ChannelScreen> createState() => _ChannelScreenState();
}

class _ChannelScreenState extends State<ChannelScreen> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Color.fromRGBO(247, 247, 247, 1),
      //   centerTitle: false,
      //   title: Text("Kỳ thi THPTQG", style: TextStyle(color: Colors.redAccent),),
      //   elevation: 0,
      //   leading: IconButton(
      //     onPressed: (){},
      //     icon: Icon(Icons.arrow_back, color: Colors.black,),
      //   ),
      //
      //   // actions: [
      //   //   IconButton(onPressed: (){}, icon: Icon(Icons.messenger_outline))
      //   // ],
      // ),
        body: DefaultTabController(
          length: 3,
          child: NestedScrollView(
            headerSliverBuilder: (context, value){
              return [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 100.0,
                  title: const Text('Kì thi THPTQG 2025'),
                  flexibleSpace: FlexibleSpaceBar(
//               title: const Text('SliverAppBar'),
                      background: Stack(children: <Widget>[
                        Container(
                            height: double.infinity,
                            width:double.infinity,
                            color: Colors.red
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 70.0),
                          child: Stack(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 50 / 2.0,
                                ),

                                ///here we create space for the circle avatar to get ut of the box
                                child: Container(
                                  height: 50.0,
                                  decoration: BoxDecoration(color: Colors.white),
                                  width: double.infinity,
                                ),
                              ),

                              ///Image Avatar
                              Positioned(
                                left: 20,
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 8.0,
                                        offset: Offset(0.0, 5.0),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Center(
                                      child: Container(
                                        child: Icon(Icons.person),

                                        /// replace your image with the Icon
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ])),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Kì thi THPTQG 2025", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                        Text("1.000.234 thành viên"),
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum libero erat, vestibulum in risus a, accumsan cursus nisl. Duis malesuada eget enim vitae ornare. In a hendrerit lorem. Nam vel leo at erat sodales euismod. Proin commodo tellus nec aliquam faucibus. Curabitur convallis, nibh sit amet ullamcorper tincidunt, nisi dui bibendum ante, nec porttitor nunc arcu vitae tellus. Pellentesque sed nisi dictum, eleifend lorem eu, vulputate nisl. Sed nec mollis mi. Quisque nec pulvinar purus, id posuere metus. Fusce tempor, nunc sed vulputate hendrerit, nunc velit venenatis lacus, nec bibendum orci dolor vitae dolor.")
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SizedBox(
                        child: Container(
                          color: Colors.white,
                          child: Align(
                            alignment: Alignment.center,
                            child: TabBar(
                              labelPadding: const EdgeInsets.only(left: 20, right: 20),
                              controller: _tabController,
                              labelColor: Colors.black,
                              unselectedLabelColor: Colors.grey,
                              isScrollable: true,
                              indicatorSize: TabBarIndicatorSize.label,
                              tabs: [
                                Tab(text: "Bài viết",),
                                Tab(text: "Thành viên (38473)",),
                                Tab(text: "Giới thiệu",),
                              ],
                            ),
                          ),
                        ),
                      ),


                    ],
                  ),
                ),
//                 CustomScrollView(
//                   slivers: <Widget>[
//                     SliverAppBar(
//                       pinned: true,
//                       expandedHeight: 100.0,
//                       title: const Text('Kì thi THPTQG 2025'),
//                       flexibleSpace: FlexibleSpaceBar(
// //               title: const Text('SliverAppBar'),
//                           background: Stack(children: <Widget>[
//                             Container(
//                                 height: double.infinity,
//                                 width:double.infinity,
//                                 color: Colors.red
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(top: 70.0),
//                               child: Stack(
//                                 children: <Widget>[
//                                   Padding(
//                                     padding: EdgeInsets.only(
//                                       top: 50 / 2.0,
//                                     ),
//
//                                     ///here we create space for the circle avatar to get ut of the box
//                                     child: Container(
//                                       height: 50.0,
//                                       decoration: BoxDecoration(color: Colors.white),
//                                       width: double.infinity,
//                                     ),
//                                   ),
//
//                                   ///Image Avatar
//                                   Positioned(
//                                     left: 20,
//                                     child: Container(
//                                       width: 50,
//                                       height: 50,
//                                       decoration: BoxDecoration(
//                                         shape: BoxShape.circle,
//                                         color: Colors.white,
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Colors.black26,
//                                             blurRadius: 8.0,
//                                             offset: Offset(0.0, 5.0),
//                                           ),
//                                         ],
//                                       ),
//                                       child: Padding(
//                                         padding: EdgeInsets.all(4.0),
//                                         child: Center(
//                                           child: Container(
//                                             child: Icon(Icons.person),
//
//                                             /// replace your image with the Icon
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ])),
//                     ),
//                     SliverToBoxAdapter(
//                       child: Column(
//                         children: [
//                           SizedBox(
//                             child: Container(
//                               color: Colors.white,
//                               child: Align(
//                                 alignment: Alignment.center,
//                                 child: TabBar(
//                                   labelPadding: const EdgeInsets.only(left: 20, right: 20),
//                                   controller: _tabController,
//                                   labelColor: Colors.black,
//                                   unselectedLabelColor: Colors.grey,
//                                   isScrollable: true,
//                                   indicatorSize: TabBarIndicatorSize.label,
//                                   tabs: [
//                                     Tab(text: "Bài viết",),
//                                     Tab(text: "Thành viên (38473)",),
//                                     Tab(text: "Giới thiệu",),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//
//
//                         ],
//                       ),
//                     ),
//
//                     // Expanded(
//                     //       child: Container(
//                     //         padding: const EdgeInsets.only(left: 10),
//                     //         // height: MediaQuery.of(context).size.height*0.75,
//                     //         width: double.infinity,
//                     //         child: TabBarView(
//                     //           controller: _tabController,
//                     //           children: [
//                     //             ListView.builder(
//                     //                 itemCount: 10, // :)))
//                     //                 itemBuilder: (context, index) {
//                     //                   return  PostCard(snap: null,); // :))) snap là data thay cho hard code
//                     //                 }),
//                     //             ListView.builder(
//                     //                 itemCount: 10, // :)))
//                     //                 itemBuilder: (context, index) {
//                     //                   return  trendingCard(index: index); // :))) snap là data thay cho hard code
//                     //                 }),
//                     //             ListView.builder(
//                     //                 itemCount: 10, // :)))
//                     //                 itemBuilder: (context, index) {
//                     //                   return  trendingCard(index: index); // :))) snap là data thay cho hard code
//                     //                 }),
//                     //
//                     //           ],
//                     //         ),
//                     //       ),),
//
//                     SliverList(
//                       delegate: SliverChildBuilderDelegate(
//                             (BuildContext context, int index) {
//                           return Container(
//                               color: index.isOdd ? Colors.white : Colors.white,
//                               child: PostCard(snap: null,)
//                           );
//                         },
//                         childCount: 5,
//                       ),
//                     ),
//                   ],
//                 )
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: [
                    ListView.builder(
                        itemCount: 10, // :)))
                        itemBuilder: (context, index) {
                          return  PostCard(snap: null,); // :))) snap là data thay cho hard code
                        }),
                    ListView.builder(
                        itemCount: 10, // :)))
                        itemBuilder: (context, index) {
                          return  trendingCard(index: index); // :))) snap là data thay cho hard code
                        }),
                    ListView.builder(
                        itemCount: 10, // :)))
                        itemBuilder: (context, index) {
                          return  trendingCard(index: index); // :))) snap là data thay cho hard code
                        }),
              ],
            ),
          ),

        ));

  }
}