import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/utils/app_color.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String name = '/Sign_up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                Text('Join with us', style: textTheme.titleLarge),
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
                const SizedBox(height: 8),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _firstNameTEController,
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'First Name'),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter first name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _lastNameTEController,
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'Last Name'),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter last name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _mobileTEController,
                  keyboardType: TextInputType.phone,
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'Mobile Number'),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter valid number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _passwordTEController,
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'Password'),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.arrow_circle_right_outlined,
                    color: Colors.white,
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
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _passwordTEController.dispose();

    super.dispose();
  }
}
