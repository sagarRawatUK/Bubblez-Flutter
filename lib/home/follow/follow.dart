import 'package:bubblez/auth/authMethods/Authentication.dart';
import 'package:bubblez/style/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Follow extends StatelessWidget {
  String userUid;
  bool isFollowers;
  Follow(this.userUid, [this.isFollowers = false]);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        title: Text(
          isFollowers ? "Followers" : "Following",
          style: Theme.of(context).textTheme.headline6.copyWith(
                fontSize: 16.7,
                fontWeight: FontWeight.w500,
              ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(Icons.chevron_left),
        ),
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(userUid)
              .collection(isFollowers ? "followers" : "following")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView(
                children:
                    snapshot.data.docs.map((DocumentSnapshot documentSnapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return ListTile(
                      horizontalTitleGap: 0,
                      leading: Row(
                        children: [
                          CircleAvatar(
                              backgroundImage: NetworkImage(
                                  documentSnapshot.data()['userimage'])),
                          Spacer(),
                          Container(
                            width: 80,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                    style: BorderStyle.solid,
                                    width: 1),
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).primaryColor),
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: userUid ==
                                    Provider.of<Authentication>(context,
                                            listen: false)
                                        .getUserUid
                                ? SizedBox.shrink()
                                : Text(
                                    'Unfollow',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        .copyWith(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          fontSize: 12,
                                        ),
                                  ),
                          ),
                        ],
                      ),
                      title: Text(
                        documentSnapshot.data()['username'],
                      ),
                    );
                  }
                }).toList(),
              );
            }
          },
        ),
      ),
    );
  }
}
