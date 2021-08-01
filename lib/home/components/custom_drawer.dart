import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:bubblez/auth/authMethods/Authentication.dart';
import 'package:bubblez/auth/authMethods/FirebaseOperations.dart';
import 'package:bubblez/home/profile/my_profile_screen.dart';
import 'package:bubblez/home/profile/edit_profile.dart';
import 'package:bubblez/style/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatelessWidget {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      color: scaffoldBackgroundColor,
      height: mediaQuery.size.height,
      child: Drawer(
        child: FadedSlideAnimation(
          StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(Provider.of<Authentication>(context, listen: false)
                    .getUserUid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 40, left: 20, right: 10),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.centerRight,
                              width: double.infinity,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Icon(Icons.close,
                                    color: theme.primaryColor),
                              ),
                            ),
                            SizedBox(height: 20),
                            FadedScaleAnimation(
                              Container(
                                child: Provider.of<FirebaseOperations>(context)
                                            .getInitUserImage ==
                                        null
                                    ? CircleAvatar(
                                        radius: 35,
                                        backgroundImage: AssetImage(
                                            "assets/plc_profile.png"),
                                      )
                                    : CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            Provider.of<FirebaseOperations>(
                                                    context,
                                                    listen: false)
                                                .getInitUserImage),
                                        radius: 35,
                                      ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              child: Text(
                                snapshot.data.data()['username'],
                                style: theme.textTheme.subtitle2.copyWith(
                                  color: theme.hintColor,
                                ),
                              ),
                            ),
                            // Container(
                            //   child: Text(
                            //     Provider.of<FirebaseOperations>(context)
                            //         .getInitUserName,
                            //     style: theme.textTheme.subtitle2.copyWith(
                            //       color: theme.hintColor,
                            //     ),
                            //   ),
                            // ),
                            SizedBox(height: 50),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => MyProfileScreen()));
                              },
                              child: Container(
                                width: double.infinity,
                                child: Text(
                                  "View Profile",
                                  style: theme.textTheme.headline6.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ProfileScreen()));
                              },
                              child: Container(
                                width: double.infinity,
                                child: Text(
                                  "Edit Profile",
                                  style: theme.textTheme.headline6.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            GestureDetector(
                              onTap: () async {
                                SharedPreferences sharedPreferences =
                                    await SharedPreferences.getInstance();
                                sharedPreferences.clear();
                                firebaseAuth.signOut();
                                Phoenix.rebirth(context);
                              },
                              child: Container(
                                width: double.infinity,
                                child: Text(
                                  "Logout",
                                  style: theme.textTheme.headline6.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
          beginOffset: Offset(0, 0.3),
          endOffset: Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
        ),
      ),
    );
  }
}
