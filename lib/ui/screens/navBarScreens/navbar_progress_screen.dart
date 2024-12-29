import 'package:flutter/material.dart';

class NavbarProgressScreen extends StatefulWidget {
  const NavbarProgressScreen({super.key});
  static const String name = '/progress_screen';

  @override
  State<NavbarProgressScreen> createState() => _NavbarProgressScreenState();
}

class _NavbarProgressScreenState extends State<NavbarProgressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('New Task'),
      ),
    );
  }
}
