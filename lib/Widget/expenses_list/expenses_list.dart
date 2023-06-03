import 'package:expense_tracker/Models/expense.dart';
import 'package:expense_tracker/Widget/expenses_list/expense_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Created to Output the lists
class ExpenseList extends StatelessWidget {
  ExpenseList(
      {super.key, required this.expenses, required this.onRemoveExpenses});

  final List<Expense> expenses; //Importing the list created in Expenses Claass
  final void Function(Expense Expense) onRemoveExpenses;
  @override
  Widget build(BuildContext context) {
    //List View is Created Because the length of the Exse List could be unknown and
    //Create list only if they are visible and about to be visible.
    return ListView.builder(
      itemCount: expenses.length, //defines how many list items renders
      itemBuilder: (context, index) => Dismissible(
        background: Card(
          color: Colors.red,
          margin: EdgeInsets.symmetric(vertical: 10),
          borderOnForeground: Paint.enableDithering,
        ),
        key: ValueKey(
          expenses[index],
        ),
        onDismissed: (direction) {
          onRemoveExpenses(
            expenses[index],
          );
        }, //key to delete the right data.
        child: ExpenseItem(
          expenses[index], //Passed the value of List in Expense Item
        ),
      ),
    );
  }
}
