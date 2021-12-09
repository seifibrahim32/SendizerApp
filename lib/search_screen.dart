import 'package:flutter/material.dart';

class SearchScreen extends SearchDelegate {

  @override
  String get searchFieldLabel => 'Search for contacts';
 

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Search",
            style: TextStyle(color :Colors.black)),
      ),
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xFF312F2F),
          elevation: 0.0),
        fontFamily: "SF",
      hintColor:Colors.white ,
      backgroundColor: Color(0xFF312F2F),
      textSelectionTheme: TextSelectionThemeData(
        selectionHandleColor: Colors.red,
        selectionColor: Colors.green,
        cursorColor: Colors.green,
      ),
    );
  }

  @override
  void showResults(BuildContext context) {
    
  }
  @override
  PreferredSizeWidget buildBottom(BuildContext context) {
    return PreferredSize(
        child: Container(
          color: Colors.white30,
          height: 2.0,
        ),
        preferredSize: Size.fromHeight(0.21)
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      Center(
        child: Container(
          color: Color(0xFF312F2F),
          child: IconButton(
              onPressed: () {
                query = "";
                Navigator.pop(context);
              },
              icon: Icon(Icons.cancel,color: Colors.white,)
          ),
        ),
      ),
    ]; ;
  }

  @override
  Widget? buildLeading(BuildContext context) {
    Container(
      color: Colors.orange,
      child: IconButton(
          icon : Icon(Icons.arrow_back,color: Colors.white,),
          onPressed :(){
            Navigator.pop(context);
          }
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      color: Color(0xFF031313),
    );
    throw UnimplementedError();
  }

}