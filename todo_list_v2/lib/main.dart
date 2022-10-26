import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(
    MaterialApp(
      home: Home(),
    ),
  );
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _todoList = [];
  Map<String, dynamic>? _lastRemoved;
  int _lastRemovedPos = 0;

  final TextEditingController _task = TextEditingController();

  @override
  void initState() {
    super.initState();
    _readData().then((value) {
      setState(() {
        _todoList = json.decode(value);
      });
    });
  }

  void _addTodo() {
    setState(() {
      Map<String, dynamic> newTodo = Map();
      newTodo["title"] = _task.text;
      _task.text = "";
      newTodo["ok"] = false;
      _todoList.add(newTodo);

      _saveData();
    });
  }

  Future<Null> _refresh() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _todoList.sort((a, b) {
        if (a["ok"] && !b["ok"])
          return 1;
        else if (!a["ok"] && b["ok"])
          return -1;
        else
          return 0;
      });

      _saveData();
    });

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de tarefas"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _task,
                    decoration: InputDecoration(
                        labelText: "Nova tarefa",
                        labelStyle: TextStyle(color: Colors.blueAccent)),
                  ),
                ),
                ElevatedButton(
                  onPressed: _addTodo,
                  child: Text("Add"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.builder(
                padding: EdgeInsets.only(top: 10.0),
                itemCount: _todoList.length,
                itemBuilder: (context, index) {
                  return buildItem(context, index);
                }),
          )),
        ],
      ),
    );
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  Future<File> _saveData() async {
    String data = json.encode(_todoList);
    final file = await _getFile();
    return file.writeAsString(data);
  }

  Future<String> _readData() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch (ex) {
      return "";
    }
  }

  Widget buildItem(BuildContext context, int index) {
    return Dismissible(
      key: Key(DateTime.now().microsecondsSinceEpoch.toString()),
      onDismissed: (direction) {
        setState(() {
          _lastRemoved = Map.from(_todoList[index]);
          _lastRemovedPos = index;
          _todoList.removeAt(index);

          _saveData();

          final snack = SnackBar(
            content: Text("Tarefa ${_lastRemoved?["title"]} removida"),
            action: SnackBarAction(
              label: "Desfazer",
              onPressed: () {
                setState(() {
                  _todoList.insert(_lastRemovedPos, _lastRemoved);
                  _saveData();
                });
              },
            ),
            duration: const Duration(seconds: 3),
          );

          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(snack);
        });
      },
      background: Container(
        color: Colors.red,
        child: const Align(
          alignment: Alignment(-0.9, 0.0),
          child: Icon(Icons.delete, color: Colors.white),
        ),
      ),
      direction: DismissDirection.startToEnd,
      child: CheckboxListTile(
        title: Text(_todoList[index]["title"]),
        value: _todoList[index]["ok"],
        onChanged: (bool? value) {
          setState(() {
            _todoList[index]["ok"] = value;
            _saveData();
          });
        },
        secondary: CircleAvatar(
          child: Icon(_todoList[index]["ok"] ? Icons.check : Icons.error),
        ),
      ),
    );
  }
}
