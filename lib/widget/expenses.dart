import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/widget/expense_list.dart';
import 'package:expense_tracker/widget/new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpensed = [
    Expense(
        title: 'Flutter course 1',
        amount: 55.2,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'Flutter course 2',
        amount: 4.2,
        date: DateTime.now(),
        category: Category.food),
    Expense(
        title: 'Flutter course 3',
        amount: 8.2,
        date: DateTime.now(),
        category: Category.leisure),
  ];

  void _openAddModal() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(
        onAddExpense: _addExpense,
      ),
    );
  }

  void _addExpense(Expense expense) {
    _registeredExpensed.add(expense);
  }

  void _removeExpense(Expense expense) {
    final expenseIndex=_registeredExpensed.indexOf(expense);
    setState(() {
      _registeredExpensed.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: Text('Expense deleted'),
        action: SnackBarAction(label: 'Undo', onPressed:(){setState(() {
          _registeredExpensed.insert(expenseIndex, expense);
        });},),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('No expenses found. Start adding some!'),
    );
    if (_registeredExpensed.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpensed,
        removeExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(onPressed: _openAddModal, icon: const Icon(Icons.add)),
      ], title: Text('Flutter Expense Tracker')),
      body: Column(
        children: [
          const Text('The  chart'),
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}
