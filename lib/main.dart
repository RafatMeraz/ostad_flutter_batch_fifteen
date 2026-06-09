import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ostad_flutter_batch_fifteen/screens/home_screen.dart';
import 'package:ostad_flutter_batch_fifteen/screens/sign_in_screen.dart';

import 'firebase_options.dart';
import 'screens/sign_up_screen.dart';

Future<void> main() async {
  // Ensure initialization
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, asyncSnapshot) {
        print(asyncSnapshot.data);

        // TODO: If user already logged in, then move to home screen, otherwise
        // move to sign in

        return MaterialApp(
          initialRoute: asyncSnapshot.data != null ? '/home' : '/sign-in', // TODO: Fix this
          routes: {
            '/sign-in': (_) => SignInScreen(),
            '/sign-up': (_) => SignUpScreen(),
            '/home': (_) => HomeScreen(),
          },
        );
      },
    );
  }
}
