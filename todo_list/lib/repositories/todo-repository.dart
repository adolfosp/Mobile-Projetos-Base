import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/todo.dart';

class TodoRepository{
  late SharedPreferences sharedPreferences;
  final todoListKey = 'todo_list';

  TodoRepository(){
    SharedPreferences.getInstance().then((value) => sharedPreferences = value);
  }

  Future<List<Todo>> getTodoList() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final String jsonString = sharedPreferences.getString(todoListKey) ?? '[]';
    final List jsonDecoded = json.decode(jsonString) as List;
    return jsonDecoded.map((e) => Todo.fromJson(e)).toList();
  }

  void saveTodoList(List<Todo> todos){
    final jsonString = json.encode(todos);
    sharedPreferences.setString(todoListKey, jsonString );
  }



}