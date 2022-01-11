import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_app/registerscreen.dart';
import 'package:social_app/shared_pref.dart';

import 'login_screen.dart';

class SettingsScreen extends StatelessWidget {
  TextEditingController val = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Spacer(flex:12),
            GestureDetector(
              onTap: (){
                auth.signOut();
                Navigator.pushAndRemoveUntil(context,  PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => LoginScreen(),
                  transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                  transitionDuration: Duration(milliseconds: 2000),
                ), (route) => false);
              },
              child: Text("Sign Out",
                  style: TextStyle(
                    color : Colors.white,
                      fontFamily: "SF"
                  )),
            ),
            Spacer(flex:12),
            InkWell(
              onTap: (){
                showDialog(context: context,
                    builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Color(0x4E3737),
                      content: new Container(
                      width: 260.0,
                      height: 124.0,
                      decoration: new BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: const Color(0xDF927B7B),
                      borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
                      ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: val,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    fillColor: Colors.white,
                                    labelText: 'Enter divisor value',
                                    hintText: 'Enter divisor value'
                                ),
                              ),
                            ),
                            IconButton(onPressed: () {
                              SharedPrefClass.setString(val.text);
                              Navigator.pop(context);
                            }, icon: Icon(Icons.save),)
                          ],
                        )
                      ),
                  );
                });
              },
              child: Text("Change divisor value",
                  style: TextStyle(
                      color : Colors.white,
                      fontFamily: "SF"
                  )),
            ),
            Spacer(flex:12)
          ],
        ),
      )
    );
  }
}