
class Video{
  String video_id = "";
  String video_url = "";
  String video_title = "";
  String thumbNailUrl = "";
  String duration = "";

  Video({required this.video_id, required this.video_url, required this.video_title, required this.thumbNailUrl,
      required this.duration});

  Video.fromJson(Map<dynamic, dynamic> json)
    : video_id = json["video_id"].toString(),
        video_title = json["video_title"].toString(),
        video_url = json["video_url"].toString(),
        thumbNailUrl = json["thumbNailUrl"].toString(),
        duration = json["duration"].toString();
}
