import 'dart:io';

import 'package:bubblez/auth/authMethods/Authentication.dart';
import 'package:bubblez/auth/authMethods/FirebaseOperations.dart';
import 'package:bubblez/home/components/story_screen_tab_content/upload_story.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class StoryHelpers with ChangeNotifier {
  UploadTask imageUploadTask;
  final picker = ImagePicker();
  File storyImage;
  File get getStoryImage => storyImage;
  String storyImageUrl, storyHighlightIcon, storyTime, lastSeenTime;
  String get getStoryImageUrl => storyImageUrl;
  String get getStoryHighlightIcon => storyHighlightIcon;
  String get getStoryTime => storyTime;
  String get getLastSeenTime => lastSeenTime;

  Future selectStoryImage(BuildContext context, ImageSource source) async {
    final pickedStoryImage = await picker.getImage(source: source);
    pickedStoryImage == null
        ? print('Error')
        : storyImage = File(pickedStoryImage.path);
    storyImage != null
        ? Navigator.push(
            context, MaterialPageRoute(builder: (context) => UploadStoryTab()))
        : print('Error');
    notifyListeners();
  }

  Future uploadStoryImage(BuildContext context) async {
    Reference imageReference = FirebaseStorage.instance
        .ref()
        .child('stories/${getStoryImage.path}/${Timestamp.now()}');
    imageUploadTask = imageReference.putFile(getStoryImage);
    await imageUploadTask.whenComplete(() {
      print('Story image uploaded');
    });
    imageReference.getDownloadURL().then((url) {
      storyImageUrl = url;
      print(storyImageUrl);
    });
    notifyListeners();
  }

  Future convertHighlightedIcon(String firestoreImageUrl) async {
    storyHighlightIcon = firestoreImageUrl;
    print(storyHighlightIcon);
    notifyListeners();
  }

  Future addStoryToNewAlbum(BuildContext context, String userUid,
      String highlightName, String storyImage) async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userUid)
        .collection('highlights')
        .doc(highlightName)
        .set({
      'title': highlightName,
      'cover': storyHighlightIcon
    }).whenComplete(() {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(userUid)
          .collection('highlights')
          .doc(highlightName)
          .collection('stories')
          .add({
        'image': storyImage,
        'username': Provider.of<FirebaseOperations>(context, listen: false)
            .getInitUserName,
        'userimage': Provider.of<FirebaseOperations>(context, listen: false)
            .getInitUserImage
      });
    });
  }

  Future addStoryToExistingAlbum(BuildContext context, String userUid,
      String highlightColId, String storyImage) async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userUid)
        .collection('highlights')
        .doc(highlightColId)
        .collection('stories')
        .add({
      'image': storyImage,
      'username': Provider.of<FirebaseOperations>(context, listen: false)
          .getInitUserName,
      'userimage': Provider.of<FirebaseOperations>(context, listen: false)
          .getInitUserImage
    });
  }

  storyTimePosted(dynamic timeData) {
    Timestamp timestamp = timeData;
    DateTime dateTime = timestamp.toDate();
    storyTime = timeago.format(dateTime);
    lastSeenTime = timeago.format(dateTime);
    notifyListeners();
  }

  Future addSeenStamp(BuildContext context, String storyId, String personId,
      DocumentSnapshot documentSnapshot) async {
    if (documentSnapshot.data()['useruid'] !=
        Provider.of<Authentication>(context, listen: false).getUserUid) {
      return FirebaseFirestore.instance
          .collection('stories')
          .doc(storyId)
          .collection('seen')
          .doc(personId)
          .set({
        'time': Timestamp.now(),
        'username': Provider.of<FirebaseOperations>(context, listen: false)
            .getInitUserName,
        'userimage': Provider.of<FirebaseOperations>(context, listen: false)
            .getInitUserImage,
        'useruid':
            Provider.of<Authentication>(context, listen: false).getUserUid
      });
    }
  }
}
