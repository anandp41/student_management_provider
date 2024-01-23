import 'dart:io';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sql/db/functions/db_functions.dart';
import 'package:sql/screens/screen_home.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  if (Platform.isWindows || Platform.isLinux) {
    // Initialize FFI
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDataBase();
  // makeDB();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ScreenHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}
