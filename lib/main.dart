import 'package:flutter/material.dart';
import 'package:tests_study/features/home/home_page.dart';
import 'package:tests_study/repositories/advice/advice_repository_impl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(adviceRepository: AdviceRepositoryImpl()),
    );
  }
}
