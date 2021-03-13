import 'package:bubblez/screens/auth/landingUtils.dart';
import 'package:bubblez/screens/home/Homepage.dart';
import 'package:bubblez/services/Authentication.dart';
import 'package:bubblez/services/FirebaseOperations.dart';
import 'package:bubblez/style/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class LandingService with ChangeNotifier {
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();

  showUserAvatar(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.30,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150.0),
                  child: Divider(
                    thickness: 4.0,
                    color: whiteColor,
                  ),
                ),
                CircleAvatar(
                    radius: 80.0,
                    backgroundColor: transperant,
                    backgroundImage: FileImage(
                        Provider.of<LandingUtils>(context, listen: false)
                            .userAvatar)),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                          child: Text('Reselect',
                              style: TextStyle(
                                  color: whiteColor,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  decorationColor: whiteColor)),
                          onPressed: () {
                            Provider.of<LandingUtils>(context, listen: false)
                                .pickUserAvatar(context, ImageSource.gallery);
                          }),
                      MaterialButton(
                          color: blueColor,
                          child: Text('Confirm Image',
                              style: TextStyle(
                                color: whiteColor,
                                fontWeight: FontWeight.bold,
                              )),
                          onPressed: () {
                            Provider.of<FirebaseOperations>(context,
                                    listen: false)
                                .uploadUserAvatar(context)
                                .whenComplete(() {
                              signInSheet(context);
                            });
                          })
                    ],
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
              color: blueGreyColor,
              borderRadius: BorderRadius.circular(15.0),
            ),
          );
        });
  }

  Widget passswordLessSignIn(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.40,
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return new ListView(
                children:
                    snapshot.data.docs.map((DocumentSnapshot documentSnapshot) {
              return ListTile(
                trailing: Container(
                  width: 120.0,
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(FontAwesomeIcons.check, color: blueColor),
                        onPressed: () {
                          Provider.of<Authentication>(context, listen: false)
                              .logIntoAccount(
                                  documentSnapshot.data()['useremail'],
                                  documentSnapshot.data()['userpassword'])
                              .whenComplete(() {
                            Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    child: Homepage(),
                                    type: PageTransitionType.leftToRight));
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(FontAwesomeIcons.trashAlt, color: redColor),
                        onPressed: () {
                          Provider.of<FirebaseOperations>(context,
                                  listen: false)
                              .deleteUserData(
                                  documentSnapshot.data()['useruid'], 'users');
                        },
                      ),
                    ],
                  ),
                ),
                leading: CircleAvatar(
                  backgroundColor: darkColor,
                  backgroundImage:
                      NetworkImage(documentSnapshot.data()['userimage']),
                ),
                subtitle: Text(documentSnapshot.data()['useremail'],
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: whiteColor,
                        fontSize: 12.0)),
                title: Text(documentSnapshot.data()['username'],
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: greenColor)),
              );
            }).toList());
          }
        },
      ),
    );
  }

  logInSheet(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.30,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 150.0),
                    child: Divider(
                      thickness: 4.0,
                      color: whiteColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextField(
                      controller: userEmailController,
                      decoration: InputDecoration(
                        hintText: 'Enter Email...',
                        hintStyle: TextStyle(
                            color: whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      ),
                      style: TextStyle(
                          color: whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextField(
                      controller: userPasswordController,
                      decoration: InputDecoration(
                        hintText: 'Enter Password...',
                        hintStyle: TextStyle(
                            color: whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      ),
                      style: TextStyle(
                          color: whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ),
                  FloatingActionButton(
                      backgroundColor: blueColor,
                      child: Icon(FontAwesomeIcons.check, color: whiteColor),
                      onPressed: () {
                        if (userEmailController.text.isNotEmpty) {
                          Provider.of<Authentication>(context, listen: false)
                              .logIntoAccount(userEmailController.text,
                                  userPasswordController.text)
                              .whenComplete(() {
                            Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    child: Homepage(),
                                    type: PageTransitionType.bottomToTop));
                          });
                        } else {
                          warningText(context, 'Fill all the data!');
                        }
                      })
                ],
              ),
              decoration: BoxDecoration(
                  color: blueGreyColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0))),
            ),
          );
        });
  }

  signInSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: blueGreyColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0))),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150.0),
                  child: Divider(
                    thickness: 4.0,
                    color: whiteColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Provider.of<LandingUtils>(context, listen: false)
                        .selectAvatarOptionsSheet(context);
                  },
                  child: CircleAvatar(
                    backgroundImage: Provider.of<LandingUtils>(context,
                                    listen: false)
                                .getUserAvatar ==
                            null
                        ? AssetImage(
                            "assets/icons/subject.png",
                          )
                        : FileImage(
                            Provider.of<LandingUtils>(context, listen: false)
                                .getUserAvatar),
                    backgroundColor: greyColor,
                    radius: 50.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextField(
                    controller: userNameController,
                    decoration: InputDecoration(
                      hintText: 'Enter name...',
                      hintStyle: TextStyle(
                          color: whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                    style: TextStyle(
                        color: whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextField(
                    controller: userEmailController,
                    decoration: InputDecoration(
                      hintText: 'Enter Email...',
                      hintStyle: TextStyle(
                          color: whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                    style: TextStyle(
                        color: whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextField(
                    controller: userPasswordController,
                    decoration: InputDecoration(
                      hintText: 'Enter Password...',
                      hintStyle: TextStyle(
                          color: whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                    style: TextStyle(
                        color: whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: FloatingActionButton(
                      backgroundColor: redColor,
                      child: Icon(FontAwesomeIcons.check, color: whiteColor),
                      onPressed: () {
                        if (userEmailController.text.isNotEmpty) {
                          Provider.of<Authentication>(context, listen: false)
                              .createAccount(userEmailController.text,
                                  userPasswordController.text)
                              .whenComplete(() {
                            print('Creating collection...');
                            Provider.of<FirebaseOperations>(context,
                                    listen: false)
                                .createUserCollection(context, {
                              'userpassword': userPasswordController.text,
                              'useruid': Provider.of<Authentication>(context,
                                      listen: false)
                                  .getUserUid,
                              'useremail': userEmailController.text,
                              'username': userNameController.text,
                              'userimage': Provider.of<LandingUtils>(context,
                                      listen: false)
                                  .getUserAvatarUrl,
                            });
                          }).whenComplete(() {
                            Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    child: Homepage(),
                                    type: PageTransitionType.bottomToTop));
                          });
                        } else {
                          warningText(context, 'Fill all the data!');
                        }
                      }),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  warningText(BuildContext context, String warning) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
                color: darkColor, borderRadius: BorderRadius.circular(15.0)),
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text(warning,
                  style: TextStyle(
                      color: whiteColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold)),
            ),
          );
        });
  }
}
