import 'package:flutter/material.dart';

class NavbarCancelledScreen extends StatefulWidget {
  const NavbarCancelledScreen({super.key});

  @override
  State<NavbarCancelledScreen> createState() => _NavbarCancelledScreenState();
}

class _NavbarCancelledScreenState extends State<NavbarCancelledScreen> {
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
