class CreatePost{
  String? name;
  String? uId;
  String? profileImage;
  String? dateTime;
  String? text;
  String? postImage;


  CreatePost({
    required this.name,
    required this.uId,
    required this.profileImage,
    required this.text,
    required this.dateTime,
    required this.postImage
  });
  CreatePost.fromJson(Map<String, dynamic>json){
    name = json['name'];
    uId = json['uId'];
  text   = json['text'];
    postImage = json['postImage'];
    profileImage = json['profileImage'];
   dateTime  = json['dateTime'];
  }
  Map<String,dynamic> toMap(){
    return {
      'name': name,
      'uId':uId,
      'profileImage': profileImage,
      'text':text,
      'dateTime':dateTime,
      'postImage':postImage
    };
  }
}