import 'package:flutter/material.dart';
import 'package:lion_project_09/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeView(),
    );
  }
}


/// Native (nativ, netiv)
/// Android -> Java, Kotlin
/// iOS -> Swift, objective C
/// native features
/// flutter plugin