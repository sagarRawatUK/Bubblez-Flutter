import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StoryAddScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: FadedSlideAnimation(
        Container(
          width: mediaQuery.size.width,
          height: mediaQuery.size.height,
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: [
              Image.asset('assets/images/Layer1045.png', fit: BoxFit.fitHeight),
              Positioned(
                top: 30,
                left: 10,
                child: Icon(Icons.close),
              ),
              Positioned(
                bottom: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RotatedBox(
                      quarterTurns: 1,
                      child: Icon(
                        Icons.chevron_left,
                        size: 20,
                      ),
                    ),
                    Text(
                      "Swipe Up for Gallery",
                      style: theme.textTheme.bodyText1
                          .copyWith(color: Colors.white, fontSize: 15),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 60,
                child: Row(
                  children: [
                    Icon(
                      Icons.mic,
                      color: Colors.white,
                      size: theme.primaryIconTheme.size,
                    ),
                    SizedBox(width: 40),
                    RawMaterialButton(
                      onPressed: () {
                        print('pic clicked.......');
                      },
                      fillColor: theme.primaryColor,
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(15),
                      child: FaIcon(
                        FontAwesomeIcons.video,
                        size: 25,
                      ),
                    ),
                    SizedBox(width: 40),
                    Icon(
                      Icons.flash_off,
                      color: Colors.white,
                      size: theme.primaryIconTheme.size,
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    stops: [0, 0.25, 0.75, 1],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black26,
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black26
                    ],
                  ),
                ),
              )
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
