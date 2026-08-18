import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/extensions/utility_extension.dart';
import '../../../../app/validators.dart';
import '../../../shared/presentation/screens/main_nav_holder_screen.dart';
import '../../../shared/presentation/widgets/centered_progress_indicator.dart';
import '../../../shared/presentation/widgets/snack_bar_message.dart';
import '../../data/models/sign_in_params.dart';
import '../providers/sign_in_provider.dart';
import '../widgets/app_logo.dart';
import 'sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String name = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final SignInProvider _signInProvider = SignInProvider();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _signInProvider,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: .all(24),
              child: Form(
                key: _formKey,
                autovalidateMode: .onUserInteraction,
                child: Column(
                  children: [
                    const SizedBox(height: 48),
                    AppLogo(width: 100, height: 100),
                    const SizedBox(height: 16),
                    Text('Welcome Back', style: context.textTheme.titleLarge),
                    const SizedBox(height: 4),
                    Text(
                      'Please enter your details to continue',
                      style: context.textTheme.labelLarge,
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _emailTEController,
                      textInputAction: TextInputAction.next,
                      keyboardType: .emailAddress,
                      decoration: InputDecoration(hintText: 'Email'),
                      validator: Validators.validateEmail,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordTEController,
                      obscureText: true,
                      obscuringCharacter: '*',
                      decoration: InputDecoration(hintText: 'Password'),
                      validator: Validators.validatePassword,
                    ),
                    const SizedBox(height: 16),
                    Consumer<SignInProvider>(
                      builder: (context, _, _) {
                        if (_signInProvider.signInInProgress) {
                          return CenteredProgressIndicator();
                        }

                        return FilledButton(
                          onPressed: _onTapSignInButton,
                          child: Text('Sign In'),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: .center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: context.textTheme.labelLarge,
                        ),
                        TextButton(
                          onPressed: _onTapSignUpButton,
                          child: Text('Sign Up'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signIn() async {
    SignInParams params = SignInParams(
      email: _emailTEController.text.trim(),
      password: _passwordTEController.text,
    );
    final bool isSuccess = await _signInProvider.signIn(params);

    if (!mounted) return;

    if (isSuccess) {
      Navigator.pushNamedAndRemoveUntil(
          context, MainNavHolderScreen.name, (_) => false);
    } else {
      showSnackBarMessage(context, _signInProvider.errorMessage!);
    }
  }

  void _onTapSignInButton() {
    if (_formKey.currentState!.validate()) {
      _signIn();
    }
  }

  void _onTapSignUpButton() {
    Navigator.pushNamed(context, SignUpScreen.name);
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}