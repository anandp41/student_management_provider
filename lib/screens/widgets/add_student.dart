import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sql/db/functions/db_functions.dart';
import 'package:sql/db/model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:sql/provider/db_list_provider.dart';

String? byte64String;

class AddStudentWidget extends StatelessWidget {
  AddStudentWidget({super.key});
  final _admnoController = TextEditingController();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _classController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Card(
      color: Colors.white60,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25))),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          // autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                keyboardType: TextInputType.number,
                controller: _admnoController,
                validator: (value) {
                  RegExp regx = RegExp(r'^[0-9]{4}');
                  if (!regx.hasMatch(value as String) || value == '0000') {
                    return 'Enter a valid 4-digit admission number';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Admission number'),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                keyboardType: TextInputType.name,
                controller: _nameController,
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), hintText: 'Name'),
                validator: (value) {
                  RegExp regx = RegExp(r'^[A-Za-z]*(\s+[A-Za-z]*)*$');
                  if (!regx.hasMatch(value as String)) {
                    return 'Enter a name without any special characters or numbers';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                keyboardType: TextInputType.number,
                controller: _ageController,
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), hintText: 'Age'),
                validator: (value) {
                  RegExp regx = RegExp(r'^([5-9]|1[0-9])$');
                  if (!regx.hasMatch(value as String)) {
                    return 'Enter valid age';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                keyboardType: TextInputType.number,
                controller: _classController,
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Class of the student'),
                validator: (value) {
                  RegExp regx = RegExp(r'^([1-9]|1[0-2])$');
                  if (!regx.hasMatch(value as String)) {
                    return 'Enter a class between 1 and 12';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                ElevatedButton.icon(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.green),
                        foregroundColor:
                            MaterialStatePropertyAll(Colors.black87)),
                    onPressed: () async {
                      byte64String = await pickImage();
                    },
                    icon: const Icon(
                      Icons.image,
                    ),
                    label: const Text('Add image')),
                const SizedBox(
                  height: 8,
                ),
                ElevatedButton.icon(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        await onAddStudentButtonClicked();
                        await Provider.of<StudentProvider>(context,
                                listen: false)
                            .getAllStudents();
                      }
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Add Student')),
                // const SizedBox(
                //   width: 50,
                // ),
                // ElevatedButton.icon(
                //     onPressed: () {
                //       dropTable();
                //     },
                //     icon: Icon(Icons.remove_circle_outline_rounded),
                //     label: Text('Drop Table'))
              ])
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onAddStudentButtonClicked() async {
    final _admno = _admnoController.text.trim();
    final _name = _nameController.text.trim();
    final _age = _ageController.text.trim();
    final _classInSchool = _classController.text.trim();
    final _image = byte64String ?? 'empty';
    if (_admno.isEmpty ||
        _name.isEmpty ||
        _age.isEmpty ||
        _classInSchool.isEmpty) {
      return;
    }

    final _student = StudentModel(
        admno: _admno,
        name: _name,
        age: _age,
        classInSchool: _classInSchool,
        image64bit: _image);
    await addStudent(_student);
    _admnoController.clear();
    _nameController.clear();
    _classController.clear();
    _ageController.clear();
  }
}
