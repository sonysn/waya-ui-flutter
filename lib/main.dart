import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:waya/screens/splash_screen.dart';
import 'package:waya/screens/welcomepage.dart';
import 'package:flutter/services.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Get the device's FCM registration token
  FirebaseMessaging.instance.getToken().then((token) {
    print('FCM Token: $token');
  }).catchError((err) {
    print('Failed to get token: $err');
  });

  // Set app orientation to portrait only
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  ).then((value) {
    runApp(
      const RootRestorationScope(
        restorationId: 'root',
        child: MaterialApp(
          restorationScopeId: 'app',
          home: WApp(),
        ),
      ),
    );
  });
}

class WApp extends StatelessWidget {
  const WApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashScreen(),
    );
  }
}
