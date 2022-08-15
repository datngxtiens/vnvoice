import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vnvoicemobile/utils/utils.dart';

import '../models/user.dart';
import '../provider/userProvider.dart';
import '../screen/Home/Comment.dart';

// void main() {
//   runApp(PostCard(snap: null,));
// }

class PostCard extends StatefulWidget {
  final snap;
  final bool isPetition;
  final String title;
  final String text;
  final List<String> images;
  final String username;
  final String channel;
  final int comments;
  int signers;
  bool upIconToggle;
  bool downIconToggle;
  int upvotes;
  int downvotes;
  String status;

  PostCard({
    Key? key,
    required this.snap,
    required this.title,
    required this.text,
    required this.images,
    required this.upvotes,
    required this.downvotes,
    required this.username,
    required this.channel,
    required this.comments,
    this.status = 'Active',
    this.signers = 0,
    this.upIconToggle = false,
    this.downIconToggle = false,
    this.isPetition = false,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int currentImage = 0;


  @override
  Widget build(BuildContext context) {
    // final userProvider = Provider.of<UserProvider>(context);
    // User? user = userProvider.user;

    TextEditingController controller = TextEditingController();
    FocusNode focusNode = FocusNode();

    void bottomSheet(context) {
      showModalBottomSheet(context: context, builder: (context){
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            height: 120,
            color: Colors.white,
            child: Column(
              children: [
                const SizedBox(height: 5,),
                const Text("Nhập mật khẩu để xác nhận", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: controller,
                    focusNode: focusNode,
                    obscureText: true,
                    onSubmitted: (value) {
                      Navigator.of(context).pop();
                      setState(() {
                        widget.signers = widget.signers + 1;
                      });
                      showSnackBar("Bạn đã ký đơn thành công", context);
                    },
                    cursorColor: const Color.fromRGBO(218, 81, 82, 1),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color.fromRGBO(218, 81, 82, 1)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color.fromRGBO(218, 81, 82, 1)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color.fromRGBO(218, 81, 82, 1)),
                      ),
                      hintText: "Mật khẩu",
                      prefixIcon: const Icon(Icons.shield, color: Color.fromRGBO(218, 81, 82, 1)),
                      contentPadding: const EdgeInsets.all(8),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      });
    }

    return Container(
          margin: const  EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4).copyWith(right: 0),
                child: Row(
                  children: [
                    const CircleAvatar(
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
                            Text(
                              widget.username,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 18),
                            ),
                            Text(
                              widget.channel,
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                  fontSize: 15),)
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: widget.status == "Active" ? Colors.amber : Colors.green,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text(
                            widget.status == "Active" ? "Đang xử lý" : "Đã tiếp nhận",
                            style: const TextStyle(color: Colors.white),),
                        )
                      ],
                    )

                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  widget.text,
                  style: const TextStyle(
                      color: Colors.black
                  ),
                ),
              ),

              widget.isPetition ?
              InkWell(
                onTap: () => {
                  bottomSheet(context)
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.4,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(40),
                        ),
                      ),
                      color: Color.fromRGBO(218, 81, 82, 1),
                    ),
                    child: const Text("Ký đơn kiến nghị",
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
              ):Container(),

              widget.images.isNotEmpty ?
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
                        itemCount: widget.images.length,
                        itemBuilder: (_, index){
                          currentImage = index;
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(widget.images[index]),
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
                        children: List.generate(widget.images.length, (indexDots) {
                          return Container(
                            margin: const EdgeInsets.only(right: 10, bottom: 10),
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: currentImage == indexDots
                                    ? const Color.fromRGBO(218, 81, 82, 1)
                                    : Colors.white.withOpacity(0.5)),
                          );
                        }),
                    ),
                    )
                  ],
                ),
              ) : Text("Đã có ${widget.signers} người ký kiến nghị này"),

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
                        onPressed: (){
                          setState(() {
                            widget.upIconToggle ?
                            widget.upvotes = widget.upvotes - 1 :
                            widget.upvotes = widget.upvotes + 1;

                            widget.upIconToggle = !widget.upIconToggle;

                            if (widget.downIconToggle) {
                              widget.downIconToggle = false;
                              widget.downvotes = widget.downvotes - 1;
                            } else {
                              widget.downIconToggle = widget.downIconToggle;
                            }
                          });
                        } ,
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                        ),
                        child: Row(children: [
                          widget.upIconToggle? const Icon(Icons.thumb_up): const Icon(Icons.thumb_up_outlined),
                          Padding(padding: const EdgeInsets.only(left: 5.0), child: Text(
                              widget.upvotes.toString()
                          ),)
                        ],)),
                    TextButton(
                        onPressed: (){
                          setState(() {
                            widget.downIconToggle ?
                            widget.downvotes = widget.downvotes - 1 :
                            widget.downvotes = widget.downvotes + 1;

                            widget.downIconToggle = !widget.downIconToggle;

                            if (widget.upIconToggle) {
                              widget.upIconToggle = false;
                              widget.upvotes = widget.upvotes - 1;
                            } else {
                              widget.downIconToggle = widget.downIconToggle;
                            }
                          });
                        } ,
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                        ),
                        child: Row(children: [
                          widget.downIconToggle? const Icon(Icons.thumb_down): const Icon(Icons.thumb_down_outlined),
                          Padding(padding: const EdgeInsets.only(left: 5.0), child: Text(
                              widget.downvotes.toString()
                          ),)
                        ],)),
                    TextButton(
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => CommentScreen(

                              )
                          ),
                        ),
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                        ),
                        child: Row(children: [
                          const Icon(Icons.comment),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text(
                                widget.comments.toString()
                            )
                          )
                        ],)),
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