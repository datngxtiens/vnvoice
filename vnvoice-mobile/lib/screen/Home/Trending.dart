import 'package:flutter/material.dart';

import '../../widgets/trendingCard.dart';
import 'Search.dart';

class TrendingScreen extends StatefulWidget {
  const TrendingScreen({Key? key}) : super(key: key);

  @override
  State<TrendingScreen> createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> with TickerProviderStateMixin {
  List<String> allTrending = const [
    "Kỳ thi THPT Quốc gia 2022",
    "Giá xăng giảm lần thứ 5 liên tiếp",
    "Căng thẳng chiến sự Nga - Ukraine",
    "Mưa lớn gây ngập ở Hà Nội",
    "Tai nạn gia thông",
    "Biến thể mới COVID-19",
    "Miss World Vietnam 2022",
    "Kết quả tuyển sinh Đại học 2022",
    "Giá vàng tụt dốc",
    "Lỗi thu phí không dừng"
  ];

  List<String> myTrending = const [
    "Kỳ thi THPT Quốc gia 2022",
    "Cấm bay nữ hành khách tạo dáng sát máy bay đang di chuyển",
    "Căng thẳng chiến sự Nga - Ukraine",
    "Mưa lớn gây ngập ở Hà Nội",
    "Vũng Tàu cấm dùng xà phòng tại trụ tắm nước ngọt công cộng",
    "Biến thể mới COVID-19",
    "Miss World Vietnam 2022",
    "Kết quả tuyển sinh Đại học 2022",
    "Lịch sử trở thành môn học bắt buộc",
    "Bắt đầu năm học mới 2022-2023"
  ];

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);

    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          title: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const SearchScreen()));
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: const Color.fromRGBO(218, 81, 82, 1)),
                  borderRadius: const BorderRadius.all(Radius.circular(10))
              ),
              width: double.infinity,
              height: 30,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children:const [
                    Icon(Icons.search, color: Color.fromRGBO(218, 81, 82, 1),),
                  ]
                ),
              ),
            )
          ),
          backgroundColor: Colors.white,
          actions: const [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage("https://images.unsplash.com/photo-1643791146214-11942f0aba8c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=980&q=80"),
              ),
            )
          ],
      ),
      body: Column(
        children: [
          Align(
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
                Tab(text: "Tất cả",),
                Tab(text: "Dành riêng cho bạn",),
              ],
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
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return trendingCard(index: index, content: allTrending[index]);
                      }),
                  ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return  trendingCard(index: index, content: myTrending[index]);
                      }),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}
