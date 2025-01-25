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
  const ForgotPasswordVerifyOtpScreen({super.key, required this.email});

  final String email;
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
                  Text(
                    'A 6 digit OTP has been sent to your email.',
                    style: textTheme.titleSmall,
                  ),
                  const SizedBox(height: 24),
                  _buildPinCodeTextField(context),
                  const SizedBox(height: 24),
                  Visibility(
                    visible: _verifyOtpInProgress == false,
                    replacement: const CenteredCircularProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: () {
                        _onTapOTPButton(context);
                      },
                      child: const Text('Verify'),
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
        inactiveFillColor: Colors.transparent,
      ),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
      enableActiveFill: true,
    );
  }

  Widget _buildSignUpSection() {
    return RichText(
      text: TextSpan(
        text: "Have an account?",
        style:
            const TextStyle(color: Colors.black45, fontWeight: FontWeight.w600),
        children: [
          TextSpan(
            text: ' Sign In',
            style: const TextStyle(color: AppColors.themeColor),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  SignInScreen.name,
                  (predicate) => false,
                );
              },
          ),
        ],
      ),
    );
  }

  void _onTapOTPButton(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _recoveryVerifyOtp(context);
    } else {
      showSnackBarMessage(context, 'Email not found. Please try again.');
    }
  }

  Future<void> _recoveryVerifyOtp(BuildContext context) async {
    _verifyOtpInProgress = true;
    setState(() {});

    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.recoverVerifyOtpUrl(
          widget.email.toString(), _otpTEController.text),
    );

    if (response.isSuccess) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ResetPasswordScreen(
                  email: widget.email, otp: _otpTEController.text)));
    } else {
      showSnackBarMessage(context, 'OTP is incorrect. Try again!');
    }
    _verifyOtpInProgress = false;
    setState(() {});
  }

  @override
  void dispose() {
    _otpTEController.dispose();
    super.dispose();
  }
}
