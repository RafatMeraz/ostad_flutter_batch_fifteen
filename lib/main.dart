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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, AsyncSnapshot<User?> snapshot) {
          // While in progress
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          // When stream hase data(User object)
          if (snapshot.hasData) {
            return const HomeScreen();
          }
          // When stream is null
          return const SignInScreen();
        },
      ),
      routes: {
        '/sign-in': (_) => const SignInScreen(),
        '/sign-up': (_) => const SignUpScreen(),
        '/home': (_) => const HomeScreen(),
      },
    );
  }
}
