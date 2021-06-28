import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchHelpers with ChangeNotifier {
  QuerySnapshot searchSnapshot;
  QuerySnapshot get searchusers => searchSnapshot;

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else
      return "$a\_$b";
  }

  initiateSearch(String username) {
    FirebaseFirestore.instance
        .collection("users")
        .where("username", isEqualTo: username)
        .get()
        .then((value) {
      searchSnapshot = value;
      print(searchSnapshot.docs.isEmpty.toString() + " #######");
    });
    notifyListeners();
  }
}
