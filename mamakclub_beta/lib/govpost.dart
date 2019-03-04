

class TrafficCamMeta{
  final String height;
  final String width;
  final String md5;

  TrafficCamMeta({this.height,this.width,this.md5});
  factory TrafficCamMeta.fromJson(Map<String,dynamic> json){
    return TrafficCamMeta(
       height: json['height'],
       width: json['width'],
       md5 : json['md5']
    );
  }
  
}
class TrafficCam{
  final String timestamp;
  final String camera_id;
  final String image_id;
  final String image;

  TrafficCam({this.timestamp,this.camera_id,this.image_id,this.image});

  factory TrafficCam.fromJson(Map<String,dynamic> json){
    return TrafficCam(
      timestamp:json['timestamp'],
      camera_id:json['camera_id'],
      image_id:json['image_id'],
      image:json['image']
    );
  }
}

class TrafficItem{
  final String timestamp;
  final List<TrafficCam> cameras;

  TrafficItem({this.timestamp,this.cameras});

  factory TrafficItem.fromJson(Map<String,dynamic> json){
    return TrafficItem(
      timestamp: json['timestamp'],
      cameras:(json['cameras'] as List).map((i)=>TrafficCam.fromJson(i)).toList() 
    );
  }

}
class ApiInfo{
  String status;
  ApiInfo({this.status});
  factory ApiInfo.fromJson(Map<String,dynamic> json){
    return new ApiInfo(
      status: json['status']
    );
  }
}
class TrafficPost{
  final ApiInfo apinfo;
  final TrafficItem items;
  
  TrafficPost({this.apinfo,this.items});
  factory TrafficPost.fromJson(Map<String,dynamic> json){
    return TrafficPost(
      apinfo: ApiInfo.fromJson(json['api_info']),
      items: (json['items'] as List).map((i)=>TrafficItem.fromJson(i)).toList().first 
    );
  }
}
