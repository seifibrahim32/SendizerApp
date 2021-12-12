import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatUserScreen extends StatefulWidget{

  ChatUserScreen();

  @override
  State<ChatUserScreen> createState() => _ChatUserScreenState();
}

class _ChatUserScreenState extends State<ChatUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF575555) ,
      appBar :AppBar(
        backgroundColor: Color(0xFF575555),
        leading: InkWell(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back)),
          elevation : 1.0
      ),
      body : Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            Align(
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
                  child : Text('Hi,Abdullah',
                      style: TextStyle(
                    fontSize: 14,
                    fontFamily: "SFn",
                    color: Colors.white,
                    fontWeight: FontWeight.normal)
                  )
              ),
            ),
            SizedBox(height: 5),
            Align(
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
                  child : Text('Hi',
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: "SFn",
                          color: Colors.white,
                          fontWeight: FontWeight.normal)
                  )
              ),
            )
          ],
        ),
      )
    );
  }
}