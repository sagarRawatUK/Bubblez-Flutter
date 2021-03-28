import 'dart:io';
import 'package:bubblez/auth/authMethods/FirebaseOperations.dart';
import 'package:bubblez/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ImageSelect with ChangeNotifier {
  final picker = ImagePicker();
  File userAvatar;
  File get getUserAvatar => userAvatar;
  String userAvatarUrl;
  String get getUserAvatarUrl => userAvatarUrl;

  Future pickUserAvatar(BuildContext context, ImageSource source) async {
    final pickedUserAvatar = await picker.getImage(source: source);
    pickedUserAvatar == null
        ? print('Select image')
        : userAvatar = File(pickedUserAvatar.path);
    // print(userAvatar.path);
    if (userAvatar != null) {
      await Provider.of<FirebaseOperations>(context, listen: false)
          .uploadUserAvatar(context);
    } else
      print('Image not Selected ');
    notifyListeners();
  }

  Future selectAvatarOptionsSheet(BuildContext context) async {
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
                pickUserAvatar(context, ImageSource.camera).whenComplete(
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
                pickUserAvatar(context, ImageSource.gallery).whenComplete(
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
}
