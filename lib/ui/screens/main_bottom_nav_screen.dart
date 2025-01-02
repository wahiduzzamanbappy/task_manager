import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/navBarScreens/navbar_progress_task_list_screen.dart';
import 'navBarScreens/navbar_cancelled_list_screen.dart';
import 'navBarScreens/navbar_completed_list_screen.dart';
import 'navBarScreens/navbar_new_task_list_screen.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});
  static const String name = '/home';

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

int _selectedIndex = 0;
final List<Widget> _screen = const [
  NavbarNewTaskListScreen(),
  NavbarProgressTaskListScreen(),
  NavbarCompletedTaskListScreen(),
  NavbarCancelledTaskListScreen(),
];

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screen[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          _selectedIndex = index;
          setState(() {});
        } ,
        destinations: [
          NavigationDestination(
              icon: Icon(Icons.new_label_outlined), label: 'New Task'),
          NavigationDestination(
              icon: Icon(Icons.refresh), label: 'Progress'),
          NavigationDestination(
              icon: Icon(Icons.done), label: 'Completed'),
          NavigationDestination(
              icon: Icon(Icons.cancel_outlined), label: 'Cancelled'),
        ],
      ),
    );
  }
}
