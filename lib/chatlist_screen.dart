
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:social_app/reusable_data.dart';
import 'package:social_app/search_screen.dart';
import 'package:social_app/settings_screen.dart';

class ChatListScreen extends StatefulWidget{
  final String user_name;

  const ChatListScreen({Key? key,required this.user_name}) : super(key: key);

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {

  int current_index = 0 ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          setState((){
            current_index = index;
          });
        },
        currentIndex: current_index,
        unselectedLabelStyle: TextStyle(
            color: Colors.white
        ),
        selectedItemColor: Color(0xFF28D4D4),
        backgroundColor: Color(0xFF312F2F),
        items: [
          BottomNavigationBarItem(
              label: "People",
              tooltip:"People" ,
              icon: Icon(Icons.supervised_user_circle)
          ),
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
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                onTap : (){
                  showSearch(
                      context : context,
                      delegate: SearchScreen()
                  );
                },
                child : Stack(
                    alignment: Alignment.center,
                    children:[
                      CircleAvatar(
                        radius: 19,
                        backgroundColor: Colors.grey,
                      ),
                      Icon(Icons.search)
                    ])
              ),
            )
          ]
      ),
        body : Container(
          color: Color(0xFF312F2F),
          child : current_index == 0 ? Chatlist() : SettingsScreen()
        ),

    );
  }
}