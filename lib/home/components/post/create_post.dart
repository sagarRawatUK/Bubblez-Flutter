import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:bubblez/auth/authMethods/Authentication.dart';
import 'package:bubblez/auth/authMethods/FirebaseOperations.dart';
import 'package:bubblez/home/components/postOperations/uploadPost.dart';
import 'package:bubblez/home/home.dart';
import 'package:bubblez/style/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  TextEditingController _captionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final myAppbar = AppBar(
      backgroundColor: white,
      elevation: 0,
      title: Text("Create Post",
          style:
              theme.textTheme.headline6.copyWith(fontWeight: FontWeight.w500)),
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.chevron_left),
      ),
    );
    final bheight = mediaQuery.size.height -
        mediaQuery.padding.top -
        myAppbar.preferredSize.height;
    return Scaffold(
      appBar: myAppbar,
      body: FadedSlideAnimation(
        SingleChildScrollView(
          child: Container(
            height: bheight,
            color: white,
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          Provider.of<FirebaseOperations>(context,
                                  listen: false)
                              .getInitUserImage),
                    ),
                    SizedBox(width: 15),
                    SizedBox(
                      width: mediaQuery.size.width - 150,
                      child: TextField(
                        maxLength: 200,
                        controller: _captionController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Say Something about this photo',
                        ),
                        // style: theme.textTheme.bodyText1.copyWith(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadedScaleAnimation(Image.file(
                        Provider.of<UploadPost>(context, listen: false)
                            .uploadPostImage)),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Provider.of<FirebaseOperations>(context, listen: false)
                        .uploadPostData(_captionController.text, {
                      'postimage':
                          Provider.of<UploadPost>(context, listen: false)
                              .getUploadPostImageUrl,
                      'caption': _captionController.text,
                      'username': Provider.of<FirebaseOperations>(context,
                              listen: false)
                          .getInitUserName,
                      'userimage': Provider.of<FirebaseOperations>(context,
                              listen: false)
                          .getInitUserImage,
                      'useruid':
                          Provider.of<Authentication>(context, listen: false)
                              .getUserUid,
                      'useremail': Provider.of<FirebaseOperations>(context,
                              listen: false)
                          .getInitUserEmail,
                      'time': Timestamp.now()
                    }).whenComplete(() async {
                      return FirebaseFirestore.instance
                          .collection('users')
                          .doc(Provider.of<Authentication>(context,
                                  listen: false)
                              .getUserUid)
                          .collection('posts')
                          .add({
                        'postimage':
                            Provider.of<UploadPost>(context, listen: false)
                                .getUploadPostImageUrl,
                        'caption': _captionController.text,
                        'username': Provider.of<FirebaseOperations>(context,
                                listen: false)
                            .getInitUserName,
                        'userimage': Provider.of<FirebaseOperations>(context,
                                listen: false)
                            .getInitUserImage,
                        'useruid':
                            Provider.of<Authentication>(context, listen: false)
                                .getUserUid,
                        'useremail': Provider.of<FirebaseOperations>(context,
                                listen: false)
                            .getInitUserEmail,
                        'time': Timestamp.now()
                      });
                    }).whenComplete(() => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => HomeScreen())));
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Submit Post",
                      style: theme.textTheme.button,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
