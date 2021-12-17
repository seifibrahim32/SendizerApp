class MessageModel {
  String senderId = "";
  String receiverId = "";
  String dateTime = "";
  String text = "";


  MessageModel(Map<String, dynamic> json)
  {
    print("the map given ${json}");
    this.senderId = json['senderId'];
    this.receiverId = json['receiverId'];
    this.dateTime = json['dateTime'];
    this.text = json['message'];
  }

  Map<String, dynamic> toMap()
  {
    print("getMap ${{
        'senderId': this.senderId,
        'receiverId': this.receiverId,
        'dateTime': this.dateTime,
        'message': this.text,
        }}");
    return {
      'senderId': this.senderId,
      'receiverId': this.receiverId,
      'dateTime': this.dateTime,
      'message': this.text,
    };
  }
}