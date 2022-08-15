import 'package:flutter/material.dart';


import 'Channel.dart';
import 'Feed.dart';


class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: AutocompleteBasicExample(),
        )
      ),
    );
  }
}

class AutocompleteBasicExample extends StatefulWidget {
  const AutocompleteBasicExample({Key? key}) : super(key: key);
  static const bool isTyed = false;
  static const List<String> _kOptions = <String>[
    'aardvark',
    'bobcat',
    'chameleon',
    'aaa',
    'aardvark',
    'bobcat',
    'chameleon',
    'aaa',
    'aardvark',
    'bobcat',
    'chameleon',
    'aaa',
    'aardvark',
    'bobcat',
    'chameleon',
    'aaa'
  ];

  @override
  State<AutocompleteBasicExample> createState() => _AutocompleteBasicExampleState();
}

class _AutocompleteBasicExampleState extends State<AutocompleteBasicExample> {
  bool isTyped = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children:[
          Autocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text == '') {
              return const Iterable<String>.empty();
            }
            return AutocompleteBasicExample._kOptions.where((String option) {
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
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context)=> const ChannelScreen(

                              )
                          ));
                    },
                    child: Container(
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            const CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.black,
                            ),
                            const SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(option),
                                Text("Community - 28.353.907 thành viên")
                              ],
                            )
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
                      if(index ==0) return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Thịnh hành trong 24h qua", style: TextStyle(fontSize: 15, color: Color.fromRGBO(218, 81, 82, 1)),),
                      );
                      return Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.trending_up, color: Color.fromRGBO(218, 81, 82, 1),),
                            const SizedBox(width: 5,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Name post"),
                                Text("Description"),
                                Row(
                                  children: [
                                    CircleAvatar(radius: 9, backgroundColor: Colors.black,),
                                    const SizedBox(width: 5,),
                                    Text("Name community"),
                                  ],
                                )
                              ],
                            ),
                          ],
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


