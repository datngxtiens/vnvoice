import "package:flutter/material.dart";

class trendingCard extends StatefulWidget {
  final int index;
  const trendingCard({Key? key, required this.index}) : super(key: key);

  @override
  State<trendingCard> createState() => _trendingCardState();
}

class _trendingCardState extends State<trendingCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(

        children:[
          Text((widget.index + 1).toString(),style: TextStyle(color: Color.fromRGBO(218, 81, 82, 1)),),
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Bộ Giáo dục và Đào tạo đã bình luận về bài viết của bạn", style: TextStyle(fontSize: 15),),
                    const SizedBox(height: 5,),
                    Text("Just now")
                  ],
                ),
              )
          ),
        ],
      ),
    );
  }
}
