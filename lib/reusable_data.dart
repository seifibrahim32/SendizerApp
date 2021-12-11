
import 'package:flutter/material.dart';
import 'package:social_app/registerscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';

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

 Widget Chatlist ({required String username}) => StreamBuilder<QuerySnapshot>(
     stream: db.collection('users').snapshots(),
     builder:  (context, snapshot){
       if (!snapshot.hasData) {
         return  Center(
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
               return (snapshot.data!.docs[index]['username'] == username)?Container():Row(
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
                               child:snapshot.
                               data!.docs[index]['profileImage'] == null ? Image.asset(
                                   "assets/blank-profile.webp",
                                   scale:10.0
                               ) :Image.network(snapshot.
                       data!.docs[index]['profileImage']),
                         ),
                           ),
                           Stack(
                             alignment : Alignment.center,
                             children :[
                               Container(
                                 width : 20,
                                 height: 20,
                                decoration: BoxDecoration(
                                    color : Color(0xFF312F2F),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(14) ,
                                    bottomRight: Radius.circular(14),
                                    topLeft: Radius.circular(3),
                                    topRight: Radius.circular(14),
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
                     style: TextStyle(color:Colors.white),),
                 ],
               );
             }, separatorBuilder: (BuildContext context, int index) {
             return Container(
               color: Color(0xFFFF0909),
               height: 0.75,
             );
           },
           ),
         );
       }
     }
 );