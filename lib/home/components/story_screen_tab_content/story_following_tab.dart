import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:bubblez/auth/authMethods/Authentication.dart';
import 'package:bubblez/home/components/story_screen_tab_content/story_full_view.dart';
import 'package:bubblez/home/profile/my_profile_screen.dart';
import 'package:bubblez/home/userProfile/user_profile.dart';
import 'package:bubblez/style/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StoryFollowingTabScreen extends StatelessWidget {
  final _bHeight;

  StoryFollowingTabScreen(this._bHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: FadedSlideAnimation(
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('stories').snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  childAspectRatio: 1 / 1.77,
                ),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => StoryFollowingFullView(
                              snapshot.data.docs[index])));
                    },
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: Image.network(
                              snapshot.data.docs[index]['image'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 10,
                          child: GestureDetector(
                            onTap: () {
                              if (Provider.of<Authentication>(context,
                                          listen: false)
                                      .getUserUid !=
                                  snapshot.data.docs[index]['useruid'])
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => UserProfileScreen(
                                        snapshot.data.docs[index]['useruid'])));
                            },
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                snapshot.data.docs[index]['userimage'],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          right: 10,
                          child: Row(
                            children: [
                              Icon(
                                Icons.remove_red_eye,
                                size: iconSize18,
                              ),
                              SizedBox(width: 6),
                              Text(
                                "1.2k",
                                style: TextStyle(
                                    color: white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    letterSpacing: 1),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
          },
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
