import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technical_test_waizly_mobile/providers/todo_provider.dart';
import 'package:technical_test_waizly_mobile/screens/home_screen.dart';
import 'package:technical_test_waizly_mobile/screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

  runApp(
    ChangeNotifierProvider<TodoProvider>(
      create: (_) => TodoProvider(),
      child: MainApp(isFirstTime: isFirstTime),
    ),
  );
}

class MainApp extends StatelessWidget {
  final bool isFirstTime;

  MainApp({required this.isFirstTime});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: isFirstTime ? WelcomeScreen() : HomeScreen(),
    );
  }
}
