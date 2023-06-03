import 'package:expense_tracker/expenses.dart';
import 'package:flutter/material.dart';

var kScaffoldScheme = ColorScheme.fromSeed(
  seedColor: Color.fromARGB(255, 204, 191, 234),
);
var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);
var kCardScheme = ColorScheme.fromSeed(
  seedColor: Color.fromARGB(255, 28, 28, 56),
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorScheme,
        appBarTheme: AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kCardScheme.onPrimaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 20,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.primaryContainer),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                color: kColorScheme.onSecondaryContainer,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
      ),

      //redirect to Expense Class
      home: Expenses(),
    );
  }
}
