import 'package:bubblez/screens/auth/landingPage.dart';
import 'package:bubblez/screens/auth/landingServices.dart';
import 'package:bubblez/screens/auth/landingUtils.dart';
import 'package:bubblez/screens/home/HomepageHelpers.dart';
import 'package:bubblez/services/Authentication.dart';
import 'package:bubblez/services/FirebaseOperations.dart';
import 'package:bubblez/style/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/auth/landingHelpers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: UiThemeData(),
          home: Landingpage(),
        ),
        providers: [
          // ChangeNotifierProvider(create: (_) => ProfileHelpers()),
          ChangeNotifierProvider(create: (_) => HomepageHelpers()),
          ChangeNotifierProvider(create: (_) => LandingUtils()),
          ChangeNotifierProvider(create: (_) => FirebaseOperations()),
          ChangeNotifierProvider(create: (_) => LandingService()),
          ChangeNotifierProvider(create: (_) => Authentication()),
          ChangeNotifierProvider(create: (_) => LandingHelpers())
        ]);
  }
}
