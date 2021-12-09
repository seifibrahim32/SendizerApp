import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_app/registerscreen.dart';

import 'login_screen.dart';

class SettingsScreen extends StatelessWidget {

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
            Text("About Us",
                style: TextStyle(
                    color : Colors.white,
                    fontFamily: "SF"
                )),
            Spacer(flex:12)
          ],
        ),
      )
    );
  }
}