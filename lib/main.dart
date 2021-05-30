import 'package:bubblez/auth/register/imageSelect.dart';
import 'package:bubblez/home/components/chat_tabs/chat_helpers.dart';
import 'package:bubblez/home/components/group/group_message_helper.dart';
import 'package:bubblez/style/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';

import 'auth/authMethods/Authentication.dart';
import 'auth/authMethods/FirebaseOperations.dart';
import 'auth/login/login.dart';
import 'home/components/postOperations/postFunctions.dart';
import 'home/components/postOperations/uploadPost.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Phoenix(child: Bubblez()));
}

class Bubblez extends StatelessWidget {
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Login(),
        theme: themeData,
      ),
    );
  }
}
