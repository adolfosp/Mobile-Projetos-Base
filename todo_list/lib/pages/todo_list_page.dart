import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/repositories/todo-repository.dart';

import '../models/todo.dart';
import '../widgets/todo_list_item.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<Todo> tasks = [];
  Todo? deletedTodo;
  int? positionDeletedTodo;
  String? errorText;

  final TextEditingController taskController = new TextEditingController();
  final TodoRepository todoRepository = TodoRepository();

  @override
  void initState() {
    super.initState();

    todoRepository.getTodoList().then((value) => {
          setState(() {
            tasks = value;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: taskController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Adicione uma tarefa',
                          hintText: 'Ex. Estudar flutter',
                          errorText: errorText,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            width: 2,
                            color: Color(0xff00d7f3),
                          )),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        String text = taskController.text;
                        if (text.isEmpty) {
                          setState(() {
                            errorText = 'O título não pode ser vazio';
                          });
                          return;
                        }
                        setState(() {
                          Todo newTodo =
                              Todo(title: text, date: DateTime.now());
                          tasks.add(newTodo);
                        });
                        taskController.clear();
                        todoRepository.saveTodoList(tasks);
                        errorText = null;
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff00d7f3),
                        padding: EdgeInsets.all(16),
                      ),
                      child: Icon(
                        Icons.add,
                        size: 30,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (Todo task in tasks)
                        TodoListItem(todo: task, onDelete: onDelete),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child:
                          Text('Você possui ${tasks.length} tarefas pendentes'),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed: showDeleteTodosConfirmationDialog,
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff00d7f3),
                        padding: EdgeInsets.all(16),
                      ),
                      child: Text('Limpar tudo'),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showDeleteTodosConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Limpar tudo?'),
        content: Text('Você tem certeza que deseja apagar todas as tarefas?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(primary: Color(0xff00d7f3)),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              deleteAllTodos();
            },
            child: Text('Confirmar'),
            style: TextButton.styleFrom(primary: Colors.red),
          ),
        ],
      ),
    );
  }

  void deleteAllTodos() {
    setState(() => {tasks.clear()});
    todoRepository.saveTodoList(tasks);
  }

  void onDelete(Todo todo) {
    deletedTodo = todo;
    positionDeletedTodo = tasks.indexOf(todo);
    setState(() {
      tasks.remove(todo);
    });
    todoRepository.saveTodoList(tasks);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Tarefa ${todo.title} foi removida com sucesso!',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        action: SnackBarAction(
          label: 'Desfazer',
          textColor: const Color(0xff00d7f3),
          onPressed: () {
            setState(() {
              tasks.insert(positionDeletedTodo!, deletedTodo!);
            });
          },
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  }
}
