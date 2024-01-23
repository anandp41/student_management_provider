import 'dart:convert';

import 'package:sql/db/functions/db_functions.dart';
import 'package:sql/db/model/data_model.dart';
import 'package:flutter/material.dart';
// import 'package:sql/screens/screen_home.dart';
import 'package:sql/screens/widgets/details_student.dart';

List<Map<String, Object?>> dataListMap = [];

ImageProvider imageProcessor(image) {
  final ImageProvider newImage;
  newImage = (image != 'empty'
      ? MemoryImage(const Base64Decoder().convert(image!))
      : const AssetImage('assets/images/def.png')) as ImageProvider;
  return newImage;
}

class ListStudentWidget extends StatelessWidget {
  final bool isListOn;
  const ListStudentWidget({super.key, required this.isListOn});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: studentListNotifier,
      builder:
          (BuildContext ctx, List<StudentModel> studentList, Widget? child) {
        dataListMap.clear();
        if (isListOn) {
          return ListView.separated(
              itemBuilder: (ctx, index) {
                final data = studentList[index];
                dataListMap.add({'name': data.name, 'admno': data.admno});
                return Card(
                  color: Colors.blueGrey,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: ListTile(
                    onTap: () async {
                      StudentModel student = await getThisStudent(data.admno);
                      Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                        return ScreenDetails(student: student);
                      }));
                    },
                    leading: CircleAvatar(
                      backgroundImage: imageProcessor(data.image64bit),
                    ),
                    title: Text(
                      'Name: ${data.name}',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                    // subtitle: Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Row(
                    //       children: [
                    //         Text(
                    //           'Name: ${data.name}',
                    //           style: const TextStyle(
                    //               color: Colors.black,
                    //               fontSize: 16,
                    //               fontWeight: FontWeight.w700),
                    //         )
                    //       ],
                    //     ),
                    //     Row(
                    //       children: [
                    //         Card(
                    //           shape: const RoundedRectangleBorder(
                    //               borderRadius:
                    //                   BorderRadius.all(Radius.circular(25))),
                    //           child: IconButton(
                    //               tooltip: 'Edit',
                    //               onPressed: () {
                    //                 updater(context, data);
                    //               },
                    //               icon: const Icon(
                    //                 Icons.edit,
                    //                 color: Colors.black,
                    //               )),
                    //         ),
                    //         const SizedBox(
                    //           width: 10,
                    //         ),
                    //         Card(
                    //           shape: const RoundedRectangleBorder(
                    //               borderRadius:
                    //                   BorderRadius.all(Radius.circular(25))),
                    //           child: IconButton(
                    //               tooltip: 'Delete',
                    //               onPressed: () {
                    //                 deleteRow(ctx, data.admno);
                    //               },
                    //               icon: const Icon(
                    //                 Icons.delete,
                    //                 color: Colors.red,
                    //               )),
                    //         )
                    //       ],
                    //     )
                    //   ],
                    // ),
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return const Divider(
                  color: Colors.red,
                );
              },
              itemCount: studentList.length);
        } else {
          return GridView.builder(
              itemCount: studentList.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 165,
                  mainAxisExtent: 211,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10),
              itemBuilder: (ctx, index) {
                final data = studentList[index];
                return InkResponse(
                  onTap: () async {
                    StudentModel student = await getThisStudent(data.admno);
                    Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                      return ScreenDetails(student: student);
                    }));
                  },
                  child: Card(
                    color: Colors.blueGrey,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: GridTile(
                      child: SizedBox(
                        width: 50,
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 100,
                              // width: 100,
                              child: Image(
                                image: imageProcessor(data.image64bit),
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 12.0),
                                      child: Expanded(
                                        child: Text(
                                          'Name: ${data.name}',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 13,
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(right: 10.0),
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.end,
                            //     children: [
                            //       Card(
                            //         shape: const RoundedRectangleBorder(
                            //             borderRadius: BorderRadius.all(
                            //                 Radius.circular(25))),
                            //         child: IconButton(
                            //             tooltip: 'Edit',
                            //             onPressed: () {
                            //               updater(context, data);
                            //             },
                            //             icon: const Icon(
                            //               Icons.edit,
                            //               color: Colors.black,
                            //             )),
                            //       ),
                            //       const SizedBox(
                            //         width: 5,
                            //       ),
                            //       Card(
                            //         shape: const RoundedRectangleBorder(
                            //             borderRadius: BorderRadius.all(
                            //                 Radius.circular(25))),
                            //         child: IconButton(
                            //             tooltip: 'Delete',
                            //             onPressed: () {
                            //               deleteRow(ctx, data.admno);
                            //             },
                            //             icon: const Icon(
                            //               Icons.delete,
                            //               color: Colors.red,
                            //             )),
                            //       ),
                            //     ],
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        }
      },
    );
  }
}

void updater(BuildContext context, StudentModel data) {
  final formKey = GlobalKey<FormState>();
  final _newNameController = TextEditingController(text: data.name);
  final _newAgeController = TextEditingController(text: data.age);
  final _newClassController = TextEditingController(text: data.classInSchool);
  dynamic byte64String = data.image64bit;
  showModalBottomSheet(
    context: context,
    builder: (BuildContext ctx) {
      return SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const Text('Name:'),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: TextFormField(
                        controller: _newNameController,
                        validator: (value) {
                          RegExp regx = RegExp(r'^[A-Za-z]*(\s+[A-Za-z]*)*$');
                          if (!regx.hasMatch(value as String)) {
                            return 'Enter a name without any special characters or numbers';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    const Text('Age:'),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: TextFormField(
                        controller: _newAgeController,
                        validator: (value) {
                          RegExp regx = RegExp(r'^([5-9]|1[0-9])$');
                          if (!regx.hasMatch(value as String)) {
                            return 'Enter valid age';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                // Start of the second row
                Row(
                  children: [
                    const Text('Adm No:'),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: TextFormField(
                        initialValue: data.admno,
                        readOnly: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    const Text('Class:'),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: TextFormField(
                        controller: _newClassController,
                        validator: (value) {
                          RegExp regx = RegExp(r'^([1-9]|1[0-2])$');
                          if (!regx.hasMatch(value as String)) {
                            return 'Enter a class between 1 and 12';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.green),
                            foregroundColor:
                                MaterialStatePropertyAll(Colors.black87)),
                        onPressed: () async {
                          byte64String = (await pickImage()) ?? byte64String;
                        },
                        icon: const Icon(Icons.image),
                        label: const Text('Choose another image')),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            updateField(
                                admno: data.admno,
                                name: _newNameController.text.trim(),
                                age: _newAgeController.text.trim(),
                                classInSchool: _newClassController.text.trim(),
                                image64bit: byte64String);
                            getAllStudents();
                            Navigator.pop(ctx);
                            Navigator.pop(context);

                            StudentModel student =
                                await getThisStudent(data.admno);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (ctx) {
                              return ScreenDetails(student: student);
                            }));

                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    showCloseIcon: true,
                                    closeIconColor: Colors.blue,
                                    backgroundColor: Colors.greenAccent,
                                    content: Text("Student Updated")));
                          }
                        },
                        icon: Icon(
                          Icons.update_rounded,
                          color: Colors.purple[700],
                        ),
                        label: const Text('Update')),
                    ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(ctx);
                        },
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.red,
                        ),
                        label: const Text('Cancel'))
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
