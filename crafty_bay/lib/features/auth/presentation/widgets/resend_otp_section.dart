import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';
import '../providers/resend_otp_provider.dart';

class ResendOtpSection extends StatefulWidget {
  const ResendOtpSection({super.key});

  @override
  State<ResendOtpSection> createState() => _ResendOtpSectionState();
}

class _ResendOtpSectionState extends State<ResendOtpSection> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ResendOtpProvider>(
      builder: (context, resendOtpProvider, _) {
        return Column(
          children: [
            Visibility(
              visible: resendOtpProvider.isTimerRunning,
              replacement: TextButton(
                onPressed: _onTapResendButton,
                child: Text('Resend OTP'),
              ),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black54),
                  children: [
                    TextSpan(text: 'Resend otp after '),
                    TextSpan(
                      text: '${resendOtpProvider.resendOtpTimer}s',
                      style: TextStyle(color: AppColors.themeColor),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _onTapResendButton() {
    context.read<ResendOtpProvider>().startResendOtpTimer();
  }
}
