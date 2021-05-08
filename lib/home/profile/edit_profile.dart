import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:bubblez/auth/authMethods/FirebaseOperations.dart';
import 'package:bubblez/auth/login/login.dart';
import 'package:bubblez/auth/register/imageSelect.dart';
import 'package:bubblez/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController _nametextController = TextEditingController();
  TextEditingController _usernametextController = TextEditingController();
  TextEditingController _phonetextController = TextEditingController();
  TextEditingController _emailtextController = TextEditingController();
  @override
  void initState() {
    _nametextController.text =
        Provider.of<FirebaseOperations>(context, listen: false).getInitUserName;
    _emailtextController.text =
        Provider.of<FirebaseOperations>(context, listen: false)
            .getInitUserEmail;
    _phonetextController.text =
        Provider.of<FirebaseOperations>(context, listen: false).initUserPhone;
    _usernametextController.text =
        Provider.of<FirebaseOperations>(context, listen: false)
            .initUserFullName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(Provider.of<FirebaseOperations>(context, listen: false)
        .getInitUserImage);
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final myAppBar = AppBar(
      title: Text(
        "My Profile",
        style: theme.textTheme.headline6,
      ),
      backgroundColor: white,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.chevron_left),
      ),
      elevation: 0,
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => Login(),
            ));
          },
          child: Text(
            "Logout",
            style: theme.textTheme.button.copyWith(
                color: theme.primaryColor, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
    final bheight = mediaQuery.size.height -
        mediaQuery.padding.top -
        myAppBar.preferredSize.height;
    return Scaffold(
      appBar: myAppBar,
      body: FadedSlideAnimation(
        Container(
          color: white,
          height: bheight,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      Provider.of<ImageSelect>(context, listen: false)
                          .selectAvatarOptionsSheet(context);
                    },
                    child: Stack(
                      children: [
                        FadedScaleAnimation(CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(
                                Provider.of<FirebaseOperations>(context,
                                        listen: false)
                                    .getInitUserImage))),
                        Positioned(
                          right: 0,
                          top: 7,
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: theme.primaryColor,
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                      alignment: Alignment.centerLeft,
                      color: lightGrey,
                      width: double.infinity,
                      child: Text(
                        "Profile Info",
                        style: theme.textTheme.headline6.copyWith(
                          color: Colors.grey,
                          fontSize: fontSize16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: TextField(
                        controller: _nametextController,
                        decoration: InputDecoration(
                          labelText: "Full Name",
                          alignLabelWithHint: false,
                          border: InputBorder.none,
                          labelStyle: TextStyle(height: 1),
                        ),
                      ),
                    ),
                    Divider(
                      color: lightGrey,
                      thickness: 3,
                    ),
                    Container(
                      color: Colors.white,
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: TextField(
                        controller: _usernametextController,
                        decoration: InputDecoration(
                          labelText: "Username",
                          labelStyle: TextStyle(height: 1),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Divider(
                      color: lightGrey,
                      thickness: 3,
                    ),
                    Container(
                      color: Colors.white,
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: TextField(
                        controller: _phonetextController,
                        decoration: InputDecoration(
                          labelText: "Phone Number",
                          labelStyle: TextStyle(height: 1),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Divider(
                      color: lightGrey,
                      thickness: 3,
                    ),
                    Container(
                      color: Colors.white,
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: TextField(
                        controller: _emailtextController,
                        decoration: InputDecoration(
                          labelText: "EmailAddress",
                          labelStyle: TextStyle(height: 1),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Divider(
                      color: lightGrey,
                      thickness: 3,
                    ),
                  ],
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
