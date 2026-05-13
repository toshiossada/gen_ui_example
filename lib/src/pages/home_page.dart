import 'package:flutter/material.dart';

import 'models/task_item.dart';
import 'widgets/task_row_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _newTaskController = TextEditingController();
  final List<TaskItemData> _tasks = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _newTaskController.dispose();
    super.dispose();
  }

  void _toggleTask(int index, bool value) {
    setState(() {
      _tasks[index] = _tasks[index].copyWith(isDone: value);
    });
  }

  void _addTask() {
    final newTaskText = _newTaskController.text.trim();
    if (newTaskText.isEmpty) {
      return;
    }

    setState(() {
      _tasks.add(TaskItemData(text: newTaskText, isDone: false));
    });

    _newTaskController.clear();
    Navigator.of(context).pop();
  }

  Future<void> _openAddTaskModal() async {
    _newTaskController.clear();

    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add task'),
          content: TextField(
            controller: _newTaskController,
            autofocus: true,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(hintText: 'Type a new task'),
            onSubmitted: (_) => _addTask(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(onPressed: _addTask, child: const Text('Add')),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF8EB2E8),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Just Today',
          style: TextStyle(
            color: Color(0xFF2F3137),
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF2F3137)),
        actions: [
          IconButton(
            onPressed: _openAddTaskModal,
            icon: const Icon(Icons.add),
            tooltip: 'Add task',
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Today's Tasks",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF3D4048),
                ),
              ),
              const SizedBox(height: 18),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: _tasks.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 4),
                  itemBuilder: (context, index) {
                    final task = _tasks[index];
                    return TaskRowWidget(
                      text: task.text,
                      isDone: task.isDone,
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        _toggleTask(index, value);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
