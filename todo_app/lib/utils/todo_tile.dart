import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;
  //BuildContext is a handle to the location of a widget within the widget tree.
//
//
// It's of type Function, which means it can hold a reference to any function.
// The ? after bool indicates that the boolean value can be nullable, meaning it can either have a boolean value or be null.
// Lastly, there's a ? at the end of the type declaration (Function(bool?)?). This indicates that the entire field onChanged can hold either a reference to a function or be null.
// deleteFunction :  When invoked, it would typically perform the necessary actions to delete the associated task, often using the provided BuildContext to access the necessary context for deletion operations

  ToDoTile(
      { // widget intended to display
      super.key, //Key? key,mean
      required this.taskName,
      required this.taskCompleted,
      required this.onChanged,
      required this.deleteFunction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(12),
              backgroundColor: Colors.red.shade300,
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.purple,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              // Checkbox
              Checkbox(
                value: taskCompleted,
                onChanged: onChanged,
                activeColor: Colors.black,
              ),
              const SizedBox(
                width: 5,
              ),
              // Task Name
              Expanded(
                child: Text(
                  taskName,
                  style: TextStyle(
                    color: Colors.white,
                    decoration: taskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    decorationColor: taskCompleted ? Colors.black : null,
                    fontWeight:
                        taskCompleted ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
