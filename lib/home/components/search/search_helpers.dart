import 'package:bubblez/auth/authMethods/Authentication.dart';
import 'package:bubblez/auth/authMethods/FirebaseOperations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchHelpers with ChangeNotifier {
  String chatRoomId;
  String get roomId => chatRoomId;
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

  sendToChatroom(
      {BuildContext context,
      String useruid,
      String userName,
      String myName,
      String img}) {
    chatRoomId = getChatRoomId(userName, myName);
    List<String> usersuid = [
      Provider.of<Authentication>(context, listen: false).getUserUid,
      useruid
    ];
    List<String> useravatars = [];
    Map<String, dynamic> chatRoomMap = {
      "usersuid": usersuid,
      "chatRoomId": chatRoomId,
    };
    createChatRoom(chatRoomId, chatRoomMap);
    notifyListeners();
  }

  createChatRoom(String chatRoomId, Map chatRoomMap) {
    FirebaseFirestore.instance
        .collection("chats")
        .doc(chatRoomId)
        .set(chatRoomMap);
  }
}
