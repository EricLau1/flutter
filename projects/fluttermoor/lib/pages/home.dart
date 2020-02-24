import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../data/database.dart';
import '../widgets/new_task_input_widget.dart';

class HomePage extends StatefulWidget {
  @override 
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarefas'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: _buildTasks(context)),
          NewTaskInput(),
        ],
      ),
    );
  }
}

StreamBuilder<List<Task>> _buildTasks(BuildContext context) {
  final database = Provider.of<AppDatabase>(context);
  return StreamBuilder(
    stream: database.watchTasks(),
    builder: (context, AsyncSnapshot<List<Task>> snapshot) {
      final tasks = snapshot.data ?? List();

      return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (_, index) {
          final itemTask = tasks[index];
          return _buildListItem(itemTask, database);
        },
      ); 
    },
  );
}

Widget _buildListItem(Task task, AppDatabase database) {
  return Slidable(
    actionPane: SlidableDrawerActionPane(),
    secondaryActions: <Widget>[
      IconSlideAction(
        caption: 'Delete',
        color: Colors.red,
        icon: Icons.delete,
        onTap: () => database.deleteTask(task),
      ),
    ],
    child: CheckboxListTile(
      title: Text(task.name),
      subtitle: Text(task.dueDate?.toString() ?? 'No date'),
      value: task.completed,
      onChanged: (newValue) {
        database.updateTask(task.copyWith(completed: newValue));
      },
    ),
  );
}