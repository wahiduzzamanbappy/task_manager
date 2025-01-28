import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/navBarScreens/progress_task_list_screen.dart';
import 'navBarScreens/cancelled_list_screen.dart';
import 'navBarScreens/completed_list_screen.dart';
import 'navBarScreens/new_task_list_screen.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});
  static const String name = '/home';

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

int _selectedIndex = 0;
final List<Widget> _screen = const [
  NewTaskListScreen(),
  NavbarProgressTaskListScreen(status: 'Progress',),
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
              icon: Icon(Icons.refresh_outlined), label: 'Progress'),
          NavigationDestination(
              icon: Icon(Icons.done_all_rounded), label: 'Completed'),
          NavigationDestination(
              icon: Icon(Icons.cancel_outlined), label: 'Cancelled'),
        ],
      ),
    );
  }
}
