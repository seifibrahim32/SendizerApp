import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_app/registerscreen.dart';
import 'package:social_app/reusable_data.dart';

import 'chatlist_screen.dart';

class LoginScreen extends StatefulWidget {

  @override
  State<LoginScreen> createState() => LoginScreenState();
}
bool isHidden = true;
class LoginScreenState extends State<LoginScreen> {


  GlobalKey<FormState> key = GlobalKey<FormState>();

  TextEditingController username = TextEditingController();

  TextEditingController password = TextEditingController();


  @override
  void initState() {
    super.initState();

  }

  Widget loginScreen({required BuildContext context,required TextEditingController username  ,
    required TextEditingController password}) => SingleChildScrollView(
    child:
    Form(
      key : key,
      child: Column(
          children :[
            SizedBox(height : 125),
            Row(
              children: [
                Text(
                  'Chat with your friends online\n\n anywhere , anytime ....',
                  style: TextStyle(
                      fontFamily: "SF",
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.normal
                  ),
                ),
              ],
            ),
            SizedBox(
                height: 30
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  Text('Sign in to your account',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "SFn",
                          color : Color(0xFFA1A0A0),
                          fontWeight: FontWeight.normal
                      )),
                ],
              ),
            ),
            SizedBox(
                height: 40
            ),
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xFF575555),
                      border : Border.all(
                          color: Colors.transparent
                      ),
                      borderRadius: BorderRadius.circular(7)
                  ),
                  width: 350,
                  height:100,
                ),
                Column(
                    children:[
                      textFormField(
                          suffixIcon : null,
                          hintText: "Username",
                          kind : TextInputType.text,
                          context : context,
                          type : "username",
                          controller : username,
                          isHidden: false
                      ),
                      Container(
                          width: 350,
                          height: 1,
                          color : Colors.grey
                      ),
                      textFormField(
                          suffixIcon : IconButton(
                            icon:Padding(
                              padding: const EdgeInsets.only(bottom:8.0),
                              child: Icon(
                                isHidden == false
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,),
                            ),
                            onPressed: () => setState(()  => isHidden = !isHidden ),
                          ),
                          hintText: "Password",
                          kind : TextInputType.visiblePassword,
                          context : context,
                          type : "password",
                          controller : password,
                          isHidden: isHidden
                      ),
                    ]
                )
              ],
            ),
            SizedBox(
                height: 13
            ),
            GestureDetector(
              onTap: () async {
                if (key.currentState!.validate()) {

                  FocusScopeNode currentFocus = FocusScope.of(context);

                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }

                  try {
                  QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
                      .collection('users')
                      .where("username", isEqualTo: username.text.toString())
                      .get();

                  if(snapshot.size != 0 && snapshot.docs[0]['password'] == password.text) {
                    FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: snapshot.docs[0]['email'],
                        password: snapshot.docs[0]['password']
                    );
                    print("Signed");
                    Navigator.pushAndRemoveUntil(context,  PageRouteBuilder(
                      pageBuilder: (c, a1, a2) => ChatListScreen(user_name: username.text),
                      transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                      transitionDuration: Duration(milliseconds: 2000),
                    ), (route) => false);

                  }
                  else if (snapshot.size == 0){
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text("The given account isn't registered",
                            style: TextStyle(
                            fontFamily : "SN"
                            )),
                            duration: const Duration(seconds: 5)),
                        );
                  }
                  else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                          content: Text("Password is incorrect",
                          style: TextStyle(
                              fontFamily : "SN"
                          ) ),
                          duration: const Duration(seconds: 5)),
                    );
                  }

                } on FirebaseAuthException catch (error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("${error.message}"),
                          duration: Duration(seconds: 5),
                        )
                    );
                  }
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color : Color(0xFF3A94DB),
                    border : Border.all(
                        color: Colors.transparent
                    ),
                    borderRadius: BorderRadius.circular(7)
                ),
                height: 39,
                width: 400,
                child: Center(
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                        fontFamily: "SF",
                        color: Colors.white
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
                height: 33
            ),
            Text("New to Sendizer ?",
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "SFn",
                    color : Color(0xFFA1A0A0),
                    fontWeight: FontWeight.normal
                )),
            GestureDetector(
              onTap :(){
                Navigator.pushAndRemoveUntil(context,  PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => RegisterScreen(),
                  transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                  transitionDuration: Duration(milliseconds: 2000),
                ), (route) => false);
              },
              child: Text("Create an account.",
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "SFn",
                      color : Color(0xFF28D4D4),
                      fontWeight: FontWeight.normal
                  )),
            )
          ]
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {

    print("isHidden: ${isHidden}");
    return Scaffold(
      backgroundColor : Color(0xFF312F2F),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: loginScreen(context:context,username:username,password:password),
        ),
      ),
    );
  }
}