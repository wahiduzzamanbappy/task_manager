import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/navBarScreens/add_new_task_screen.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/task_item_widget.dart';
import 'package:task_manager/ui/widgets/tm_app_bar.dart';
import '../../widgets/task_status_summary_count_widget.dart';

class NavbarProgressTaskListScreen extends StatefulWidget {
  const NavbarProgressTaskListScreen({super.key});

  @override
  State<NavbarProgressTaskListScreen> createState() =>
      _NavbarProgressTaskListScreenState();
}

class _NavbarProgressTaskListScreenState extends State<NavbarProgressTaskListScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: TMAppBar(textTheme: textTheme),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildTaskListView(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTaskListView() {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: 10,
      itemBuilder: (context, index) => TaskItemWidget(
          text: 'Progress', color: Colors.deepPurple,),
    );
  }
}
