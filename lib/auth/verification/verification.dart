import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:bubblez/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VerificationScreen extends StatefulWidget {
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final myAppbar = AppBar(
      backgroundColor: white,
      toolbarHeight: 70,
      title: Text("Verification", style: theme.textTheme.headline6),
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.chevron_left),
      ),
    );
    final bHeight = mediaQuery.size.height -
        mediaQuery.padding.top -
        myAppbar.preferredSize.height;
    return Scaffold(
      appBar: myAppbar,
      backgroundColor: Colors.white,
      body: FadedSlideAnimation(
        Container(
          height: bHeight,
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Add verification code sent on your number.'.padLeft(24),
                style: theme.textTheme.headline6
                    .copyWith(color: textGrey, fontSize: 11),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 70),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 50,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: '5',
                        hintStyle: TextStyle(color: textGrey),
                      ),
                      cursorWidth: 0,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                      ],
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    width: 50,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: '5',
                        hintStyle: TextStyle(color: textGrey),
                      ),
                      cursorWidth: 0,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                      ],
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    width: 50,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: '5',
                        hintStyle: TextStyle(color: textGrey),
                      ),
                      cursorWidth: 0,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                      ],
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    width: 50,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: '5',
                        hintStyle: TextStyle(color: textGrey),
                      ),
                      cursorWidth: 0,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                      ],
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 60),
              GestureDetector(
                // onTap: () {
                //   Navigator.of(context).push(_createPageRoute(HomeScreen()));
                // },
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    "Verify Now",
                    style: theme.textTheme.button.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      "min left",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  GestureDetector(
                    child: Text(
                      "resend",
                      style: theme.textTheme.button
                          .copyWith(color: theme.primaryColor),
                    ),
                  ),
                ],
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

  // Route _createPageRoute(page) {
  //   return PageRouteBuilder(
  //     pageBuilder: (context, animation, secondaryAnimation) => page,
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //       var begin = Offset(0.0, 1.0);
  //       var end = Offset(0.0, 0.0);
  //       var curve = Curves.bounceIn;

  //       var tween =
  //           Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

  //       return SlideTransition(
  //         position: animation.drive(tween),
  //         child: child,
  //       );
  //     },
  //   );
  // }
}
