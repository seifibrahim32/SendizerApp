import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:social_app/reusable_data.dart';
import 'package:social_app/shared_pref.dart';

import 'message_model.dart';

class ChatUserScreen extends StatefulWidget{
  final fb = FirebaseDatabase.instance;
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

  bool opened = false;
  TextEditingController message = TextEditingController();
  ScrollController _scrollController = new ScrollController();

  @override
  void dispose() {
    widget.fb.reference().remove();
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
      widget.messages.clear();
      event.docs.forEach((element) {
        MessageModel model = MessageModel(element.data());
        setState((){
          widget.messages.add(model);
        });
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
    print("super.initState()");
  }

  @override
  Widget build(BuildContext context) {
    final ref = widget.fb.reference();
    print(widget.username);
    print(widget.messages.length);
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
        appBar : AppBar(
          backgroundColor: Color(0x1177B2EF),
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
                  widget.profileURL == null ? Image.asset(
                      "assets/blank-profile.webp",
                      scale:10.0
                  ) :Image.network(widget.profileURL),
                ),
              ),
              SizedBox(width:10),
              Text("${widget.username}",
                style: TextStyle(
                    fontFamily : "SFn",
                    color:Colors.white
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.black,
        body :  SingleChildScrollView(
          child: Align(
            alignment: Alignment.bottomCenter,
            child:
              Column(
                children :[
                  Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Conditional.single(
                            conditionBuilder:
                                (context) => widget.messages.isNotEmpty,
                            context: context,
                            fallbackBuilder: (context) => Center(child: CircularProgressIndicator()),
                            widgetBuilder: (context) {
                              return SizedBox(
                                height : 547,
                                child: ListView.separated(
                                    controller: _scrollController,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context,index) {
                                      if (widget.messages[index].toMap()['senderId'].toString() == widget.senderuId
                                          && widget.messages[index].toMap()['message'].toString().length != 0 ) {
                                        if(index == widget.messages.length - 1) {

                                          widget.fb.reference().remove();
                                          /*
                                    ref.child("Sender: ${loggedUser}").set(
                                        widget.messages[index].toMap()['message']
                                            .toString()
                                    );

                                     */
                                          ref.child("message")
                                              .child("message").set("Sender: $loggedUser "
                                              "${widget.messages[index].toMap()['message']
                                              .toString()}"
                                          );
                                        }
                                        //http.get(Uri.parse("http://192.168.43.120/on"));
                                        return buildMyMessage(message : widget.messages[index].toMap()['message'].toString(),context: context);
                                      }
                                      else {
                                        if(index == widget.messages.length - 1) {
                                          widget.fb.reference().remove();
                                          /*
                                    ref.child("Receiver: ${widget.username}").set(
                                        widget.messages[index].toMap()['message'].toString());

                                     */
                                          ref.child("message")
                                              .child("message").set("Receiver: ${loggedUser} "
                                              "${widget.messages[index].toMap()['message']
                                              .toString()}"
                                          );
                                        }
                                        // http.get(Uri.parse("http://192.168.43.120/off"));
                                        return buildMessage(
                                            message: widget.messages[index]
                                                .toMap()['message'].toString()
                                            ,context: context
                                        );
                                      }
                                    },
                                    separatorBuilder: (context,index) => SizedBox(height:10),
                                    itemCount: widget.messages.length
                                ),
                              );
                            },
                          ),
                        ),
                      ]
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration : BoxDecoration(
                                color: Color(0x11A6CDFA),
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
                                style: TextStyle(
                                    fontFamily : "SF",
                                    color:Colors.white
                                ) ,
                                controller : message,
                                decoration: InputDecoration(

                                    fillColor : Colors.white,
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
                          color : Colors.blueAccent,
                          child : MaterialButton(
                              elevation: 0.9,
                              minWidth: 1.0,
                              color: Colors.blueAccent,
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

                                setState((){
                                  opened = true;
                                });
                                //getMessages(receiverId : widget.receiveruId ,senderuId : widget.senderuId);
                                message.clear();
                              },
                              child : Icon(Icons.send)
                          ),
                        )
                      ],
                    ),
                  )
                ]
              )
            ),
        )
      ),
    );
  }
}
