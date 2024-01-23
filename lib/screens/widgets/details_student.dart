import 'package:flutter/material.dart';
import 'package:sql/db/functions/db_functions.dart';
import 'package:sql/db/model/data_model.dart';
import 'package:sql/screens/widgets/list_student.dart';

class ScreenDetails extends StatelessWidget {
  final StudentModel student;
  const ScreenDetails({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.deepPurpleAccent,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[600],
        title: Text(student.name),
      ),
      body: SafeArea(
          child: Card(
        margin:
            const EdgeInsets.only(bottom: 120, top: 50, left: 50, right: 50),
        color: Colors.white60,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25))),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Card(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: IconButton(
                        tooltip: 'Edit',
                        onPressed: () {
                          updater(context, student);
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.black,
                        )),
                  ),
                  Card(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: IconButton(
                        tooltip: 'Delete',
                        onPressed: () async {
                          await deleteRow(context, student.admno);
                          //Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 250,
              width: 250,
              child: Image(
                image: imageProcessor(student.image64bit),
                fit: BoxFit.scaleDown,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Admission no: ${student.admno}',
            ),
            const SizedBox(
              height: 16,
            ),
            Text('Name: ${student.name}'),
            const SizedBox(
              height: 16,
            ),
            Text('Age: ${student.age}'),
            const SizedBox(
              height: 16,
            ),
            Text('Class: ${student.classInSchool}'),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      )),
    );
  }
}
