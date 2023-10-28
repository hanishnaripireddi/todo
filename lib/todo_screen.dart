import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/todo_item.dart';

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({Key? key}) : super(key: key);

  @override
  _ToDoListPageState createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ToDoListModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('To Do List'),
          ),
          body: ListView.builder(
            itemCount: model.toDoItems.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(
                  model.toDoItems[index].isComplete ? Icons.check_circle : Icons.circle_outlined,
                  color: model.toDoItems[index].isComplete ? Colors.green : Colors.grey,
                ),
                title: Text(model.toDoItems[index].title),
                subtitle: Text(model.toDoItems[index].description),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    model.deleteToDoItem(index);
                  },
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _showDialog(context);
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  void _showDialog(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New To-Do Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: 'Title',
                ),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  hintText: 'Description',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Provider.of<ToDoListModel>(context, listen: false).addToDoItem(titleController.text, descriptionController.text);
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      });

  }
}