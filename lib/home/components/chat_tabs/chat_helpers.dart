import 'dart:io';

import 'package:bubblez/auth/authMethods/FirebaseOperations.dart';
import 'package:bubblez/style/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatroomHelpers with ChangeNotifier {
  final picker = ImagePicker();
  File chatroomAvatar;
  File get chatroomAvatarFile => chatroomAvatar;
  String latestMessageTime;
  String get getLatestMessageTime => latestMessageTime;
  String chatroomAvatarUrl, chatroomID;
  String get getChatroomID => chatroomID;
  String get getChatroomAvatarUrl => chatroomAvatarUrl;

  Future pickChatroomAvatar(BuildContext context, ImageSource source) async {
    final pickedUserAvatar = await picker.getImage(source: source);
    pickedUserAvatar == null
        ? print('Select image')
        : chatroomAvatar = File(pickedUserAvatar.path);
    // print(userAvatar.path);
    if (chatroomAvatar != null) {
      await Provider.of<FirebaseOperations>(context, listen: false)
          .uploadChatroomAvatar(context);
    } else
      print('Image not Selected ');
    notifyListeners();
  }

  Future selectChatroomAvatarOptionsSheet(BuildContext context) async {
    return showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 70,
        color: primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                pickChatroomAvatar(context, ImageSource.camera).whenComplete(
                  () {
                    Navigator.pop(context);
                  },
                );
              },
              child: Icon(Icons.camera_alt),
            ),
            // GestureDetector(
            //   onTap: () {
            //     Navigator.of(context).push(
            //         MaterialPageRoute(builder: (context) => UploadScreen()));
            //   },
            //   child: FaIcon(
            //     FontAwesomeIcons.video,
            //     size: 20,
            //   ),
            // ),
            GestureDetector(
              onTap: () {
                pickChatroomAvatar(context, ImageSource.gallery).whenComplete(
                  () {
                    Navigator.pop(context);
                  },
                );
              },
              child: Icon(Icons.image),
            ),
          ],
        ),
      ),
    );
  }

  showLastMessageTime(dynamic timeData) {
    Timestamp t = timeData;
    DateTime dateTime = t.toDate();
    latestMessageTime = timeago.format(dateTime);
    notifyListeners();
  }
}
