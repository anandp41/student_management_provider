import 'package:flutter/material.dart';
import 'package:sql/db/functions/db_functions.dart';
import 'package:sql/db/model/data_model.dart';

class StudentProvider with ChangeNotifier {
  final List<StudentModel> _studentList = [];

  List<StudentModel> get studentList => _studentList;
  // List<Map<String, Object?>> dataListMap = [];
  Future<void> getAllStudents() async {
    var _readDb = await readDB();
    _studentList.clear();
    notifyListeners();
    for (int i = 0; i < _readDb.length; i++) {
      Map<String, Object?> map = _readDb[i];
      final student = StudentModel.fromMap(map);
      _studentList.add(student);
      notifyListeners();
    }
  }
}
