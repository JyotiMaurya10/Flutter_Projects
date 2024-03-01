import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../data/database.dart';
import '../utils/dialog_box.dart';
import '../utils/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  //list of todo tasks
  // List toDoList = [
  //   ["Projects", false],
  //   ["Workout", false]
  // ];

  @override
  void initState() {
    // If it's the first time ever opening the app
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      //data exist , load it into list
      db.loadData();
    }
    super.initState();
  }

//Checkbox when tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  final _controller = TextEditingController();
// For new task
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
            //   onCancel: () {
            //     Navigator.pop(context);
            //   },
          );
        });
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const DefaultTextStyle(
          style: TextStyle(
            fontSize: 24.0, // Default font size
            fontWeight: FontWeight.bold, // Default font weight
            color: Colors.white, // Default text color
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text('ToDo', style: TextStyle(color: Colors.white, fontSize: 25)),
              Text('List', style: TextStyle(color: Colors.white, fontSize: 18)),
            ],
          ),
        ),
      ),
      //
      //
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      //
      //
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
