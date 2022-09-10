import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/models/todo.dart';

class TodoListItem extends StatelessWidget {
  TodoListItem({
    Key? key,
    required this.todo,
    required this.onDelete,
  }) : super(key: key);

  final Todo todo;
  final Function(Todo) onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Slidable(
        key: UniqueKey(),
        startActionPane: ActionPane(

          dragDismissible: false,
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(onDismissed: () {}),

          children: [
            SlidableAction(
              onPressed: (context) {
                 onDelete(todo);
               },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            )
          ],
        ),
        child: Container(
          width: 500,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.horizontal(
                left: Radius.zero, right: Radius.circular(10)),
            color: Colors.grey[200],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                todo.title.toUpperCase(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                DateFormat('dd/MM/yyyy').format(todo.date),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
