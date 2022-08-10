import "package:flutter/material.dart";

class notificationCard extends StatefulWidget {
  final bool isMark;
  const notificationCard({Key? key, required this.isMark}) : super(key: key);

  @override
  State<notificationCard> createState() => _notificationCardState();
}

class _notificationCardState extends State<notificationCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: widget.isMark?Color.fromRGBO(234, 243, 255, 1):Colors.white,
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage("https://images.unsplash.com/photo-1659879003682-839ccc766fd5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80"),
          ),
          Expanded(
              flex: 2,
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
          IconButton(onPressed: (){}, icon:  Icon(Icons.more_horiz))
        ],
      ),
    );
  }
}
