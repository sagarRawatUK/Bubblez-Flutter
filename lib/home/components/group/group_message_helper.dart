import 'package:bubblez/auth/authMethods/Authentication.dart';
import 'package:bubblez/auth/authMethods/FirebaseOperations.dart';
import 'package:bubblez/home/components/chat_tabs/chat_group_tab_screen.dart';
import 'package:bubblez/style/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class GroupMessageHelpers with ChangeNotifier {
  bool hasMemberJoined = false;
  String lastMessageTime;
  String get getLastMessageTime => lastMessageTime;
  bool get getHasMemberJoined => hasMemberJoined;

  sendMessage(BuildContext context, DocumentSnapshot documentSnapshot,
      TextEditingController messageController) {
    return FirebaseFirestore.instance
        .collection('chatrooms')
        .doc(documentSnapshot.id)
        .collection('messages')
        .add({
      'message': messageController.text,
      'time': Timestamp.now(),
      'useruid': Provider.of<Authentication>(context, listen: false).getUserUid,
      'username': Provider.of<FirebaseOperations>(context, listen: false)
          .getInitUserName,
      'userimage': Provider.of<FirebaseOperations>(context, listen: false)
          .getInitUserImage,
    });
  }

  Future checkIfJoined(BuildContext context, String chatRoomName,
      String chatRoomAdminUid) async {
    return FirebaseFirestore.instance
        .collection('chatrooms')
        .doc(chatRoomName)
        .collection('members')
        .doc(Provider.of<Authentication>(context, listen: false).getUserUid)
        .get()
        .then((value) {
      hasMemberJoined = false;
      print('Inital state => $hasMemberJoined');
      if (value.data()['joined'] != null) {
        hasMemberJoined = value.data()['joined'];
        print('Final state => $hasMemberJoined');
        notifyListeners();
      }
      if (Provider.of<Authentication>(context, listen: false).getUserUid ==
          chatRoomAdminUid) {
        hasMemberJoined = true;
        notifyListeners();
      }
    });
  }

  askToJoin(BuildContext context, String roomName) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 70,
        color: primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
                onTap: () async {
                  FirebaseFirestore.instance
                      .collection('chatrooms')
                      .doc(roomName)
                      .collection('members')
                      .doc(Provider.of<Authentication>(context, listen: false)
                          .getUserUid)
                      .set({
                    'joined': true,
                    'username':
                        Provider.of<FirebaseOperations>(context, listen: false)
                            .getInitUserName,
                    'userimage':
                        Provider.of<FirebaseOperations>(context, listen: false)
                            .getInitUserImage,
                    'useruid':
                        Provider.of<Authentication>(context, listen: false)
                            .getUserUid,
                    'time': Timestamp.now()
                  }).whenComplete(() {
                    Navigator.pop(context);
                  });
                },
                child: Text(
                  "Join ",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Colors.white, fontSize: 15),
                )),
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Colors.white, fontSize: 15),
                )),
          ],
        ),
      ),
    );
  }

  showLastMessageTime(dynamic timeData) {
    Timestamp t = timeData;
    DateTime dateTime = t.toDate();
    lastMessageTime = timeago.format(dateTime);
    notifyListeners();
  }

  leaveTheRoom(BuildContext context, String chatRoomName) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text('Leave $chatRoomName?',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500)),
            actions: [
              MaterialButton(
                  child: Text('No',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0)),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              MaterialButton(
                  color: primaryColor,
                  child: Text('Yes',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0)),
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection('chatrooms')
                        .doc(chatRoomName)
                        .collection('members')
                        .doc(Provider.of<Authentication>(context, listen: false)
                            .getUserUid)
                        .delete()
                        .whenComplete(() {
                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => ChatGroupTabScreen()));
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    });
                  })
            ],
          );
        });
  }
}
