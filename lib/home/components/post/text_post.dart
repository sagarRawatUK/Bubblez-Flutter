import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:bubblez/auth/authMethods/FirebaseOperations.dart';
import 'package:bubblez/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class TextPostScreen extends StatefulWidget {
  @override
  _TextPostScreenState createState() => _TextPostScreenState();
}

class _TextPostScreenState extends State<TextPostScreen> {
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
        icon: Icon(Icons.chevron_left),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
    final bheight = mediaQuery.size.height -
        mediaQuery.padding.top -
        myAppbar.preferredSize.height;
    return Scaffold(
      appBar: myAppbar,
      body: FadedSlideAnimation(
        Container(
          height: bheight,
          color: white,
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  FadedScaleAnimation(
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          Provider.of<FirebaseOperations>(context,
                                  listen: false)
                              .getInitUserImage),
                    ),
                  ),
                  SizedBox(width: 15),
                  SizedBox(
                    width: mediaQuery.size.width - 150,
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Write Something to post",
                      ),
                      // style: theme.textTheme.bodyText1.copyWith(color: Colors.grey),
                    ),
                  ),
                ],
              ),
              Spacer(),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: lightGrey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.fromLTRB(5, 0, 10, 5),
                    child: Icon(
                      Icons.camera_alt,
                      color: theme.primaryColor,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: lightGrey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.fromLTRB(5, 0, 10, 5),
                    child: FaIcon(
                      FontAwesomeIcons.video,
                      color: theme.primaryColor,
                      size: iconSize20,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: lightGrey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.fromLTRB(5, 0, 10, 5),
                    child: Icon(
                      Icons.photo,
                      color: theme.primaryColor,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: Container(
                  margin: EdgeInsets.only(top: 15),
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
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
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
