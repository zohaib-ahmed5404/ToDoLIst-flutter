import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EZ MANAGER',
      theme: ThemeData(
        primaryColor: Colors.teal,
        dialogBackgroundColor:Colors.blue[150] ,
        hintColor: Colors.amber,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
        ),
      ),
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final List<TodoItem> _items = [];
  final TextEditingController _controller = TextEditingController();

  void _addItem(String task) {
    if (task.isNotEmpty) {
      setState(() {
        _items.add(TodoItem(task: task));
      });
      _controller.clear();
    }
  }

  void _editItem(int index, String newTask) {
    if (newTask.isNotEmpty) {
      setState(() {
        _items[index].task = newTask;
      });
    }
  }

  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  void _toggleCheck(int index) {
    setState(() {
      _items[index].isChecked = !_items[index].isChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('EZ Manager',style: TextStyle(fontWeight: FontWeight.bold),),backgroundColor: Colors.blue[200],),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.teal[100],
                labelText: 'Add a new task',
                labelStyle: const TextStyle(color: Colors.teal),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add, color: Colors.teal),
                  onPressed: () => _addItem(_controller.text),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 4,
                  color: Colors.teal[200],
                  child: ListTile(
                    title: Text(
                      _items[index].task,
                      style: TextStyle(
                        decoration: _items[index].isChecked
                            ? TextDecoration.lineThrough
                            : null,
                        color: _items[index].isChecked
                            ? Colors.grey
                            : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: Checkbox(
                      value: _items[index].isChecked,
                      onChanged: (value) => _toggleCheck(index),
                      activeColor: Colors.teal,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.teal),
                          onPressed: () {
                            _editItem(index, _controller.text);
                            _controller.text = _items[index].task;
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _removeItem(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TodoItem {
  String task;
  bool isChecked;

  TodoItem({required this.task, this.isChecked = false});
}
