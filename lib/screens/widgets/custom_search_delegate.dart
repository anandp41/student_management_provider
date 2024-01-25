import 'package:flutter/material.dart';
import 'package:sql/db/functions/db_functions.dart';
import 'package:sql/db/model/data_model.dart';
import 'package:sql/screens/widgets/details_student.dart';
import 'package:sql/screens/widgets/list_student.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
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
