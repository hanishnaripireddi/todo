import 'package:flutter/material.dart';

class ToDoItem {
  String title;
  String description;
  bool isComplete;

  ToDoItem(this.title, {this.description = '', this.isComplete = false});
}

class ToDoListModel extends ChangeNotifier {
  List<ToDoItem> toDoItems = [];

  void addToDoItem(String title, String description) {
    toDoItems.add(ToDoItem(title, description: description));
    notifyListeners();
  }

  void markToDoItemComplete(int index) {
    toDoItems[index].isComplete = true;
    notifyListeners();
  }

  void deleteToDoItem(int index) {
    toDoItems.removeAt(index);
    notifyListeners();
  }
}

