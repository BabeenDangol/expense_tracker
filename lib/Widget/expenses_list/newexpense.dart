import 'package:expense_tracker/Models/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  NewExpense({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  //Controller to get the title value
  final _titleController = TextEditingController();

  //Controller to get the amount value'
  final _amountController = TextEditingController();

  DateTime? _selectedDate;
  Category _selectedCategory = Category.lesure;

  //Method to Store the date and time
  //using async and await to get the data that will arrive in future.
  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      //Store Picked Date in a Variable (_selectedDate).
      _selectedDate = pickedDate;
    });
  }

//Method for submitting the Expense.
  void _submidtFormData() {
    //Transforming the String not number if it is able to or returns null
    final enterAmount = double.tryParse(_amountController.text);

    //boolean variable if the entered amount is null it will be true
    final amountIsInvalid = enterAmount == null || enterAmount <= 0;

    //validating the Title Entered by user.
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Invalid input"),
          content: const Text(
              "Please make sure the title,amount ,date and category was entered."),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Okay"))
          ],
        ),
      );
      return;
    }
    //passing the Expense value to onAddExpense directly
    widget.onAddExpense(
      Expense(
          title: _titleController.text,
          amount: enterAmount,
          date: _selectedDate!,
          category: _selectedCategory),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    //to remove the controller when it is not needed
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            TextField(
              controller: _titleController,
              maxLength: 50,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.all(20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    width: 20,
                    color: Colors.black,
                  ),
                ),
                label: Text("Title"),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: _amountController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          width: 5,
                          color: Colors.black,
                        ),
                      ),
                      prefixText: "\$ ", //to always have a dollar sign.
                      label: Text("Amoount"),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        _selectedDate == null
                            ? 'No Date Seleced'
                            : formatter.format(_selectedDate!),
                      ),
                      //checking if the selected date is null and using turnary expression to display the message
                      //or use formatter to output formatted date.
                      IconButton(
                          onPressed: _presentDatePicker,
                          icon: const Icon(
                            Icons.calendar_month,
                          ))
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                //DropDown Button to select Category
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: DropdownButton(
                    value: _selectedCategory,
                    items: Category.values
                        .map(
                          //.map convert Enums value to Dropdown List value using Map
                          (category) => DropdownMenuItem(
                            //category function invoked for any category items.
                            value:
                                category, //Value that will be Stored Internally and provided to onchange function
                            child: Text(
                              category.name.toUpperCase(),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }
                      setState(() {
                        _selectedCategory = value;
                      });
                    },
                  ),
                ),
                const Spacer(),
                //Close Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Close"),
                ),
                //Save ExpenseButton
                const SizedBox(
                  width: 15,
                ),
                ElevatedButton(
                  onPressed: _submidtFormData,
                  child: const Text("Save Expense"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
