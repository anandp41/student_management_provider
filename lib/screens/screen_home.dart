import 'package:sql/db/functions/db_functions.dart';
import 'package:sql/db/model/data_model.dart';
import 'package:sql/screens/widgets/add_student.dart';
import 'package:sql/screens/widgets/details_student.dart';
import 'package:sql/screens/widgets/list_student.dart';
import 'package:flutter/material.dart';

bool isListOn = true;

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  Widget build(BuildContext context) {
    // getAllStudents();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.deepPurpleAccent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Admin',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    showSearch(
                        context: context, delegate: CustomSearchDelegate());
                  },
                  icon: const Icon(Icons.search)),
              IconButton(
                icon:
                    Icon(isListOn == true ? Icons.view_list : Icons.grid_view),
                onPressed: () {
                  isListOn = !isListOn;
                  setState(() {});
                },
              )
            ],
          ),
        ],
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 8.0, bottom: 8, left: 20, right: 20),
            child: AddStudentWidget(),
          ),
          const Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25))),
            child: Divider(
              color: Colors.lightBlueAccent,
              thickness: 10,
              height: 10,
              indent: 30,
              endIndent: 30,
            ),
          ),
          Expanded(
              child: Padding(
            padding:
                const EdgeInsets.only(top: 8.0, bottom: 8, left: 20, right: 20),
            child: Card(
                color: Colors.white60,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListStudentWidget(isListOn: isListOn),
                )),
          ))
        ],
      )),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) => Center(
        child: Text(
          query,
          style: const TextStyle(fontSize: 64, fontWeight: FontWeight.w700),
        ),
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Map<String, Object?>> matchedDataMap = [];
    for (Map<String, Object?> matchedWord in dataListMap) {
      if ((matchedWord['name']! as String)
          .toLowerCase()
          .contains(query.toLowerCase())) {
        //matchQuery.add(matchedWord['name'] as String);
        matchedDataMap.add(matchedWord);
      }
    }

    return ListView.builder(
        itemCount: matchedDataMap.length,
        itemBuilder: (context, index) {
          var result = matchedDataMap[index];
          return ListTile(
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  result['name'] as String,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: IconButton(
                          tooltip: 'Edit',
                          onPressed: () async {
                            StudentModel student =
                                await getThisStudent(result['admno'] as String);
                            updater(context, student);
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.black,
                          )),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: IconButton(
                          tooltip: 'Delete',
                          onPressed: () {
                            deleteRow(context, result['admno'] as String);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
                    ),
                  ],
                ),
              ],
            ),
            onTap: () async {
              query = result['name'] as String;

              StudentModel student =
                  await getThisStudent(result['admno'] as String);
              Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                return ScreenDetails(student: student);
              }));
            },
          );
        });
  }
}
