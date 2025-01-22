import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/ui/screens/reset_password.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/utils/app_color.dart';
import 'package:task_manager/ui/widgets/centered_circle_indicator.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';

import '../../data/utils/urls.dart';

class ForgotPasswordVerifyOtpScreen extends StatefulWidget {
  const ForgotPasswordVerifyOtpScreen({super.key, this.email});
  final email;

  static const String name = '/forgot-password/verify-otp';

  @override
  State<ForgotPasswordVerifyOtpScreen> createState() =>
      _ForgotPasswordVerifyOtpScreenState();
}

class _ForgotPasswordVerifyOtpScreenState
    extends State<ForgotPasswordVerifyOtpScreen> {
  final TextEditingController _otpTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _verifyOtpInProgress = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: ScreenBackground(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80),
                  Text('PIN Verification', style: textTheme.titleLarge),
                  const SizedBox(height: 4),
                  Text('A 6 digit OTP will be sent to your email address.',
                      style: textTheme.titleSmall),
                  const SizedBox(height: 24),
                  _buildPinCodeTextField(context),
                  const SizedBox(height: 24),
                  Visibility(
                    visible: _verifyOtpInProgress == false,
                    replacement: CenteredCircularProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: _onTapOTPButton,
                      child: Text('Verify'),
                    ),
                  ),
                  const SizedBox(height: 48),
                  Center(
                    child: Column(
                      children: [
                        _buildSignUpSection(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapOTPButton () {
    if (_formKey.currentState!.validate()) {
      _recoveryVerifyOtp();
    }
  }

  Future<void> _recoveryVerifyOtp() async {
    _verifyOtpInProgress = true;
    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.recoverVerifyOtpUrl(_otpTEController.text, widget.email));
    if (response.isSuccess) {
      Navigator.pushNamedAndRemoveUntil(
          context, ResetPasswordScreen.name, (_) => false);
    } else {
      showSnackBarMessage(context, 'Your OTP is incorrect. Try again!');
    }
    _verifyOtpInProgress = false;
    setState(() {});
  }

  Widget _buildPinCodeTextField(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      controller: _otpTEController,
      length: 6,
      keyboardType: TextInputType.number,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 50,
        activeFillColor: Colors.white,
        selectedFillColor: Colors.white,
        inactiveFillColor: Colors.white,
      ),
      animationDuration: Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
      enableActiveFill: true,
    );
  }

  Widget _buildSignUpSection() {
    return RichText(
      text: TextSpan(
        text: "Have an account?",
        style: TextStyle(color: Colors.black45, fontWeight: FontWeight.w600),
        children: [
          TextSpan(
            text: 'Sign In',
            style: TextStyle(color: AppColors.themeColor),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushNamedAndRemoveUntil(
                    context, SignInScreen.name, (predicate) => false);
              },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _otpTEController.dispose();

    super.dispose();
  }
}
