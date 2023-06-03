import 'package:expense_tracker/Models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});
  final Expense expense; //Got the whole value from the Expense List

  @override
  Widget build(BuildContext context) {
    //Retrive the Value from the ExpenseList class and Render the List Value to Screen.
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text(
                  '\$${expense.amount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green[200],
                  ),
                ), //Converts the value like 12.3433 =>12.34.
                const Spacer(), //Helps the Widget get the space it needs to display the data.
                Row(
                  children: [
                    Icon(categoryIcon[expense.category], color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(
                      expense.formattedDate,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
