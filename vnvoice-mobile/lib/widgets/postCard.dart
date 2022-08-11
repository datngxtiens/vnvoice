import 'package:flutter/material.dart';

import '../screen/Home/Comment.dart';

// void main() {
//   runApp(PostCard(snap: null,));
// }

class PostCard extends StatefulWidget {
  final snap;
  const  PostCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int currentImage = 0;
  static const imgs = [
    "https://images.unsplash.com/photo-1660039031080-7779c1760a0c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80",
    "https://images.unsplash.com/photo-1659983732450-022a449ccd31?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=928&q=80",
    "https://images.unsplash.com/photo-1660036174586-6bfbf900269b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80"
  ];
  @override
  Widget build(BuildContext context) {

    return Container(
          margin: const  EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4).copyWith(right: 0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                          "https://images.unsplash.com/photo-1657299141998-2aba7e9bdebb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=998&q=80"
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('username', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),),
                            const Text('Channel', style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black, fontSize: 15),)
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        IconButton(
                            onPressed: (){},
                            icon: Icon(Icons.more_horiz, color: Colors.black,)),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text("Đang xử lý", style: TextStyle(color: Colors.white),),
                        )
                      ],
                    )

                  ],
                ),
              ),
              const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child:Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Mauris in aliquam sem fringilla ut morbi tincidunt augue interdum. Tellus id interdum velit laoreet. Pellentesque diam volutpat commodo sed. Et sollicitudin ac orci phasellus egestas tellus. Vel pharetra vel turpis nunc eget. Lacus laoreet non curabitur gravida arcu ac tortor dignissim convallis. Vel elit scelerisque mauris pellentesque pulvinar pellentesque habitant. Sed sed risus pretium quam vulputate. Faucibus scelerisque eleifend donec pretium. Malesuada fames ac turpis egestas maecenas pharetra convallis posuere morbi. Et ultrices neque ornare aenean euismod. Aliquam sem fringilla ut morbi.",
                    style:TextStyle(
                        color: Colors.black
                    ),
                  ),
              ),

              Container(
                height: 400,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    PageView.builder(
                        onPageChanged: (index) {
                          setState((){
                            currentImage = index;
                          });
                        },
                        itemCount: imgs.length,
                        itemBuilder: (_, index){
                          currentImage = index;
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(imgs[index]),
                                  fit: BoxFit.cover,

                                )
                            ),
                            height: 400,
                            width: double.infinity,
                          );
                        }
                    ),
                    Positioned(
                      bottom:0,
                      child: Row(
                        children: List.generate(imgs.length, (indexDots) {
                          return Container(
                            margin: const EdgeInsets.only(right: 10, bottom: 10),
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: currentImage == indexDots
                                    ?Color.fromRGBO(218, 81, 82, 1)
                                    : Colors.white.withOpacity(0.5)),
                          );
                        }),
                    ),)
                  ],
                ),
              ),

              // Stack(
              //     alignment: Alignment.center,
              //     children:[
              //       SizedBox(
              //         height: 400,
              //         width: double.infinity,
              //         child: Image.network(
              //           "https://images.unsplash.com/photo-1657299141998-2aba7e9bdebb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=998&q=80",
              //           fit: BoxFit.cover,
              //         ),
              //       ),
              //     ]
              // ),
              const SizedBox(height: 10,),

              Container(
                decoration: BoxDecoration(
                  border: Border.symmetric(horizontal: BorderSide(color: Colors.grey.withOpacity(0.5)))
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: (){} ,
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                        ),
                        child: Row(children: [Icon(Icons.thumb_up), Text("120")],)),
                    TextButton(
                        onPressed: (){} ,
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                        ),
                        child: Row(children: [Icon(Icons.thumb_down), Text("120")],)),
                    TextButton(
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context)=> CommentScreen(

                              )
                          ),
                        ),
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                        ),
                        child: Row(children: [Icon(Icons.comment), Text("120")],)),
                    IconButton(
                        onPressed: (){},
                        icon: const Icon(Icons.bookmark)
                    ),
                  ],
                ),
              )
            ],
          ),
    );
  }
}