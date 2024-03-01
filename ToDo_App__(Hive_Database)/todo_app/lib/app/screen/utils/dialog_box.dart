import 'package:flutter/material.dart';

import 'my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.purple[300],
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(

                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // Set border color to white
                ),
                hintText: "Add a new task",
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //cancel
                MyButton(text: "Cancel", onPressed: onCancel),
                //save
                MyButton(text: "Save", onPressed: onSave),

              ],
            )
          ],
        ),
      ),
    );
  }
}
