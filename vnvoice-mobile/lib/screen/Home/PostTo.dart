import 'package:flutter/material.dart';
import 'Feed.dart';

import 'package:vnvoicemobile/models/channel.dart';

class PostToScreen extends StatefulWidget {
  String channelId;
  String nameChannel;
  List<Channel> channels;

  PostToScreen({
    Key? key,
    required this.channels,
    required this.channelId,
    required this.nameChannel
  }) : super(key: key);

  @override
  State<PostToScreen> createState() => _PostToScreenState();
}

class _PostToScreenState extends State<PostToScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Chọn kênh đăng tải ", style: TextStyle(color: Colors.black)),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop(

                );
              },
              icon: Icon(Icons.close, color: Colors.grey.withOpacity(0.5),),
            ),
          ),
          backgroundColor: Colors.white,
          body: Container(
            child: AutocompleteBasicExample(
                channelId: widget.channelId,
                listChannel: widget.channels
            ),
          )
      ),
    );
  }
}

class AutocompleteBasicExample extends StatefulWidget {
  String channelId;
  List<Channel> listChannel;

  AutocompleteBasicExample({Key? key, required this.channelId, required this.listChannel}) : super(key: key);

  static const bool isTyped = false;
  List<String> _kOptions = [];

  @override
  State<AutocompleteBasicExample> createState() => _AutocompleteBasicExampleState();
}

class _AutocompleteBasicExampleState extends State<AutocompleteBasicExample> {
  bool isTyped = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (Channel channel in widget.listChannel) {
      setState(() {
        debugPrint("Channel ${channel.channelName}");
        widget._kOptions.add(channel.channelName);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 20, left: 20, top:0),
      child: Column(
          children:[
            Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text == '') {
                  return const Iterable<String>.empty();
                }
                return widget._kOptions.where((String option) {
                  return option.contains(textEditingValue.text.toLowerCase());
                });
              },
              optionsViewBuilder:
                  (context, Function(String) onSelected, options) {

                return Material(
                  elevation: 0,
                  color: Colors.white,
                  child: ListView.separated(

                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      final option = options.elementAt(index);
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop(
                            option // Channel tra ve
                          );

                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(width: 5,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(option, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                                  Text("Number of members", style: TextStyle(color: Colors.grey.withOpacity(0.8)),),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: options.length,

                  ),
                );
              },
              fieldViewBuilder:
                  (context, controller, focusNode, onEditingComplete) {
                // this.controller = controller;
                return Padding(
                  padding: const EdgeInsets.only(top:8.0),
                  child: Container(
                    height: 50,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextField(
                              controller: controller,
                              focusNode: focusNode,
                              onEditingComplete: onEditingComplete,
                              cursorColor: Color.fromRGBO(218, 81, 82, 1),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Color.fromRGBO(218, 81, 82, 1)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Color.fromRGBO(218, 81, 82, 1)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Color.fromRGBO(218, 81, 82, 1)),
                                ),
                                hintText: "Tìm kiếm",
                                prefixIcon: Icon(Icons.search, color: Color.fromRGBO(218, 81, 82, 1)),
                                contentPadding: const EdgeInsets.all(0),
                              ),
                              onChanged: (text) {
                                setState((){
                                  if(text=="") {
                                    isTyped = false;
                                  } else {
                                    isTyped = true;
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 10,),
                        GestureDetector(
                            onTap:(){
                              Navigator.of(context, rootNavigator: true,).pop(MaterialPageRoute(builder: (context)=>const FeedScreen()));
                            },
                            child: Text("Cancel", style: TextStyle(fontSize: 15, color: Colors.grey.withOpacity(0.5)),))
                      ],
                    ),
                  ),
                );
              },
              onSelected: (String selection) {
                debugPrint('You just selected $selection');
                // Navigator.of(context).push(
                //     MaterialPageRoute(
                //         builder: (context)=> ChannelScreen(
                //
                //         )
                //     ));
              },

            ),
            !isTyped?
            Container(
              child:Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: (){

                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.black,
                            ),
                            const SizedBox(width: 5,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Name channel", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                                Text("Number of members", style: TextStyle(color: Colors.grey.withOpacity(0.8)),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  // child: Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Text("Thịnh hành trong 24h qua", style: TextStyle(fontSize: 15, color: Colors.grey.withOpacity(0.5)),),
                  //     for(int i=0;i<10;i++)
                  //
                  //
                  //   ],
                ),
              ),
            )
                :
            Container()
          ]
      ),
    );
  }
}


