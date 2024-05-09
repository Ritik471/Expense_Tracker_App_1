import 'package:expense_tracker/Authentication/signup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './models/database_provider.dart';
// screens
import './screens/category_screen.dart';
import './screens/expense_screen.dart';
import './screens/all_expenses.dart';
import './Authentication/login.dart'; // Importing the login screen

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => DatabaseProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),  
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.name, // Change the initial route to LoginScreen
      routes: {
        CategoryScreen.name: (_) => CategoryScreen(),
        ExpenseScreen.name: (_) => const ExpenseScreen(),
        AllExpenses.name: (_) => const AllExpenses(),
        LoginScreen.name: (_) => LoginScreen(), // Add LoginScreen route
        SignUp.name: (_) => LoginScreen(), // Route SignUp to LoginScreen
      },
    );
  }
}
