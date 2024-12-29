import 'package:flutter/material.dart';

class NavbarCancelledListScreen extends StatefulWidget {
  const NavbarCancelledListScreen({super.key});

  @override
  State<NavbarCancelledListScreen> createState() => _NavbarCancelledListScreenState();
}

class _NavbarCancelledListScreenState extends State<NavbarCancelledListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Cancelled List Screen'),
      ),
    );
  }
}
