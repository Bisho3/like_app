class MessageModel{
  String? senderId;
  String? receiverId;
  String? dateTime;
  String? text;
  MessageModel({
    this.text,
    this.dateTime,
    this.receiverId,
    this.senderId
});

  MessageModel.fromJson(Map<String, dynamic>json){
    receiverId = json['receiverId'];
    senderId = json['senderId'];
    text   = json['text'];
    dateTime  = json['dateTime'];
  }
  Map<String,dynamic> toMap(){
    return {
      'receiverId':receiverId,
      'senderId':senderId,
      'text':text,
      'dateTime':dateTime,
    };
  }}