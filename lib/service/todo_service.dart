


import 'package:flutter/cupertino.dart';
import 'package:todoappdemo/models/task_model.dart';

class TodoServiceProvider with ChangeNotifier{



  List<ToDoModel> _todoList=[];

  List<ToDoModel> get todoList =>_todoList;

  addTodo(ToDoModel todo){


    _todoList.add(todo);
    notifyListeners();



  }

  // update



deleteTask(int index){


    _todoList.removeAt(index);
    notifyListeners();



}





}