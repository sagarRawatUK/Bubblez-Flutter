import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:bubblez/auth/authMethods/Authentication.dart';
import 'package:bubblez/auth/authMethods/FirebaseOperations.dart';
import 'package:bubblez/auth/register/imageSelect.dart';
import 'package:bubblez/home/home.dart';
import 'package:bubblez/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Register extends StatelessWidget {
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final myAppbar = AppBar(
      backgroundColor: lightGrey,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("New User", style: theme.textTheme.headline6),
        ],
      ),
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(
          Icons.chevron_left,
          color: theme.hintColor,
        ),
      ),
    );
    final bHeight = mediaQuery.size.height -
        mediaQuery.padding.top -
        myAppbar.preferredSize.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: myAppbar,
      body: FadedSlideAnimation(
        Container(
          color: lightGrey,
          height: bHeight,
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: ListView(
            children: [
              SizedBox(
                height: 10,
              ),
              Provider.of<ImageSelect>(context, listen: true).userAvatar != null
                  ? CircleAvatar(
                      radius: 80.0,
                      backgroundImage: FileImage(
                          Provider.of<ImageSelect>(context, listen: false)
                              .userAvatar))
                  : GestureDetector(
                      onTap: () {
                        Provider.of<ImageSelect>(context, listen: false)
                            .selectAvatarOptionsSheet(context);
                      },
                      child: CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.grey[300],
                        child: Icon(
                          Icons.person_add,
                          color: Colors.white,
                          size: 60,
                        ),
                      )),
              // Text('Register now to continue', textAlign: TextAlign.center),
              SizedBox(height: 30),
              TextField(
                controller: _fullNameController,
                decoration: InputDecoration(
                  hintText: "Full Name",
                  hintStyle: theme.textTheme.bodyText2
                      .copyWith(color: theme.hintColor, fontSize: 15),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "Email Address",
                  hintStyle: theme.textTheme.bodyText2
                      .copyWith(color: theme.hintColor, fontSize: 15),
                ),
              ),
              SizedBox(height: 20),

              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: theme.textTheme.bodyText2
                      .copyWith(color: theme.hintColor, fontSize: 15),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _phoneNumberController,
                decoration: InputDecoration(
                  hintText: "Phone Number",
                  hintStyle: theme.textTheme.bodyText2
                      .copyWith(color: theme.hintColor, fontSize: 15),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  if (_emailController.text.isNotEmpty &&
                      _fullNameController.text.isNotEmpty &&
                      _passwordController.text.isNotEmpty &&
                      _phoneNumberController.text.isNotEmpty) {
                    Provider.of<Authentication>(context, listen: false)
                        .createAccount(
                            _emailController.text, _passwordController.text)
                        .whenComplete(() {
                      print('Creating collection...');
                      Provider.of<FirebaseOperations>(context, listen: false)
                          .createUserCollection(context, {
                        'userpassword': _passwordController.text,
                        'useruid':
                            Provider.of<Authentication>(context, listen: false)
                                .getUserUid,
                        'useremail': _emailController.text,
                        'username': _fullNameController.text,
                        'usermobile': _phoneNumberController.text,
                        'userimage':
                            Provider.of<ImageSelect>(context, listen: false)
                                .getUserAvatarUrl,
                      });
                    }).whenComplete(() {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    });
                  } else {
                    warningText(context, 'Fill all the data!');
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    "Register Now",
                    style: theme.textTheme.button.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(30.0),
              //   child: Text(
              //     "We'll send verification code",
              //     textAlign: TextAlign.center,
              //     style: theme.textTheme.subtitle2
              //         .copyWith(fontSize: 12, color: theme.hintColor),
              //   ),
              // ),
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

warningText(BuildContext context, String warning) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        decoration: BoxDecoration(
          color: primaryColor,
        ),
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Text(warning,
              style: TextStyle(
                  color: white, fontSize: 16.0, fontWeight: FontWeight.bold)),
        ),
      );
    },
  );
}
