import 'package:expense_tracker/Widget/chart/chart.dart';
import 'package:expense_tracker/Widget/expenses_list/newexpense.dart';
import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';
import 'Widget/expenses_list/expenses_list.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registerexpense = [
    Expense(
      title: "Course",
      amount: 99.99,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: "Cinema",
      amount: 17.99,
      date: DateTime.now(),
      category: Category.lesure,
    ),
    Expense(
      title: "Launch",
      amount: 80.99,
      date: DateTime.now(),
      category: Category.food,
    ),
  ]; //dummy expenses
  void _openAddExpenses() {
    // Method for adding expenses by user.
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => NewExpense(
        onAddExpense: _addExpense,
      ), //must provide a function as a value.
    );
  }

//Passing the Value to method indirectly.
  void _addExpense(Expense expense) {
    setState(() {
      _registerexpense.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    //get the position of the list
    final expenseIndex = _registerexpense.indexOf(expense);
    setState(() {
      _registerexpense.remove(expense);
    });
    //SnackBar used to bring back the deleted List
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 10),
        content: const Text("Expense Deleted"),
        action: SnackBarAction(
            label: "undo",
            onPressed: () {
              setState(() {
                _registerexpense.insert(expenseIndex, expense);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Display this message if nothing is added
    Widget mainContent = const Center(
      child: Text("No Expenses.Start adding Some"),
    );
    //Display this if Expense is added
    if (_registerexpense.isNotEmpty) {
      mainContent = ExpenseList(
          expenses: _registerexpense, onRemoveExpenses: _removeExpense);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "ExpenseTracker",
        ),
        actions: [
          IconButton(
            onPressed: _openAddExpenses,
            icon: const Icon(
              Icons.add,
            ),
            iconSize: 35,
          )
        ],
      ),
      //column to place widget above another widget
      body:
          //cart
          Column(
        children: [
          Chart(
            expenses: _registerexpense,
          ),
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}
