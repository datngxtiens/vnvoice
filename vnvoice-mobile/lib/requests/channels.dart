import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vnvoicemobile/requests/urls.dart';
import 'package:vnvoicemobile/models/channel.dart';

Future<http.Response> createChannel(String creatorId, String channelName, {String type="Interactive"}) async {
  final response = await http.post(
      Uri.parse(VnVoiceUri.createChannel),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'creator_id': creatorId,
        'name': channelName,
        'type': type
      }),
  );

  return response;
}

Future<ChannelList> getAllChannel() async {
  final response = await http.get(Uri.parse(VnVoiceUri.getAllChannel));

  if (response.statusCode == 200) {
    return ChannelList.fromJson(jsonDecode(response.body));
  } else {
    return ChannelList(message: 'No channel', channels: []);
  }


}