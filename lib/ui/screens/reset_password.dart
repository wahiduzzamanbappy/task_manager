import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/screens/forgot_password_verify_email_screen.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/screens/sign_up_screen.dart';
import 'package:task_manager/ui/utils/app_color.dart';
import 'package:task_manager/ui/widgets/centered_circle_indicator.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen(
      {super.key, required this.email, required this.otp});

  static const String name = '/forgot_password/reset_password';
  final String email;
  final String otp;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _newPasswordTEController =
  TextEditingController();
  final TextEditingController _confirmNewPasswordTEController =
  TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _recoverResetPassInProgress = false;
  bool _obscureText = true;
  bool _obscureTextOne = true;

  void _toggleNewPasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _obscureTextOne = !_obscureTextOne;
    });
  }

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
                  Text('Set Password', style: textTheme.titleLarge),
                  const SizedBox(height: 4),
                  Text('Minimum length of password should be 8 letters.'),
                  const SizedBox(height: 24),
                  // New Password TextField
                  TextFormField(
                    controller: _newPasswordTEController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      hintText: 'New Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey.shade500,
                        ),
                        onPressed: _toggleNewPasswordVisibility,
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter a valid password';
                      }
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters long';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  // Confirm Password TextField
                  TextFormField(
                    controller: _confirmNewPasswordTEController,
                    obscureText: _obscureTextOne,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureTextOne
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey.shade500,
                        ),
                        onPressed: _toggleConfirmPasswordVisibility,
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Confirm your password';
                      }
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters long';
                      }
                      if (value != _newPasswordTEController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  Visibility(
                    visible: !_recoverResetPassInProgress,
                    replacement: CenteredCircularProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: _onTapResetButton,
                      child: Text('Confirm'),
                    ),
                  ),
                  const SizedBox(height: 48),
                  Center(
                    child: _buildSignUpSection(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapResetButton() {
    if (_formKey.currentState!.validate()) {
      _recoverResetPass();
      showSnackBarMessage(context, 'Password Reset Successfully.');
    }
  }

  Future<void> _recoverResetPass() async {
    setState(() {
      _recoverResetPassInProgress = true;
    });

    Map<String, dynamic> requestBody = {
      "email": widget.email.toString(),
      "OTP": widget.otp.toString(),
      "password": _newPasswordTEController.text,
    };

    final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.recoverResetPassUrl, body: requestBody);

    if (response.isSuccess) {
      Navigator.pushNamedAndRemoveUntil(
          context, SignInScreen.name, (predicate) => false);
    } else {
      showSnackBarMessage(context, response.errorMessage);
    }

    setState(() {
      _recoverResetPassInProgress = false;
    });
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
    _newPasswordTEController.dispose();
    _confirmNewPasswordTEController.dispose();
    super.dispose();
  }
}
