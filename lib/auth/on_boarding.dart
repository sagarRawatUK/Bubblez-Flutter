import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:bubblez/auth/login/login.dart';
import 'package:bubblez/style/colors.dart';
import 'package:flutter/material.dart';

class OnBoarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/bg.jpg",
                  ),
                  fit: BoxFit.cover),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            // decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //   begin: Alignment.center,
            //   end: Alignment.bottomCenter,
            //   stops: [0.35, 0.65],
            //   colors: [
            //     Colors.white.withOpacity(0.1),
            //     Colors.white,
            //   ],
            // )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                Text(
                  "Get Started!",
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 30,
                ),
                FadedScaleAnimation(
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Container(
                      padding: EdgeInsetsDirectional.only(start: 10),
                      height: 55,
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Icon(
                              Icons.phone_android,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          Spacer(),
                          Text("Sign in",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500)),
                          Spacer(flex: 2),
                        ],
                      ),
                    ),
                  ),
                  durationInMilliseconds: 600,
                ),
                SizedBox(
                  height: 10,
                ),
                FadedScaleAnimation(
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsetsDirectional.only(start: 10),
                      height: 55,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).highlightColor,
                              width: 1),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 17),
                            child: Image.asset(
                              "assets/ic_google.png",
                              scale: 3,
                            ),
                          ),
                          Spacer(),
                          Text("Sign in with Google",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500)),
                          Spacer(flex: 2),
                        ],
                      ),
                    ),
                  ),
                  durationInMilliseconds: 600,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
