import 'package:flutter/material.dart';

class NavbarProgressListScreen extends StatefulWidget {
  const NavbarProgressListScreen({super.key});
  static const String name = '/progress_screen';

  @override
  State<NavbarProgressListScreen> createState() => _NavbarProgressListScreenState();
}

class _NavbarProgressListScreenState extends State<NavbarProgressListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Progress List Screen'),
      ),
    );
  }
}
