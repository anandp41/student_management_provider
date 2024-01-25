import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sql/db/model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:sql/provider/db_list_provider.dart';
import 'dart:io' as io;

//ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

late Database _db;

Future<void> initializeDataBase() async {
  io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String path = join(documentsDirectory.path, 'student.db');
  _db = await openDatabase(
    path,
    version: 1,
    onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE student (admno TEXT PRIMARY KEY,name TEXT,age TEXT,class TEXT,image TEXT)');
    },
  );
}

//Alter table function definition
Future<dynamic> alterTable(String tableName, String columnName) async {
  var dbClient = _db;
  var count = await dbClient
      .execute("ALTER TABLE $tableName ADD COLUMN $columnName TEXT;");

  await dbClient.query('student');

  return count;
}
// Future<void> makeDB() async {
//   _db.execute(
//       'CREATE TABLE student (admno TEXT PRIMARY KEY,name TEXT,age TEXT,class TEXT)');
// }

Future<void> addStudent(StudentModel value) async {
  _db.rawInsert(
      'INSERT INTO student (admno,name,age,class,image) VALUES (?,?,?,?,?)', [
    value.admno,
    value.name.toUpperCase(),
    value.age,
    value.classInSchool,
    value.image64bit
  ]);

  // studentListNotifier.value.add(value);
}

Future<List<Map<String, Object?>>> readDB() async {
  final _values = await _db.rawQuery('SELECT * FROM student');

  // studentListNotifier.value.clear();
  // studentListNotifier.notifyListeners();
  // for (var map in _values) {
  //   final student = StudentModel.fromMap(map);
  //   studentListNotifier.value.add(student);
  //   studentListNotifier.notifyListeners();
  // }
  return _values;
}

Future<StudentModel> getThisStudent(String admno) async {
  StudentModel? student;
  final result =
      await _db.rawQuery('SELECT * FROM student WHERE admno=?', [admno]);
  for (var map in result) {
    student = StudentModel.fromMap(map);
  }
  return student!;
}
// Future<void> dropTable() async {
//   // Run the DROP TABLE statement
//   await _db.execute('DROP TABLE IF EXISTS student');
// }

Future<void> deleteRow(BuildContext catx, String admno) async {
  return showDialog(
      context: catx,
      builder: (ctx1) {
        return AlertDialog(
            title: const Text('Delete'),
            content: const Text("Are you sure to delete?"),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      Navigator.pop(ctx1);
                      Navigator.pop(catx);
                      await _db.rawDelete(
                          'DELETE from student where admno=?', [admno]);
                      await Provider.of<StudentProvider>(catx, listen: false)
                          .getAllStudents();
                    },
                    icon: const Icon(
                      Icons.check,
                    ),
                    label: const Text('Yes'),
                  ),
                  ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(catx);
                      },
                      icon: const Icon(Icons.cancel),
                      label: const Text('No'))
                ],
              ),
            ]);
      });
}

Future<void> updateField(
    {required String admno,
    required String name,
    required String age,
    required String classInSchool,
    required String? image64bit}) async {
  await _db.rawUpdate(
      'UPDATE student SET name=?,age=?,class=?,image=? WHERE admno=$admno',
      [name.toUpperCase(), age, classInSchool, image64bit]);
}

Future<dynamic> pickImage() async {
  var image = await ImagePicker()
      .pickImage(source: ImageSource.gallery, imageQuality: 45);

  if (image != null) {
    var imageBytes = await image.readAsBytes();

    String base64Image = base64Encode(imageBytes);

    return base64Image;
  }
}
