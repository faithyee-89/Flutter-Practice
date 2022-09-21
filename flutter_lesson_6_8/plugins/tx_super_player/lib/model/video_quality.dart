part of cniao5_super_player;

class VideoQuality {
  final int? index;
  final int? bitrate;
  final String? name;
  final String? title;
  final String? url;

  VideoQuality({this.index, this.bitrate, this.name, this.title, this.url});

  factory VideoQuality.fromJson(Map<String, dynamic> json) {
    return VideoQuality(
      index: json['index'] as int,
      bitrate: json['bitrate'] as int,
      name: json['name'] as String,
      title: json['title'] as String,
      url: json['url'] as String,
    );
  }
}
