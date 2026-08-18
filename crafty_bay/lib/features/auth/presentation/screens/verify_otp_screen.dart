import 'package:crafty_bay/app/app_colors.dart';
import 'package:crafty_bay/features/auth/data/models/verify_otp_params.dart';
import 'package:crafty_bay/features/auth/presentation/providers/resend_otp_provider.dart';
import 'package:crafty_bay/features/auth/presentation/widgets/resend_otp_section.dart';
import 'package:crafty_bay/features/shared/presentation/screens/main_nav_holder_screen.dart';
import 'package:crafty_bay/features/shared/presentation/widgets/snack_bar_message.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../../../../app/extensions/utility_extension.dart';
import '../../../shared/presentation/widgets/centered_progress_indicator.dart';
import '../providers/verify_otp_provider.dart';
import '../widgets/app_logo.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key, required this.email});

  static const String name = '/verify-otp';

  final String email;

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final PinInputController _otpTEController = PinInputController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ResendOtpProvider _resendOtpProvider = ResendOtpProvider();

  final VerifyOtpProvider _verifyOtpProvider = VerifyOtpProvider();

  @override
  void initState() {
    super.initState();
    _resendOtpProvider.startResendOtpTimer();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _resendOtpProvider),
        ChangeNotifierProvider.value(value: _verifyOtpProvider),
      ],
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
                    Text('Verify OTP', style: context.textTheme.titleLarge),
                    const SizedBox(height: 4),
                    Text(
                      'Enter the OTP sent to your email',
                      style: context.textTheme.labelLarge,
                    ),
                    const SizedBox(height: 24),
                    MaterialPinField(
                      length: 4,
                      pinController: _otpTEController,
                      theme: MaterialPinTheme(
                        shape: MaterialPinShape.outlined,
                        cellSize: Size(48, 48),
                        spacing: 16,
                        borderRadius: BorderRadius.circular(12),
                        fillColor: Colors.transparent,
                        completeFillColor: Colors.grey,
                        focusedFillColor: AppColors.themeColor.withAlpha(50),
                        focusedBorderColor: AppColors.themeColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Consumer<VerifyOtpProvider>(
                      builder: (context, _, _) {
                        if (_verifyOtpProvider.verifyOtpInProgress) {
                          return CenteredProgressIndicator();
                        }

                        return FilledButton(
                          onPressed: _onTapVerifyButton,
                          child: Text('Verify'),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    ResendOtpSection(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapVerifyButton() {
    if (_otpTEController.text.length == 4) {
      _verifyOtp();
    }
  }

  Future<void> _verifyOtp() async {
    VerifyOtpParams params = VerifyOtpParams(
      email: widget.email,
      otp: _otpTEController.text,
    );
    bool isSuccess = await _verifyOtpProvider.verifyOtp(params);
    if (isSuccess) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        MainNavHolderScreen.name,
        (_) => false,
      );
    } else {
      showSnackBarMessage(context, _verifyOtpProvider.errorMessage!);
    }
  }

  @override
  void dispose() {
    _otpTEController.dispose();
    super.dispose();
  }
}
