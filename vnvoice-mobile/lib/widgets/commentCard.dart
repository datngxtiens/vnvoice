import "package:flutter/material.dart";

class CommentCard extends StatefulWidget {
  const CommentCard({Key? key}) : super(key: key);

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  bool isReply = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage("https://images.unsplash.com/photo-1657299141998-2aba7e9bdebb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=998&q=80"),
              ),
              Text("Username"),
              Text("Just now")
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Mauris in aliquam sem fringilla ut morbi tincidunt augue interdum. Tellus id interdum velit laoreet"),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(onPressed: (){}, icon: const Icon(Icons.more_horiz)),
                IconButton(onPressed: (){setState((){isReply=true;});}, icon:const Icon(Icons.reply)),
                TextButton(
                    onPressed: (){} ,
                    style: TextButton.styleFrom(
                      primary: Colors.grey.withOpacity(0.5),
                    ),
                    child: Row(children: [Icon(Icons.thumb_up), Text("120")],)),
                TextButton(
                    onPressed: (){} ,
                    style: TextButton.styleFrom(
                      primary: Colors.grey.withOpacity(0.5),
                    ),
                    child: Row(children: [Icon(Icons.thumb_down), Text("120")],)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
