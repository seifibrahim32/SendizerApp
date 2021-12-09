
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:social_app/registerscreen.dart';

import 'login_screen.dart';

class ChatListScreen extends StatefulWidget{

  final String user_name;
  const ChatListScreen({Key? key,required this.user_name}) : super(key: key);

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {

  int current_index = 0 ;
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          setState((){
            current_index = index;});

        },
        currentIndex: current_index ,
        unselectedLabelStyle: TextStyle(
            color: Colors.white
        ),
        backgroundColor: Color(0xFF312F2F),
        items: [
          BottomNavigationBarItem(
              label: "People",
              tooltip:"People" ,
              icon: Icon(Icons.supervised_user_circle
              )),

          BottomNavigationBarItem(
              label: "Settings",
              tooltip:"Settings" ,
              icon: Icon(Icons.settings)
          )
        ],),

      appBar : AppBar(
        title: Text(
          "${widget.user_name}",
          style:
            TextStyle(
              fontFamily: "SF"
            )
        ),
        centerTitle: true,
       backgroundColor: Color(0xFF312F2F),
        elevation: 0,
          actions:[
            GestureDetector(
              onTap: (){
                auth.signOut();
                Navigator.pushAndRemoveUntil(context,  PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => LoginScreen(),
                  transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                  transitionDuration: Duration(milliseconds: 2000),
                ), (route) => false);
              },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text("Sign Out",
                  style: TextStyle(
                    fontFamily: "SFn"
                  )),
                )
            )
          ]
      ),
        body : Container(
          color: Color(0xFF312F2F),
          child : StreamBuilder<QuerySnapshot>(
            stream: db.collection('users').snapshots(),
              builder:  (context, snapshot){
                if (!snapshot.hasData) {
                  return  Center(
                    child: CircularProgressIndicator(),
                  );
                }
                else {
                  print("size: ${snapshot.data!.docs.length}");
                  return ListView.separated(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Text("${snapshot.data!.docs[index]['email']}",
                        style: TextStyle(color:Colors.white),);
                  }, separatorBuilder: (BuildContext context, int index) {
                    return Container(
                      color: Color(0xFFFF0909),
                      height: 0.75,
                    );
                    },
                );
                }
              }
            ),
        ),

    );
  }
}