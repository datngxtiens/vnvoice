class Channel {
  String channelId;
  String channelName;
  String creatorId;
  String status;

  Channel({required this.channelId,required this.channelName, required this.creatorId, required this.status});

  factory Channel.fromJson(Map<String, dynamic> json) {
    return Channel(
        channelId: json["channel_id"],
        channelName: json["channel_name"],
        creatorId: json["creator_id"],
        status: json["channel_status"]
    );
  }
}

class ChannelList {
  String message;
  List<Channel> channels;

  ChannelList({ required this.message, required this.channels});

  factory ChannelList.fromJson(Map<String, dynamic> json) {
    List<Channel> list = [];

    json.forEach((key, value) {
      if (key == "data") {
        json[key].forEach((channel) {
          list.add(Channel.fromJson(channel));
        });
      }
    });
    return ChannelList(channels: list, message: json["message"]);
  }
}