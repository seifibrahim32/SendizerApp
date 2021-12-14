import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:social_app/reusable_data.dart';

import 'message_model.dart';

class ChatUserScreen extends StatefulWidget{

  String username = "", profileURL = "",
  senderuId = "" , receiveruId = "";


  List<MessageModel> messages = [];
  ChatUserScreen({Key? key ,
    required this.username,
    required this.profileURL,
    required this.senderuId,
    required this.receiveruId
  }) : super(key: key);

  @override
  State<ChatUserScreen> createState() => _ChatUserScreenState();
}

class _ChatUserScreenState extends State<ChatUserScreen> {

  TextEditingController message = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  void getMessages ({
    required String receiverId,
    required String senderuId
  }) async {
      FirebaseFirestore.instance
        .collection('users')
        .doc(senderuId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      widget.messages = [];
      event.docs.forEach((element) {
        MessageModel model = MessageModel(element.data());
        widget.messages.add(model);
        print("dataaaaaaaaaaaaaaa ${model.toMap()}");
        //print("dataaaaaaaaaaaaaaa ${widget.messages[0].toMap()['message']}");
        print(widget.messages.toList());
      });

    });

    print("Messages items ${widget.messages.length}");
  }

  @override
  void initState() {
    super.initState();
    getMessages(receiverId : widget.receiveruId ,senderuId : widget.senderuId);
    print("jiii");
  }

  @override
  Widget build(BuildContext context) {
    print(widget.username);
    print(widget.messages.length);
    return SafeArea(
      child: Scaffold(
        appBar : AppBar(
          backgroundColor: Colors.grey,
          automaticallyImplyLeading: true,
          title: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(
                    Radius.circular(32)
                ),
                child: CircleAvatar(
                  radius: 19,
                  child:
                  widget.profileURL == "" ? Image.asset(
                      "assets/blank-profile.webp",
                      scale:10.0
                  ) :Image.network(widget.profileURL),
                ),
              ),
              SizedBox(width:10),
              Text("${widget.username}",
                style: TextStyle(
                    fontFamily : "SF",
                    color:Colors.white
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.black,
        body :  Stack(
          children: [Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Conditional.single(
                    conditionBuilder:
                        (context) => widget.messages.isNotEmpty,
                    context: context,
                    fallbackBuilder: (context) => Center(child: CircularProgressIndicator()),
                    widgetBuilder: (context) {
                      print("hiiiiiiihii");
                      return Expanded(
                        child: SizedBox(
                          height : 550,
                          child: ListView.separated(
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context,index) =>
                              (widget.messages[index].toMap()['senderId'].toString() == widget.senderuId
                                  && widget.messages[index].toMap()['message'].toString().length != 0)?
                              buildMyMessage(message : widget.messages[index].toMap()['message'].toString()):
                              buildMessage(
                                  message: widget.messages[index].toMap()['message'].toString()
                              ),
                              separatorBuilder: (context,index) => SizedBox(height:10),
                              itemCount: widget.messages.length
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  flex : 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration : BoxDecoration(
                                color: Colors.grey,
                                borderRadius : BorderRadius.only(
                                    bottomRight: Radius.circular(0),
                                    topRight: Radius.circular(0),
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8)
                                )
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical :5.0,horizontal:16),
                              child: TextFormField(
                                controller : message,
                                decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        fontFamily : "SF",
                                        color:Colors.white
                                    ),
                                    border: InputBorder.none,
                                    hintText: "Type your message"
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height : 58,
                          color : Colors.green[300],
                          child : MaterialButton(
                              elevation: 0.9,
                              minWidth: 1.0,
                              color: Colors.green[300],
                              onPressed: (){
                                FirebaseFirestore
                                    .instance
                                    .collection('users')
                                    .doc(widget.senderuId)
                                    .collection(
                                    "chats")
                                    .doc(widget.receiveruId)
                                    .collection("messages")
                                    .add({
                                  'senderId':widget.senderuId,
                                  'receiverId' : widget.receiveruId,
                                  'message' : message.text,
                                  'dateTime' : DateTime.now().toString()
                                });
                                FirebaseFirestore
                                    .instance
                                    .collection('users')
                                    .doc(widget.receiveruId)
                                    .collection(
                                    "chats")
                                    .doc(widget.senderuId)
                                    .collection("messages")
                                    .add({
                                  'senderId':widget.senderuId,
                                  'receiverId' : widget.receiveruId,
                                  'message' : message.text,
                                  'dateTime' : DateTime.now().toString()
                                });
                                getMessages(receiverId : widget.receiveruId ,senderuId : widget.senderuId);
                                message.clear();
                              },
                              child : Icon(Icons.send)
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ]
          ),
          ])
      ),
    );
  }
}
