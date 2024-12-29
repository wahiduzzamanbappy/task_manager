import 'package:flutter/material.dart';

class NavbarCompletedListScreen extends StatefulWidget {
  const NavbarCompletedListScreen({super.key});
  static const String name = '/completed_screen';

  @override
  State<NavbarCompletedListScreen> createState() => _NavbarCompletedListScreenState();
}

class _NavbarCompletedListScreenState extends State<NavbarCompletedListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('Completed List Screen'),
      ),
    );
  }
}
