import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sql/db/functions/db_functions.dart';
import 'package:sql/provider/db_list_provider.dart';
import 'package:sql/provider/home_list_view_provider.dart';
import 'package:sql/screens/screen_home.dart';

void main() async {
  if (Platform.isWindows || Platform.isLinux) {
    // Initialize FFI
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  WidgetsFlutterBinding.ensureInitialized();
  await initializeDataBase();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeListViewProvider()),
        ChangeNotifierProvider(create: (context) => StudentProvider())
      ],
      child: const MyApp(),
    ),
  );
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
