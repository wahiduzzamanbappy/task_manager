import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/navBarScreens/add_new_task_screen.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/task_item_widget.dart';
import 'package:task_manager/ui/widgets/tm_app_bar.dart';
import '../../widgets/task_status_summary_count_widget.dart';

class NavbarNewTaskListScreen extends StatefulWidget {
  const NavbarNewTaskListScreen({super.key});

  @override
  State<NavbarNewTaskListScreen> createState() =>
      _NavbarNewTaskListScreenState();
}

class _NavbarNewTaskListScreenState extends State<NavbarNewTaskListScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: TMAppBar(textTheme: textTheme),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTasksSummaryByStatus(textTheme),
              _buildTaskListView(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddNewTaskScreen.name);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildTaskListView() {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: 10,
      itemBuilder: (context, index) => TaskItemWidget(text: 'New', color: Colors.blue,),
    );
  }

  Widget _buildTasksSummaryByStatus(TextTheme textTheme) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            TaskStatusSummaryCountWidget(
              textTheme: textTheme,
              title: 'New',
              count: '12',
            ),
            TaskStatusSummaryCountWidget(
              textTheme: textTheme,
              title: 'Progress',
              count: '10',
            ),
            TaskStatusSummaryCountWidget(
              textTheme: textTheme,
              title: 'Completed',
              count: '8',
            ),
            TaskStatusSummaryCountWidget(
              textTheme: textTheme,
              title: 'Cancelled',
              count: '10',
            ),
          ],
        ),
      ),
    );
  }
}
