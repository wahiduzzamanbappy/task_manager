import 'package:flutter/material.dart';

class NavbarCompletedScreen extends StatefulWidget {
  const NavbarCompletedScreen({super.key});
  static const String name = '/completed_screen';

  @override
  State<NavbarCompletedScreen> createState() => _NavbarCompletedScreenState();
}

class _NavbarCompletedScreenState extends State<NavbarCompletedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('New Task'),
      ),
    );
  }
}
