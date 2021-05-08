import 'dart:io';

import 'package:bubblez/home/upload.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadPost with ChangeNotifier {
  File uploadPostImage, uploadPostVideo;
  File get getUploadPostImage => uploadPostImage;
  File get getUploadPostVideo => uploadPostVideo;
  String uploadPostImageUrl, uploadVideoUrl;
  String get getUploadPostImageUrl => uploadPostImageUrl;
  String get getUploadVideoUrl => uploadVideoUrl;
  final picker = ImagePicker();
  UploadTask imagePostUploadTask, videoUploadTask;

  Future pickUploadPostImage(BuildContext context, ImageSource source) async {
    final uploadPostImageVal = await picker.getImage(source: source);
    uploadPostImageVal == null
        ? print('Select image')
        : uploadPostImage = File(uploadPostImageVal.path);
    print(uploadPostImageVal.path);

    uploadPostImage != null
        ? Navigator.push(
            context, MaterialPageRoute(builder: (context) => UploadScreen()))
        : print('Image upload error');

    notifyListeners();
  }

  Future uploadPostImageToFirebase() async {
    Reference imageReference = FirebaseStorage.instance
        .ref()
        .child('posts/${uploadPostImage.path}/${TimeOfDay.now()}');
    imagePostUploadTask = imageReference.putFile(uploadPostImage);
    await imagePostUploadTask.whenComplete(() {
      print('Post image uploaded to storage');
      imageReference.getDownloadURL().then((imageUrl) {
        uploadPostImageUrl = imageUrl;
        print(uploadPostImageUrl);
        notifyListeners();
      });
    });
  }

  Future uploadVideoToFirebase() async {
    Reference videoReference = FirebaseStorage.instance
        .ref()
        .child('videos/${uploadPostVideo.path}/${Timestamp.now()}');
    videoUploadTask = videoReference.putFile(uploadPostVideo);
    videoReference.getDownloadURL().then((url) {
      uploadVideoUrl = url.toString();
      print(getUploadVideoUrl);
    });
    notifyListeners();
  }
}
