import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/ui/screens/forgot_password_verify_otp_screen.dart';
import 'package:task_manager/ui/screens/sign_up_screen.dart';
import 'package:task_manager/ui/utils/app_color.dart';
import 'package:task_manager/ui/widgets/centered_circle_indicator.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';

import '../../data/utils/urls.dart';

class ForgotPasswordVerifyEmailScreen extends StatefulWidget {
  const ForgotPasswordVerifyEmailScreen({super.key});

  static const String name = '/forgot-password/verify-email';

  @override
  State<ForgotPasswordVerifyEmailScreen> createState() =>
      _ForgotPasswordVerifyEmailScreenState();
}

class _ForgotPasswordVerifyEmailScreenState
    extends State<ForgotPasswordVerifyEmailScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _verifyEmailInProgress = false;

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
                  Text('Your Email Address', style: textTheme.titleLarge),
                  const SizedBox(height: 4),
                  Text('A 6 digit OTP will be sent to your email address.',
                      style: textTheme.titleSmall),
                  const SizedBox(height: 24),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _emailTEController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(hintText: 'Email'),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter Email Address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  Visibility(
                    visible: _verifyEmailInProgress == false,
                    replacement: CenteredCircularProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: _onTapVerifyEmailButton,
                      child: Icon(
                        Icons.arrow_circle_right_outlined,
                        color: Colors.white,
                      ),
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

  void _onTapVerifyEmailButton() {
    if (_formKey.currentState!.validate()) {
      _recoveryVerifyEmail();
    }
  }

  Future<void> _recoveryVerifyEmail() async {
    _verifyEmailInProgress = true;
    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.recoverVerifyEmailUrl(_emailTEController.text));
    if (response.isSuccess) {
      Navigator.pushReplacementNamed(
          context, ForgotPasswordVerifyOtpScreen.name);
    } else {
      showSnackBarMessage(context, 'Something went wrong. Try again!.');
    }
    _verifyEmailInProgress = false;
    setState(() {});
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
                Navigator.pop(context);
              },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }
}
