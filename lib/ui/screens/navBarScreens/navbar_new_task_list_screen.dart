import 'package:flutter/material.dart';

class NavbarNewTaskListScreen extends StatefulWidget {
  const NavbarNewTaskListScreen({super.key});

  @override
  State<NavbarNewTaskListScreen> createState() =>
      _NavbarNewTaskListScreenState();
}

class _NavbarNewTaskListScreenState extends State<NavbarNewTaskListScreen> {
  final TextEditingController _subjectTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                Text('Add New Task', style: textTheme.titleLarge),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _subjectTEController,
                  decoration: InputDecoration(hintText: 'Subject'),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _descriptionTEController,
                  decoration: InputDecoration(hintText: 'Description'),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.arrow_circle_right_outlined,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
