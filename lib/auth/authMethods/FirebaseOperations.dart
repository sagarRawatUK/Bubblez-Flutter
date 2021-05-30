import 'package:bubblez/auth/register/imageSelect.dart';
import 'package:bubblez/home/components/chat_tabs/chat_helpers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Authentication.dart';

class FirebaseOperations with ChangeNotifier {
  UploadTask imageUploadTask;
  String initUserEmail,
      initUserName,
      initUserImage,
      initUserPhone,
      initUserFullName;
  String get getInitUserName => initUserName;
  String get getInitUserEmail => initUserEmail;
  String get getInitUserImage => initUserImage;
  String get getInitUserPhone => initUserPhone;
  String get getInitUserFullName => initUserFullName;

  Future uploadUserAvatar(BuildContext context) async {
    Reference imageReference = FirebaseStorage.instance
        .ref()
        .child('userProfileAvatar/${DateTime.now()}');
    var imageSelect = Provider.of<ImageSelect>(context, listen: false);
    imageUploadTask = imageReference.putFile(imageSelect.getUserAvatar);
    await imageUploadTask.whenComplete(() {
      print('Image uploaded!');
      imageReference.getDownloadURL().then((url) {
        print("#####################" + url);
        imageSelect.userAvatarUrl = url.toString();
        // print(
        //     'the user profile avatar url => ${Provider.of<ImageSelect>(context, listen: false).getUserAvatarUrl}');
      });
    });

    notifyListeners();
  }

  Future createUserCollection(BuildContext context, dynamic data) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(Provider.of<Authentication>(context, listen: false).getUserUid)
        .set(data);
  }

  Future initUserData(BuildContext context) async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(Provider.of<Authentication>(context, listen: false).getUserUid)
        .get()
        .then((doc) {
      print('Fetching user data');

      initUserName = doc.data()['username'];
      initUserEmail = doc.data()['useremail'];
      initUserImage = doc.data()['userimage'];
      initUserPhone = doc.data()['usermobile'];
      initUserFullName = doc.data()['username'];

      print(initUserName);
      print(initUserEmail);
      print(initUserImage);
      print(initUserPhone);
      print(initUserFullName);

      notifyListeners();
    });
  }

  Future uploadPostData(String postId, dynamic data) async {
    return FirebaseFirestore.instance.collection('posts').doc(postId).set(data);
  }

  Future deleteUserData(String userUid, dynamic collection) async {
    return FirebaseFirestore.instance
        .collection(collection)
        .doc(userUid)
        .delete();
  }

  Future addAward(String postId, dynamic data) async {
    return FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('awards')
        .add(data);
  }

  Future updateCaption(String postId, dynamic data) async {
    return FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .update(data);
  }

  Future followUser(
      String followingUid,
      String followingDocId,
      dynamic followingData,
      String followerUid,
      String followerDocId,
      dynamic followerData) async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(followingUid)
        .collection('followers')
        .doc(followingDocId)
        .set(followingData)
        .whenComplete(() async {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(followerUid)
          .collection('following')
          .doc(followerDocId)
          .set(followerData);
    });
  }

  Future submitChatroomData(String chatRoomName, dynamic chatRoomData) async {
    return FirebaseFirestore.instance
        .collection('chatrooms')
        .doc(chatRoomName)
        .set(chatRoomData);
  }

  Future uploadChatroomAvatar(BuildContext context) async {
    Reference imageReference = FirebaseStorage.instance
        .ref()
        .child('chatroomAvatar/${DateTime.now()}');
    var imageSelect = Provider.of<ChatroomHelpers>(context, listen: false);
    imageUploadTask = imageReference.putFile(imageSelect.chatroomAvatarFile);
    await imageUploadTask.whenComplete(() {
      print('Image uploaded!');
      imageReference.getDownloadURL().then((url) {
        print("#####################" + url);
        imageSelect.chatroomAvatarUrl = url.toString();
        // print(
        //     'the user profile avatar url => ${Provider.of<ImageSelect>(context, listen: false).getUserAvatarUrl}');
      });
    });

    notifyListeners();
  }
}
