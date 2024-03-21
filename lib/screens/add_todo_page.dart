import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoappdemo/models/task_model.dart';
import 'package:todoappdemo/service/todo_service.dart';

import 'package:todoappdemo/widgets/appbutton.dart';

class AddTodoPage extends StatefulWidget {
  final ToDoModel? todo;
  const AddTodoPage({super.key, this.todo});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _desController = TextEditingController();

  final _addTaskKey = GlobalKey<FormState>();

  TodoServiceProvider _todoService = TodoServiceProvider();

  @override
  void initState() {
    seData();
    super.initState();
  }

  seData() {
    if (widget.todo != null) {
      _titleController.text = widget.todo!.title!;
      _desController.text = widget.todo!.body!;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _desController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoServiceProvider>(
        builder: (context, todoProvider, child) {
      return Scaffold(
        appBar: AppBar(
          title:
              widget.todo == null ? Text("Add New Task") : Text("Update Task"),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.all(20),
          child: Form(
            key: _addTaskKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Add Task"),
                TextFormField(
                  controller: _titleController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter a valid title";
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _desController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter a valid Description";
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: AppButton(
                    height: 48,
                    width: 250,
                    color: Colors.teal,
                    onTap: () {
                      if (_addTaskKey.currentState!.validate()) {
                        ToDoModel todo = ToDoModel(
                            title: _titleController.text,
                            body: _desController.text,
                            status: 1,
                            createdAt: DateTime.now());

                        todoProvider.addTodo(todo);
                        Navigator.pop(context);
                      }
                    },
                    child: widget.todo != null
                        ? Text("Update Task")
                        : Text("Add Task"),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
