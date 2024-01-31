import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

enum Categories{Food,Travel,Leisure,Work}

const categoryIcons = {
  Categories.Food: Icons.fastfood,
  Categories.Travel: Icons.train_sharp,
  Categories.Work:Icons.work,
  Categories.Leisure:Icons.shopping_bag_outlined
};
class ExpenseData{
  final String title;
  final double amount;
  final DateTime dateTime;
  final Categories category;

  String get formattedDate{
    return formatter.format(dateTime);
}

  ExpenseData({required this.title, required this.amount, required this.dateTime, required this.category});

}

List<ExpenseData>expenseDataList=[
  ExpenseData(title: "Exam Fees", amount: 15.26, dateTime: DateTime.now(), category: Categories.Food),
  ExpenseData(title: "Grocery", amount: 15.26, dateTime: DateTime.now(), category: Categories.Travel),
  ExpenseData(title: "Medicine", amount: 15.26, dateTime: DateTime.now(), category: Categories.Leisure),];