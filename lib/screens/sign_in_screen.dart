import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ostad_flutter_batch_fifteen/utils/snack_bar_message.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  // TODO: Add form validation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign in')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 8,
          children: [
            TextFormField(
              controller: _emailTEController,
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Email',
              ),
            ),
            TextFormField(
              controller: _passwordTEController,
              decoration: const InputDecoration(
                labelText: 'Password',
                hintText: 'Password',
              ),
            ),
            FilledButton(onPressed: _onTapSignInButton, child: const Text('Sign in')),
            TextButton(
              onPressed: _onTapSignUpButton,
              child: const Text('Don\'t have an account? Sign Up'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onTapSignInButton() async {
    try {
      // Sign in existing user
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailTEController.text,
        password: _passwordTEController.text,
      );
      // Navigator.pushNamed(context, '/home');
    } on FirebaseException catch (e) {
      if (mounted) {
        showSnackBarMessage(context, e.message ?? 'Something went wrong!');
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  void _onTapSignUpButton() {
    Navigator.pushNamed(context, '/sign-up');
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
