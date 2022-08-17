import 'dart:math';

import 'package:flutter/material.dart';
import 'Feed.dart';

import 'package:vnvoicemobile/models/channel.dart';

class PostToScreen extends StatefulWidget {
  final String channelId;
  final String nameChannel;
  final List<Channel> channels;

  const PostToScreen({
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
            title: const Text("Chọn kênh đăng tải ", style: TextStyle(color: Colors.black)),
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
          body: AutocompleteBasicExample(
              channelId: widget.channelId,
              listChannel: widget.channels
          )
      ),
    );
  }
}

class AutocompleteBasicExample extends StatefulWidget {
  final random = Random();
  final String channelId;
  final List<Channel> listChannel;

  AutocompleteBasicExample({Key? key, required this.channelId, required this.listChannel}) : super(key: key);

  static const bool isTyped = false;
  final List<String> _kOptions = [];

  @override
  State<AutocompleteBasicExample> createState() => _AutocompleteBasicExampleState();
}

class _AutocompleteBasicExampleState extends State<AutocompleteBasicExample> {
  bool isTyped = false;

  @override
  void initState() {
    super.initState();
    for (Channel channel in widget.listChannel) {
      setState(() {
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
                      final Channel channel = widget.listChannel[index];
                      int member = widget.random.nextInt(50000);

                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop(
                            "{\"channelName\": \"${channel.channelName}\",\"channelId\": \"${channel.channelId}\"}" // Channel tra ve
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
                                  Text(channel.channelName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text("$member thành viên", style: TextStyle(color: Colors.grey.withOpacity(0.8)),),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: options.length,
                  ),
                );
              },
              fieldViewBuilder:
                  (context, controller, focusNode, onEditingComplete) {
                // this.controller = controller;
                return Padding(
                  padding: const EdgeInsets.only(top:8.0),
                  child: SizedBox(
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
                                hintText: "Tìm kiếm",
                                prefixIcon: const Icon(Icons.search, color: Color.fromRGBO(218, 81, 82, 1)),
                                contentPadding: const EdgeInsets.all(0),
                              ),
                              onChanged: (text) {
                                setState(() {
                                  if (text=="") {
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
                              Navigator.of(context, rootNavigator: true,).pop(MaterialPageRoute(builder: (context) => const FeedScreen()));
                            },
                            child: Text("Cancel", style: TextStyle(fontSize: 15, color: Colors.grey.withOpacity(0.5)),))
                      ],
                    ),
                  ),
                );
              },
              onSelected: (String selection) {
                debugPrint('You just selected $selection');
              },

            ),
            !isTyped?
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: widget.listChannel.length,
                itemBuilder: (BuildContext context, int index) {
                  int member = widget.random.nextInt(50000);
                  final Channel channel = widget.listChannel[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true,).pop(
                          "{\"channelName\": \"${channel.channelName}\",\"channelId\": \"${channel.channelId}\"}" // Channel tra ve
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
                              Text(channel.channelName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                              Text("$member thành viên", style: TextStyle(color: Colors.grey.withOpacity(0.8)),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
                :
            Container()
          ]
      ),
    );
  }
}


