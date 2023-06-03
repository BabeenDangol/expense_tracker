//Created to know data model or structure for expenses
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd(); //Constructor Function

const uuid = Uuid();

enum Category {
  //combnation allowed values
  food,
  travel,
  lesure,
  work,
}

const categoryIcon = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.lesure: Icons.movie,
  Category.work: Icons.work,
}; //custome icons of each category

class Expense {
  //Data Group
  final String id; //Unique id to identify Certain ID
  final String title;
  final double amount;
  final DateTime date;
  final Category
      category; //created to allow fixed set of values to redues the typo errors

  //Constructors Function based on above blue print with named Parameter
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  String get formattedDate {
    //getter method for formmated dates with third party package INTL
    return formatter.format(date);
  }
}
