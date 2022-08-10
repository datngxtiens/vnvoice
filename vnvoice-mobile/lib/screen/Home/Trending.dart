import 'package:flutter/material.dart';

import '../../widgets/trendingCard.dart';
import 'Search.dart';



class TrendingScreen extends StatefulWidget {
  const TrendingScreen({Key? key}) : super(key: key);

  @override
  State<TrendingScreen> createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);
    TextEditingController _passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          title: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SearchScreen()));
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),

                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              width: double.infinity,
              height: 30,
              child: Row(
                children:[
                  Icon(Icons.search),
                  Text("Tìm kiếm")
                ]
              ),
            )
          ),
          backgroundColor: Colors.white,
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage("https://images.unsplash.com/photo-1643791146214-11942f0aba8c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=980&q=80"),
              ),
            )
          ],
      ),
      body: Container(
        child: Column(
          children: [
            Container(
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
                    Tab(text: "Tất cả",),
                    Tab(text: "Dành riêng cho bạn",),
                  ],
                ),
              ),
            ),

            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 10),
                // height: MediaQuery.of(context).size.height*0.75,
                width: double.infinity,
                child: TabBarView(
                  controller: _tabController,
                  children: [
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
            ),
          ],
        ),
      )
    );
  }
}
