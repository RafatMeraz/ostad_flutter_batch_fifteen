import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ostad_flutter_batch_fifteen/utils/snack_bar_message.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  // TODO: Add form validation

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool _singUpInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign up')),
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
            Visibility(
              visible: _singUpInProgress == false,
              replacement: const Center(child: CircularProgressIndicator()),
              child: FilledButton(
                onPressed: _onTapSignUpButton,
                child: const Text('Sign up'),
              ),
            ),
            TextButton(
              onPressed: _onTapSignInButton,
              child: const Text('Already have an account? Sign In'),
            ),
          ],
        ),
      ),
    );
  }

  void _onTapSignInButton() {
    Navigator.pop(context);
  }

  Future<void> _onTapSignUpButton() async {
    // TODO: Form validation
    // Create new user with email and password
    try {
      _singUpInProgress = true;
      setState(() {});
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: _emailTEController.text,
        password: _passwordTEController.text,
      );
      _clearTextFields();
      if (mounted) {
        showSnackBarMessage(context, 'New user created!');
        Navigator.pop(context);
      }
    } on FirebaseException catch (e) {
      if (e.code == 'email-already-in-use') {
        // TODO: Do whatever you want
      }
      debugPrint(e.stackTrace.toString());
      debugPrint(e.code);
      if (mounted) {
        showSnackBarMessage(context, e.message ?? 'Something went wrong!');
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    } finally {
      _singUpInProgress = false;
      setState(() {});
    }
  }

  void _clearTextFields() {
    _emailTEController.clear();
    _passwordTEController.clear();
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
