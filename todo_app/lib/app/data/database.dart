import 'package:hive/hive.dart';

class ToDoDataBase {
  List toDoList = [];

  //reference to our box
  final _myBox = Hive.box('mybox');

  //run this method if its the first time ever opening the app
  void createInitialData() {
    toDoList = [
      ["Complete HomeWork Complete HomeWork Complete HomeWork", false],
      ["Buy 1kg Grapes", false]
    ];
  }

  //load the data from db
  void loadData() {
    toDoList = _myBox.get('TODOLIST');
  }

  // update the db
  void updateDataBase() {
    _myBox.put("TODOLIST", toDoList);
  }
}
