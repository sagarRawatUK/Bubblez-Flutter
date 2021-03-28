import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:bubblez/auth/authMethods/Authentication.dart';
import 'package:bubblez/auth/register/register.dart';
import 'package:bubblez/components/custom_button.dart';
import 'package:bubblez/home/home.dart';
import 'package:bubblez/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final bHeight = mediaQuery.size.height - mediaQuery.padding.top;
    return Scaffold(
      body: FadedSlideAnimation(
        SafeArea(
          child: Container(
            height: bHeight,
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: SingleChildScrollView(
              child: Column(
                // main axis won't work with singlechildscrollview
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: 15),
                  Container(
                      height: bHeight * 0.2,
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          "Bubblez",
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                  SizedBox(height: 45),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: theme.textTheme.bodyText2
                          .copyWith(color: theme.hintColor, fontSize: 15),
                      isDense: true,
                    ),
                  ),
                  SizedBox(height: 30),
                  Stack(
                    children: [
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: theme.textTheme.bodyText2
                              .copyWith(color: theme.hintColor, fontSize: 15),
                          isDense: true,
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: GestureDetector(
                          // onTap: () {
                          //   Navigator.of(context)
                          //       .push(_createPageRoute(ForgotPasswordScreen()));
                          // },
                          child: Text(
                            "Forgot?",
                            style: theme.textTheme.button.copyWith(
                              color: theme.primaryColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      if (_emailController.text.isNotEmpty) {
                        Provider.of<Authentication>(context, listen: false)
                            .logIntoAccount(
                                _emailController.text, _passwordController.text)
                            .whenComplete(() {
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
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: theme.primaryColor,
                      ),
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.only(top: 16, bottom: 16),
                      child: Text(
                        "SignIn",
                        style: theme.textTheme.button.copyWith(fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(height: 45),
                  Padding(
                    padding: const EdgeInsets.only(top: 14, bottom: 14),
                    child: Text("Or continue with",
                        style:
                            theme.textTheme.headline6.copyWith(fontSize: 14)),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          icon: Image.asset('assets/ic_fb.png', scale: 3),
                          radius: 10,
                          color: Colors.blue,
                          onTap: () {
                            // Navigator.of(context)
                            //     .push(_createPageRoute(SignupScreen()));
                          },
                          label: 'Facebook',
                          textColor: Colors.white,
                        ),
                      ),
                      SizedBox(width: 20.0),
                      Expanded(
                        child: CustomButton(
                          label: 'Google',
                          radius: 10,
                          onTap: () {
                            // Navigator.of(context)
                            //     .push(_createPageRoute(SignupScreen()));
                          },
                          icon: Image.asset('assets/ic_google.png', scale: 3),
                          color: Colors.green,
                          textColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Register()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: theme.primaryColor,
                          style: BorderStyle.solid,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                        "New User?",
                        style: theme.textTheme.button.copyWith(
                          color: theme.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
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

warningText(BuildContext context, String warning) {
  return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: primaryColor,
          ),
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Text(warning,
                style: TextStyle(
                    color: white, fontSize: 16.0, fontWeight: FontWeight.bold)),
          ),
        );
      });
}
