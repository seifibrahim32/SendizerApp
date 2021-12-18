
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:social_app/registerscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';

import 'chat_screen_user.dart';

Widget textFormField({
  required Widget? suffixIcon,
  required String hintText,
  required String type ,
  required TextEditingController controller ,
  required BuildContext context , required TextInputType kind, required bool isHidden}) =>
    Padding(
      padding: type == "password"? const EdgeInsets.only(left : 34.0,
          top : 4.0) : const EdgeInsets.only(left : 34.0),
      child: TextFormField(
          obscureText: isHidden,
          controller : controller,
          style: const TextStyle(
              color : Colors.white
          ),
          validator: (value)  {
            print(value);
            if ((value == null || value.isEmpty || value.toString() != newpassword.text ) && type == "confirm_password"){
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(
                      'Re-enter the password correctly',
                      style: TextStyle(
                          fontFamily: "SF"
                      )
                  ),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 5),
                  )
              );
            }
            if ((value == null || value.isEmpty) && type == "username"){
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(
                      'Enter username',
                    style: TextStyle(
                      fontFamily: "SF"
                    )
                  ),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 5),
                  )
              );
            }
            else if ((value == null || value.isEmpty) && type == "password"){
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(
                      'Enter password',
                      style: TextStyle(
                          fontFamily: "SF"
                      )
                  ),backgroundColor: Colors.red,
                    duration: Duration(seconds: 5),
                  )
              );
            }
          },
          decoration: InputDecoration(
            hintStyle:  TextStyle(
                fontFamily: "SF",
                color : Colors.white
            ),
            hintText: hintText,
            suffixIcon: suffixIcon,
            border: InputBorder.none,
          fillColor: Colors.white,
          focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
                color:  Colors.transparent
            ),
          ),
        )
      ),
    );


final db = FirebaseFirestore.instance;

 Widget Chatlist ({required String username,required String uId}) => StreamBuilder<QuerySnapshot>(
     stream: db.collection('users').snapshots(),
     builder:  (context, snapshot){
       try {
         if (!snapshot.hasData) {
           return Center(
             child: CircularProgressIndicator(),
           );
         }
         else {
           print("size: ${snapshot.data!.docs.length}");
           return Padding(
             padding: const EdgeInsets.all(13.0),
             child: ListView.separated(
               itemCount: snapshot.data!.docs.length,
               itemBuilder: (BuildContext context, int index) {
                 print("current uId ${uId}");
                 snapshot.data!.docs.forEach((doc) {
                   if (doc['uId'].toString() != uId) {
                     print("other uIds ${doc['uId']}");
                     print(doc['uId'].toString() != uId);
                     FirebaseFirestore.instance.collection('users')
                         .doc(uId)
                         .collection('chats')
                         .doc(doc['uId']);
                   }
                 });
                 return (snapshot.data!.docs[index]['username'] == username) ?
                 Container() :
                 Material(
                   animationDuration: Duration(microseconds: 1),
                   child: InkWell(
                     hoverColor: Colors.green,
                     onTap: () {
                       Navigator.of(context).push(
                           MaterialPageRoute(
                               builder: (context) =>
                                   ChatUserScreen(
                                       username: snapshot.data!
                                           .docs[index]['username'],
                                       profileURL: snapshot.data!
                                           .docs[index]['profileImage'],
                                       senderuId: uId,
                                       receiveruId: snapshot.data!
                                           .docs[index]['uId']
                                   )
                           )
                       );
                     },
                     child: Ink(
                       color: Color(0xFF312F2F),
                       child: Row(
                         children: [
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Container(
                               child: Stack(
                                   alignment: Alignment.topRight,
                                   children: [
                                     ClipRRect(
                                       borderRadius: BorderRadius.all(
                                           Radius.circular(32)
                                       ),
                                       child: CircleAvatar(
                                         radius: 30,
                                         child: snapshot.
                                         data!.docs[index]['profileImage'] ==
                                             null ? Image.asset(
                                             "assets/blank-profile.webp",
                                             scale: 10.0
                                         ) : Image.network(snapshot.
                                         data!.docs[index]['profileImage']),
                                       ),
                                     ),
                                     Stack(
                                         alignment: Alignment.center,
                                         children: [
                                           Container(
                                             width: 20,
                                             height: 20,
                                             decoration: BoxDecoration(
                                                 color: Color(0xFF312F2F),
                                                 borderRadius: BorderRadius
                                                     .only(
                                                   bottomLeft: Radius.circular(
                                                       14),
                                                   bottomRight: Radius.circular(
                                                       14),
                                                   topLeft: Radius.circular(3),
                                                   topRight: Radius.circular(
                                                       14),
                                                 )
                                             ),
                                           ),
                                           CircleAvatar(
                                               radius: 8,
                                               backgroundColor: Colors.green
                                           )
                                         ]
                                     )
                                   ]
                               ),
                             ),
                           ),
                           Text("${snapshot.data!.docs[index]['username']}",
                             style: TextStyle(
                                 fontFamily: "SFn",
                                 color: Colors.white),),
                         ],
                       ),
                     ),
                   ),
                 );
               },
               separatorBuilder: (BuildContext context, int index) {
                 return Container(
                   width: 5,
                   color: Color(0xFF5A4F4F),
                   height: 0.75,
                 );
               },
             ),
           );
         }
       } on SocketException catch(_){
         print('not connected');
         return Center(
           child :Text("Waiting for a connection .....",
           style: TextStyle(
             fontFamily: "SF"
           ),)
         );
       }
     }
 );

String loggedUser = "";

Widget buildMessage({required String message}) => Align(
  alignment: AlignmentDirectional.centerStart,
  child: Container(
      padding: EdgeInsets.symmetric(vertical : 5, horizontal : 10),
      decoration:  BoxDecoration(
          color: Colors.grey,
          borderRadius :BorderRadiusDirectional.only(
              bottomEnd : Radius.circular(10),
              topEnd : Radius.circular(10),
              bottomStart: Radius.circular(0),
              topStart: Radius.circular(10)
          )
      ),
      child : Text(message,
          style: TextStyle(
              fontSize: 14,
              fontFamily: "SFn",
              color: Colors.white,
              fontWeight: FontWeight.normal)
      )
  ),
);




Widget buildMyMessage({required String message}) => Align(
  alignment: AlignmentDirectional.centerEnd,
  child: Container(
      padding: EdgeInsets.symmetric(vertical : 5, horizontal : 10),
      decoration:  BoxDecoration(
          color: Colors.grey,
          borderRadius :BorderRadiusDirectional.only(
              bottomEnd : Radius.circular(0),
              topEnd : Radius.circular(10),
              bottomStart: Radius.circular(10),
              topStart: Radius.circular(10)
          )
      ),
      child : Text(message,
          style: TextStyle(
              fontSize: 14,
              fontFamily: "SFn",
              color: Colors.white,
              fontWeight: FontWeight.normal)
      )
  ),
);