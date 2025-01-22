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
  const ResetPasswordScreen({super.key});

  static const String name = '/forgot_password/reset_password';

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
                  TextFormField(
                    controller: _newPasswordTEController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(hintText: 'New Password'),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _confirmNewPasswordTEController,
                    obscureText: true,
                    decoration: InputDecoration(hintText: 'Confirm new Password'),
                  ),
                  const SizedBox(height: 24),
                  Visibility(
                    visible: _recoverResetPassInProgress == false,
                    replacement: CenteredCircularProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: _recoverResetPass,
                      child: Text('Confirm'),
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

  Future<void> _recoverResetPass() async {
    _recoverResetPassInProgress = true;
    final NetworkResponse response =
        await NetworkCaller.postRequest(url: Urls.recoverResetPassUrl);
    if (response.isSuccess) {
      Navigator.pushNamedAndRemoveUntil(
          context, SignInScreen.name, (predicate) => false);
    } else {
      showSnackBarMessage(context, response.errorMessage);
    }
    _recoverResetPassInProgress = false;
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
