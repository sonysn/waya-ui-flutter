import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:qunot/functions/notification_service.dart';
import 'package:qunot/screens/splash_screen.dart';
import 'package:qunot/screens/homepage.dart';
import 'package:flutter/services.dart';
import 'package:qunot/screens/walletpage.dart';
import 'package:qunot/firebase_options.dart';

Future<void> main() async {
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

  final NotificationService notificationService = NotificationService();
  await notificationService.initialize();

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

class WApp extends StatefulWidget {
  const WApp({Key? key}) : super(key: key);

  @override
  State<WApp> createState() => _WAppState();
}

class _WAppState extends State<WApp> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    _configureFirebaseMessaging();
  }

  void _configureFirebaseMessaging() {
    _firebaseMessaging.requestPermission();
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Handle notification click here
      navigateToScreenBasedOnPayload(message.data);
    });
  }

  void navigateToScreenBasedOnPayload(Map<String, dynamic> data) {
    // Extract the necessary data from the payload and navigate to the appropriate screen
    if (data.containsKey('screen')) {
      String screen = data['screen'];

      // Navigate to the specified screen
      if (screen == 'homepage') {
        // Extract additional data if needed and pass it to the screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(data: data),
          ),
        );
      } else if (screen == 'walletpage') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WalletPage(data: data),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashScreen(),
    );
  }
}
