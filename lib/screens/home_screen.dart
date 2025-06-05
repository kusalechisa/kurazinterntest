import 'package:flutter/material.dart';
import 'package:shared_preferences.dart';
import 'dart:convert';
import '../models/task.dart';
import '../widgets/task_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> _tasks = [];
  int _nextId = 1;
  final _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final prefs = await _prefs;
    final tasksJson = prefs.getStringList('tasks') ?? [];
    setState(() {
      _tasks = tasksJson
          .map((taskJson) => Task.fromMap(json.decode(taskJson)))
          .toList();
      _nextId = _tasks.isEmpty ? 1 : _tasks.map((t) => t.id).reduce((a, b) => a > b ? a : b) + 1;
    });
  }

  Future<void> _saveTasks() async {
    final prefs = await _prefs;
    final tasksJson = _tasks.map((task) => json.encode(task.toMap())).toList();
    await prefs.setStringList('tasks', tasksJson);
  }

  void _addTask(String title) {
    setState(() {
      _tasks.add(Task(id: _nextId++, title: title));
      _saveTasks();
    });
  }

  void _toggleTask(int id) {
    setState(() {
      final task = _tasks.firstWhere((t) => t.id == id);
      task.isCompleted = !task.isCompleted;
      _saveTasks();
    });
  }

  void _deleteTask(int id) {
    setState(() {
      _tasks.removeWhere((t) => t.id == id);
      _saveTasks();
    });
  }

  void _showAddTaskDialog() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Task'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Enter task title',
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                _addTask(controller.text);
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
      ),
      body: _tasks.isEmpty
          ? const Center(
              child: Text(
                'No tasks yet!\nTap + to add a task',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return TaskItem(
                  task: task,
                  onToggle: (_) => _toggleTask(task.id),
                  onDelete: () => _deleteTask(task.id),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
} 