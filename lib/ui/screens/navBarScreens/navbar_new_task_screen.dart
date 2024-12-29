import 'package:flutter/material.dart';

class NavbarNewTaskListScreen extends StatefulWidget {
  const NavbarNewTaskListScreen({super.key});

  @override
  State<NavbarNewTaskListScreen> createState() =>
      _NavbarNewTaskListScreenState();
}

class _NavbarNewTaskListScreenState extends State<NavbarNewTaskListScreen> {
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
