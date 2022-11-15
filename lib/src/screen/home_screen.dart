import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:todo/src/material_app.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final todoItems = <TodoItem>[TodoItem("hello")];
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text("todo app"),
      actions: [
        IconButton(
            onPressed: () {
              context
                  .findAncestorStateOfType<MyMaterialAppState>()!
                  .changeTheme();
            },
            icon: Icon(Icons.brightness_3_outlined)),
        IconButton(
            onPressed: () {
              Color currentColor = Color(0xff443a49);
              var colorPicker = ColorPicker(
                pickerColor: Colors.orange,
                onColorChanged: (color) {
                  currentColor = color;
                },
              );
              var onTapEnd = () {
                context
                    .findAncestorStateOfType<MyMaterialAppState>()!
                    .changeColor(currentColor);
                Navigator.of(context).pop();
              };
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Pick a color!'),
                      content: SingleChildScrollView(
                        child: colorPicker,
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Got it'),
                          onPressed: onTapEnd,
                        ),
                      ],
                    );
                  });
            },
            icon: Icon(Icons.color_lens))
      ],
    );
    return Scaffold(
      appBar: appBar,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  final controller = TextEditingController();
                  return AlertDialog(
                    title: Text("Add nedsfw todo"),
                    content: TextField(
                      controller: controller,
                      onSubmitted: (val) {
                        setState(() {
                          todoItems.add(TodoItem(val));
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            setState(() {
                              todoItems.add(TodoItem(controller.text));
                            });
                            Navigator.of(context).pop();
                          },
                          child: Text("Add"))
                    ],
                  );
                });
          }),
      body: ListView(
        padding: EdgeInsets.only(bottom: 60),
        scrollDirection: Axis.vertical,
        children: [
          for (var i = 0; i < todoItems.length; i++)
            ListTile(
              leading: Checkbox(
                value: todoItems[i].isCheck,
                onChanged: (isChecked) {
                  setState(() {
                    todoItems[i].isCheck = isChecked!;
                  });
                },
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    todoItems.removeAt(i);
                  });
                },
              ),
              title: Text(todoItems[i].title),
            )
        ],
      ),
    );
  }
}

class TodoItem {
  final String title;
  bool isCheck = false;

  TodoItem(this.title);
}
