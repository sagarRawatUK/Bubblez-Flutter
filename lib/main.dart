import 'package:bubblez/auth/authMethods/SetData.dart';
import 'package:bubblez/auth/on_boarding.dart';
import 'package:bubblez/auth/register/imageSelect.dart';
import 'package:bubblez/home/chatroom/chat_helpers.dart';
import 'package:bubblez/home/components/chat_tabs/chat_helpers.dart';
import 'package:bubblez/home/components/group/group_message_helper.dart';
import 'package:bubblez/home/components/story_screen_tab_content/story_helper.dart';
import 'package:bubblez/home/home.dart';
import 'package:bubblez/style/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'auth/authMethods/Authentication.dart';
import 'auth/authMethods/FirebaseOperations.dart';
import 'auth/authMethods/SharedPrefs.dart';
import 'home/components/postOperations/postFunctions.dart';
import 'home/components/postOperations/uploadPost.dart';
import 'home/components/search/search_helpers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Phoenix(child: Bubblez()));
}

class Bubblez extends StatefulWidget {
  @override
  _BubblezState createState() => _BubblezState();
}

class _BubblezState extends State<Bubblez> {
  bool isUserLoggedIn;

  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await SharedPrefs.getUserLoggedInSharedPreference().then((value) {
      setState(() {
        isUserLoggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Authentication()),
        ChangeNotifierProvider(create: (_) => FirebaseOperations()),
        ChangeNotifierProvider(create: (_) => ImageSelect()),
        ChangeNotifierProvider(create: (_) => UploadPost()),
        ChangeNotifierProvider(create: (_) => PostFunctions()),
        ChangeNotifierProvider(create: (_) => ChatroomHelpers()),
        ChangeNotifierProvider(create: (_) => GroupMessageHelpers()),
        ChangeNotifierProvider(create: (_) => StoryHelpers()),
        ChangeNotifierProvider(create: (_) => SearchHelpers()),
        ChangeNotifierProvider(create: (_) => SingleChatHelpers()),
        ChangeNotifierProvider(create: (_) => SetData()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: isUserLoggedIn != null
            ? isUserLoggedIn
                ? HomeScreen(true)
                : OnBoarding()
            : OnBoarding(),
        theme: themeData,
      ),
    );
  }
}
