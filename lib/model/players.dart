import 'dart:collection';

import 'package:flutter/material.dart';

class Players extends ChangeNotifier {
  final List<String> _names = [];

  int get length => _names.length;
  bool get isEmpty => _names.isEmpty;
  List<String> get asList => UnmodifiableListView(_names);

  void add(String player) {
    _names.add(player);
    notifyListeners();
  }

  String get(int index) {
    return _names[index];
  }

  void removeAt(int index) {
    _names.removeAt(index);
    notifyListeners();
  }
}
