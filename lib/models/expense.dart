import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
final formatter=DateFormat.yMd();
const uuid=Uuid();
enum Category {food,travel,leisure,work}
const cateforyIcons={
  Category.food:Icons.lunch_dining,
  Category.travel:Icons.flight_takeoff,
  Category.leisure:Icons.movie,
  Category.work:Icons.work
};
class Expense{
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category

}):id=uuid.v4();
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

String  get FormattedDate
  {
    return formatter.format(date);
  }
}
class ExpenseBucket{
  const ExpenseBucket(this.expenses, {
    required this.category,
});
  ExpenseBucket.forCategory(List<Expense> allExpenses,this.category):expenses=allExpenses.where((element) => false);
  
  final Category category;
  final List<Expense> expenses;
  double get totalExpense{
    double sum=0;
    for(final expens in expenses)
      {
        sum=sum+expens.amount;
      }
      return sum;
  }
  
 


}