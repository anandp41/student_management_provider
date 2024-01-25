import 'package:sql/screens/widgets/add_student.dart';
import 'package:sql/screens/widgets/custom_search_delegate.dart';
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
