import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vnvoicemobile/screen/Home/Home.dart';


class ChannelScreen extends StatefulWidget {
  final String channelName;

  const ChannelScreen({
    Key? key,
    required this.channelName
  }) : super(key: key);

  @override
  State<ChannelScreen> createState() => _ChannelScreenState();
}

class _ChannelScreenState extends State<ChannelScreen> with TickerProviderStateMixin{
  List<String> backGroundList = [
    "https://images.unsplash.com/photo-1583417319070-4a69db38a482?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
    "https://images.unsplash.com/photo-1521993117367-b7f70ccd029d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=840&q=80",
    "https://images.unsplash.com/photo-1555921015-5532091f6026?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
    "https://images.unsplash.com/photo-1582473788468-d25f5f398cce?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
    "https://images.unsplash.com/photo-1480996408299-fc0e830b5db1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=869&q=80",
    "https://images.unsplash.com/photo-1528127269322-539801943592?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80"
  ];

  final random = Random();

  @override
  Widget build(BuildContext context) {
    int backgroundItem = random.nextInt(5);
    TabController _tabController = TabController(length: 3, vsync: this);

    return Scaffold(
        body: DefaultTabController(
          length: 3,
          child: NestedScrollView(
            headerSliverBuilder: (context, value) {
              return [
                SliverAppBar(
                  leading: BackButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomeScreenLayout()));
                    },
                  ),
                  pinned: true,
                  backgroundColor: const Color.fromRGBO(218, 81, 82, 1),
                  expandedHeight: 150.0,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black26,
                            minimumSize: const Size(110.0, 10.0)
                          ),
                          child: const Text(
                            "Đã tham gia",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0
                            ),
                          ),
                          onPressed: () {})
                      ),
                    )
                  ],
                  title: Text(widget.channelName),
                  flexibleSpace: FlexibleSpaceBar(
                      background: Stack(children: <Widget>[
                        Container(
                            height: double.infinity,
                            width:double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(backGroundList[backgroundItem]),
                                  fit: BoxFit.cover
                              )
                            ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 70.0),
                        //   child: Stack(
                        //     children: <Widget>[
                        //       Padding(
                        //         padding: const EdgeInsets.only(
                        //           top: 70 / 2.0,
                        //         ),
                        //
                        //         ///here we create space for the circle avatar to get out of the box
                        //         child: Container(
                        //           height: 50.0,
                        //           decoration: const BoxDecoration(color: Colors.transparent),
                        //           width: double.infinity,
                        //         ),
                        //       ),
                        //
                        //       ///Image Avatar
                        //       Positioned(
                        //         left: 20,
                        //         child: Container(
                        //
                        //           width: 70,
                        //           height: 70,
                        //           decoration: BoxDecoration(
                        //             border: Border.all(color: Colors.white, width: 2),
                        //             shape: BoxShape.circle,
                        //             color: Colors.white,
                        //             image: const DecorationImage(
                        //                 image: NetworkImage("https://vnvoice-data.s3.amazonaws.com/image/avatar/anonymous.png"),
                        //                 fit: BoxFit.cover
                        //             ),
                        //             boxShadow: const [
                        //               BoxShadow(
                        //                 color: Colors.black26,
                        //                 blurRadius: 8.0,
                        //                 offset: Offset(0.0, 5.0),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ])),
                ),
                // SliverToBoxAdapter(
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Container(
                //       color: Colors.white,
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: const [
                //           Text(widget.channelName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                //           Text("1.000.234 thành viên"),
                //           Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum libero erat, vestibulum in risus a, accumsan cursus nisl. Duis malesuada eget enim vitae ornare. In a hendrerit lorem. Nam vel leo at erat sodales euismod. Proin commodo tellus nec aliquam faucibus. Curabitur convallis, nibh sit amet ullamcorper tincidunt, nisi dui bibendum ante, nec porttitor nunc arcu vitae tellus. Pellentesque sed nisi dictum, eleifend lorem eu, vulputate nisl. Sed nec mollis mi. Quisque nec pulvinar purus, id posuere metus. Fusce tempor, nunc sed vulputate hendrerit, nunc velit venenatis lacus, nec bibendum orci dolor vitae dolor.")
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
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
                              indicatorColor: const Color.fromRGBO(218, 81, 82, 1),
                              tabs: const [
                                Tab(text: "Bài viết (0)",),
                                Tab(text: "Thành viên (1)",),
                                Tab(text: "Đa phương tiện",),
                              ],
                            ),
                          ),
                        ),
                      ),


                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: const [
                    Center(
                      child: Text('Chưa có bài viết nào'),
                    ),
                    Center(
                      child: Text('Chưa có thành viên nào ngoài bạn'),
                    ),
                    Center(
                      child: Text('Chưa có file đa phương tiện nào'),
                    ),
              ],
            ),
          ),

        ));

  }
}
