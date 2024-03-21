import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoappdemo/models/task_model.dart';
import 'package:todoappdemo/screens/add_todo_page.dart';
import 'package:todoappdemo/service/todo_service.dart';

class TodoListScreen extends StatelessWidget {
 TodoListScreen({super.key});

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff505050),
      key: _scaffoldKey,
      drawer: Drawer(),
      appBar: AppBar(
        backgroundColor: Color(0xff505050),

        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          icon: Icon(Icons.grid_view,color: Colors.white,),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddTodoPage()));
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("All Todos"),
            SizedBox(
              height: 20,
            ),
            Consumer<TodoServiceProvider>(
                builder: (context, todoProvider, child) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: todoProvider.todoList.length,
                  itemBuilder: (context, index) {
                    if (todoProvider.todoList.length < 0) {
                      return Center(
                        child: Text(
                          "No taska dded",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    } else {
                      return Card(
                        child: ListTile(

                          trailing: Container(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(onPressed: (){
                                  Navigator.push(
                                      context, MaterialPageRoute(builder: (context) => AddTodoPage(

                                    todo: todoProvider.todoList[index]
                                    ,
                                  )));

                                }, icon: Icon(Icons.edit)),

                                IconButton(onPressed: (){

                                  todoProvider.deleteTask(index);


                                }, icon: Icon(Icons.delete))
                              ],
                            ),
                          ),

                          title: Text("${todoProvider.todoList[index].title}"),
                          subtitle: Text("${todoProvider.todoList[index].body}"),
                        ),
                      );
                    }
                  });
            })
          ],
        ),
      ),
    );
  }
}
