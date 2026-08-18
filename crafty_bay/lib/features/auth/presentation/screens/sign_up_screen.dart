import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/extensions/utility_extension.dart';
import '../../../../app/validators.dart';
import '../../../shared/presentation/widgets/centered_progress_indicator.dart';
import '../../../shared/presentation/widgets/snack_bar_message.dart';
import '../../data/models/sign_up_params.dart';
import '../providers/sign_up_provider.dart';
import '../widgets/app_logo.dart';
import 'sign_in_screen.dart';
import 'verify_otp_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String name = '/sign-up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _cityTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final SignUpProvider _signUpProvider = SignUpProvider();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _signUpProvider,
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
                    const SizedBox(height: 16),
                    AppLogo(width: 100, height: 100),
                    const SizedBox(height: 16),
                    Text('Sign Up', style: context.textTheme.titleLarge),
                    const SizedBox(height: 4),
                    Text(
                      context.localizations.signUpSubTitle,
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
                      controller: _firstNameTEController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(hintText: 'First name'),
                      validator: (input) => Validators.validateText(
                        input,
                        message: 'Enter your first name',
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _lastNameTEController,
                      textInputAction: .next,
                      decoration: InputDecoration(hintText: 'Last name'),
                      validator: (input) => Validators.validateText(
                        input,
                        message: 'Enter your last name',
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _mobileTEController,
                      textInputAction: TextInputAction.next,
                      keyboardType: .phone,
                      decoration: InputDecoration(hintText: 'Mobile'),
                      validator: (input) =>
                          Validators.validatePhoneNumber(input),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _cityTEController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(hintText: 'City'),
                      validator: (input) => Validators.validateText(
                        input,
                        message: 'Enter your city',
                      ),
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
                    Consumer<SignUpProvider>(
                      builder: (context, _, _) {
                        if (_signUpProvider.signUpInProgress) {
                          return CenteredProgressIndicator();
                        }

                        return FilledButton(
                          onPressed: _onTapSignUpButton,
                          child: Text('Sign Up'),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: .center,
                      children: [
                        Text(
                          context.localizations.alreadyHaveAnAccount,
                          style: context.textTheme.labelLarge,
                        ),
                        TextButton(
                          onPressed: _onTapSignInButton,
                          child: Text(context.localizations.signIn),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSignInButton() {
    Navigator.pop(context);
  }

  Future<void> _signUp() async {
    SignUpParams params = SignUpParams(
      email: _emailTEController.text.trim(),
      firstName: _firstNameTEController.text.trim(),
      lastName: _lastNameTEController.text.trim(),
      phone: _mobileTEController.text.trim(),
      password: _emailTEController.text,
      city: _cityTEController.text.trim(),
    );
    final bool isSuccess = await _signUpProvider.signUp(params);
    if (isSuccess) {
      Navigator.pushNamed(
        context,
        VerifyOtpScreen.name,
        arguments: params.email,
      );
    } else {
      showSnackBarMessage(context, _signUpProvider.errorMessage!);
    }
  }

  void _onTapSignUpButton() {
    // Check if the form is valid
    if (_formKey.currentState!.validate()) {
      _signUp();
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _cityTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
