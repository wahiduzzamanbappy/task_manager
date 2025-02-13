import 'package:flutter/material.dart';

class TaskStatusSummaryCountWidget extends StatelessWidget {
  const TaskStatusSummaryCountWidget({
    super.key,
    required this.textTheme,
    required this.title,
    required this.count,
  });

  final String title;
  final String count;

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Column(
          children: [
            Text(
              count,
              style: textTheme.titleLarge,
            ),
            Text(
              title,
              style: textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}
