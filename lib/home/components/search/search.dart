import 'package:bubblez/auth/authMethods/Authentication.dart';
import 'package:bubblez/home/components/search/search_helpers.dart';
import 'package:bubblez/home/userProfile/user_profile.dart';
import 'package:bubblez/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Search extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search",
                        hintStyle: theme.textTheme.bodyText2.copyWith(
                            color: theme.hintColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                        isDense: true,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Provider.of<SearchHelpers>(context, listen: false)
                          .initiateSearch(_searchController.text);
                    },
                    child: Icon(
                      Icons.search,
                      size: 25,
                      color: theme.hintColor,
                    ),
                  )
                ],
              ),
            ),
            Divider(
              color: grey,
            ),
            Provider.of<SearchHelpers>(context, listen: false).searchusers !=
                    null
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount:
                        Provider.of<SearchHelpers>(context, listen: false)
                            .searchusers
                            .docs
                            .length,
                    itemBuilder: (BuildContext context, int index) {
                      var snapshots =
                          Provider.of<SearchHelpers>(context, listen: false)
                              .searchusers;
                      return GestureDetector(
                        onTap: () {
                          if (snapshots.docs[index].get('useruid') !=
                              Provider.of<Authentication>(context,
                                      listen: false)
                                  .getUserUid)
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserProfileScreen(
                                        snapshots.docs[index].get('useruid'))));
                        },
                        child: Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Row(children: [
                              CircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage(
                                    snapshots.docs[index].get('userimage'),
                                  )),
                              SizedBox(width: 15),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshots.docs[index].get('username'),
                                    style: theme.textTheme.bodyText1
                                        .copyWith(color: Colors.grey[700]),
                                  ),
                                  Text(
                                    snapshots.docs[index].get('useremail'),
                                    style: theme.textTheme.bodyText1.copyWith(
                                        color: Colors.grey[400], fontSize: 12),
                                  ),
                                ],
                              ),
                              // Spacer(),
                              // Icon(
                              //   Icons.send,
                              //   size: 20,
                              //   color: primaryColor,
                              // ),
                            ])),
                      );
                    },
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
