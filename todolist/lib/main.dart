import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        accentColor: Colors.blue,
      ),
      home: ToDoList(title: 'My To-Do List'),
    );
  }
}

class ToDoList extends StatefulWidget {
  ToDoList({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final List<String> _tasks = <String>[];
  final TextEditingController _textEditingController = TextEditingController();

  void _addTask() {
    setState(() {
      if (_textEditingController.text.isNotEmpty) {
        _tasks.add(_textEditingController.text);
        _textEditingController.clear();
      }
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: _textEditingController,
            decoration: InputDecoration(
              hintText: 'Enter a new task',
            ),
            onSubmitted: (_) => _addTask(),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: _tasks.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: Key(_tasks[index]),
                  child: ListTile(
                    title: Text(
                      _tasks[index],
                      style: TextStyle(fontSize: 18.0),
                    ),
                    subtitle: Text(
                      'Task ${index + 1}',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteTask(index)),
                    onTap: () {},
                    tileColor: index % 2 == 0
                        ? Theme.of(context).accentColor.withOpacity(0.2)
                        : Colors.white,
                  ),
                  onDismissed: (direction) => _deleteTask(index),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        tooltip: 'Add Task',
        child: Icon(Icons.add),
      ),
    );
  }
}
