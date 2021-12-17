import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/reusable_data.dart';
import 'chatlist_screen.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? regkey}) : super(key: regkey);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

enum Gender { Male, Female, Others }

TextEditingController newpassword = TextEditingController();

final auth = FirebaseAuth.instance;

class _RegisterScreenState extends State<RegisterScreen> {

  GlobalKey<FormState> regkey = GlobalKey<FormState>();

  TextEditingController newusername = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController confirm_email = TextEditingController();

  TextEditingController confirm_password = TextEditingController();

  Gender? character = Gender.Male;

  List gender = ["Male", "Female"];

  String gender_registered = "Male";

  var downloadLink ;
  Future<File> getImageFileFromAssets(String path) async {
    print(path);
    final byteData = await rootBundle.load('assets/$path');
    print(byteData);
    final file = await File('${Directory.systemTemp.path}/$path');
    print(file);
    return await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));;
  }

  File? imageFile , croppedImage;

  Row addRadioButton(int btnValue, Gender title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Radio<Gender>(
          activeColor: Theme.of(context).primaryColor,
          value: title,
          groupValue: character,
          onChanged: (Gender? value) {
            setState(() {
              print(value);
              character = value;
              gender_registered = gender[character!.index];
            });
          },
        ),
        Text('${gender[btnValue]}',
            style: TextStyle(color: Colors.white, fontFamily: "SF"))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (c, a1, a2) => LoginScreen(),
                    transitionsBuilder: (c, anim, a2, child) =>
                        FadeTransition(opacity: anim, child: child),
                    transitionDuration: Duration(milliseconds: 2000),
                  ),
                  (route) => false);
            },
          ),
          backgroundColor: Color(0xFF312F2F),
          elevation: 0.0,
        ),
        backgroundColor: Color(0xFF312F2F),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Register with Sendizer..',
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: "SF",
                              color: Colors.white,
                              fontWeight: FontWeight.normal)),
                    ],
                  ),
                  SizedBox(height: 34),
                  imageFile == null ? ClipRRect(
                      borderRadius: BorderRadius.circular(64.0),
                      child: Image.asset(
                          "assets/blank-profile.webp",
                          scale:10.0
                      )) : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(64.0),
                            child: Image.file(imageFile!)),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Container(
                        child: Column(
                            children: [
                              Stack(children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xFF575555),
                              border: Border.all(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(7)
                          ),
                          width: 350,
                          height: 290,
                        ),
                        Form(
                          key: regkey,
                          child: Column(
                              children: [
                            textFormField(
                                suffixIcon: null,
                                hintText: "Username",
                                kind: TextInputType.visiblePassword,
                                context: context,
                                type: "newusername",
                                controller: newusername,
                                isHidden: false),
                            Container(
                                width: 350, height: 1, color: Colors.grey),
                            textFormField(
                                suffixIcon: null,
                                hintText: "Email",
                                kind: TextInputType.emailAddress,
                                context: context,
                                type: "email",
                                controller: email,
                                isHidden: false),
                            Container(
                                width: 350, height: 1, color: Colors.grey),
                            textFormField(
                                hintText: "Password",
                                kind: TextInputType.visiblePassword,
                                context: context,
                                type: "newpassword",
                                controller: newpassword,
                                isHidden: true,
                                suffixIcon: null
                            ),
                            Container(
                                width: 350, height: 1, color: Colors.grey),
                            textFormField(
                                hintText: "Confirm Password",
                                kind: TextInputType.visiblePassword,
                                context: context,
                                type: "confirm_password",
                                controller: confirm_password,
                                isHidden: true,
                                suffixIcon: null
                            ),
                            Container(
                                width: 350, height: 1, color: Colors.grey),
                            Row(children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 34.0),
                                child: Text(
                                  "Gender",
                                  style: TextStyle(
                                      fontFamily: "SF",
                                      color: Colors.white,
                                      fontSize: 16),
                                ),
                              ),
                              SizedBox(width: 55),
                              addRadioButton(0, Gender.Male),
                              addRadioButton(1, Gender.Female),
                            ]),
                            Container(
                                width: 350, height: 1, color: Colors.grey),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical:8.0),
                              child: Row(
                                  children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 34.0),
                                  child: Text(
                                    "Upload an image",
                                    style: TextStyle(
                                        fontFamily: "SF",
                                        color: Colors.white,
                                        fontSize: 16),
                                  ),
                                ),
                                SizedBox(width: 85),
                                GestureDetector(
                                  onTap :() async {
                                    var image = await ImagePicker().pickImage(
                                        source: ImageSource.gallery, imageQuality: 50
                                    );

                                    setState(() {
                                      print("ssrr ${image!.path}");
                                      imageFile = File(image.path);
                                    });
                                    print("Pressed");
                                    croppedImage = await ImageCropper.cropImage(
                                      sourcePath: image!.path,
                                      maxWidth: 150,
                                      maxHeight: 150,
                                        aspectRatioPresets: [
                                          CropAspectRatioPreset.square,
                                        ],
                                        androidUiSettings: AndroidUiSettings(
                                          hideBottomControls: true,
                                            toolbarColor: Colors.deepOrange,
                                            toolbarWidgetColor: Colors.white,
                                            initAspectRatio: CropAspectRatioPreset.original,
                                            lockAspectRatio: false),
                                        iosUiSettings: IOSUiSettings(
                                          minimumAspectRatio: 1.0,
                                        )
                                    );
                                    if (croppedImage != null) {
                                      setState(() {
                                        imageFile = croppedImage;
                                      });
                                    }
                                  },
                                  child: Icon(Icons.add),
                                )
                              ]),
                            )
                          ]),
                        )
                      ]),
                      SizedBox(height: 14),
                      GestureDetector(
                        onTap: () async {
                          if (regkey.currentState!.validate()) {
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);

                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            print("${newusername.text.trim()}");
                            print("${newpassword.text.trim()}");

                            try {
                              QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
                                  .collection('users')
                                  .where("username", isEqualTo: newusername.text.toString())
                                  .get();

                              if(snapshot.size != 0) {
                                for ( int i = 0 ; i < snapshot.docs.length ; i++){
                                  if(snapshot.docs[i]['username'] == newusername.text){
                                    throw Exception('Username is already registered');}
                                }
                              }

                              UserCredential userCredential = await auth
                                  .createUserWithEmailAndPassword(
                                      email: email.text.trim(),
                                      password: newpassword.text.trim()
                              );
                              print(" uid ${userCredential.user!.uid}");

                              DocumentReference<Map<String, dynamic>> users = FirebaseFirestore
                                  .instance
                                  .collection('users')
                                  .doc(userCredential.user!.uid);
                              Reference reference = FirebaseStorage.instance.ref().child("images/"
                                  + DateTime.now().toString());
                              UploadTask? uploadTask;
                              if (croppedImage == null && uploadTask == null) {
                                print("empty image stored $uploadTask");
                                croppedImage = await getImageFileFromAssets('blank-profile.webp');
                                print( "croppedImage ${croppedImage!}");

                                uploadTask = reference.putFile(croppedImage!);
                              }
                              else if(croppedImage != null && uploadTask == null){
                                uploadTask = reference.putFile(croppedImage!);
                              }
                              uploadTask?.then((res) async {
                                downloadLink = await res.ref.getDownloadURL();
                                print(downloadLink.toString());
                                print('File Uploaded');

                                users.set({
                                  "email": email.text.trim().toString(),
                                  "gender": gender_registered,
                                  "password":
                                  confirm_password.text.trim().toString(),
                                  "profileImage" : downloadLink.toString() ,
                                  "username": newusername.text.trim().toString(),
                                  "uId" : userCredential.user!.uid
                                });
                              });
                              await FirebaseFirestore
                                  .instance
                                  .collection('users')
                                  .doc(userCredential.user!.uid)
                                  .collection(
                                  "chats")
                                  .doc(userCredential.user!.uid)
                                  .collection("messages")
                                  .add({});

                              Navigator.pushAndRemoveUntil(context,  PageRouteBuilder(
                                pageBuilder: (c, a1, a2) => ChatListScreen(user_name: newusername.text,
                                    uId : userCredential.user!.uid),
                                transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                transitionDuration: Duration(milliseconds: 2000),
                              ), (route) => false);

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                    'Sucessfully Registered'),
                                duration: Duration(seconds: 2),
                              ));
                            } on FirebaseAuthException catch (error) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("${error.message}"),
                                duration: Duration(seconds: 5),
                              ));
                            } on Exception catch (error) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("${error.toString().split(":")[1]}"),
                                duration: Duration(seconds: 5),
                              ));
                            }
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xFF3A94DB),
                              border: Border.all(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(7)),
                          height: 39,
                          width: 400,
                          child: Center(
                            child: Text(
                              'Create an account',
                              style: TextStyle(
                                  fontFamily: "SF", color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ])),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
