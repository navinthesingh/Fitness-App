import 'package:firebase_core/firebase_core.dart';
import 'package:smart_fitness_application/view/screens/Splash/splash_screen.dart';
import 'package:smart_fitness_application/view/screens/UserAuth/login_page.dart';
import 'package:smart_fitness_application/view/screens/UserAuth/sign_up_page.dart';
import 'package:smart_fitness_application/widgets/bottom_navigation.dart';
import 'firebase_options.dart';

// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // if (kIsWeb) {
  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );
  // } else {
  //   await Firebase.initializeApp();
  // }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Smart Fitness Application',
      routes: {
        '/': (context) => SplashScreen(
              child: SignUpPage(),
            ),
        '/login': (context) => LoginPage(),
        '/signUp': (context) => SignUpPage(),
        '/home': (context) => BottomNavBar(),
      },
    );
  }
}
