import "package:flutter/material.dart";

class trendingCard extends StatefulWidget {
  final int index;
  final String content;

  const trendingCard({Key? key, required this.index, required this.content}) : super(key: key);

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
          Text((widget.index + 1).toString(),style: const TextStyle(color: Color.fromRGBO(218, 81, 82, 1)),),
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.content, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                    const SizedBox(height: 5,),
                    const Text("Just now")
                  ],
                ),
              )
          ),
        ],
      ),
    );
  }
}
