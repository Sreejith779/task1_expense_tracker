import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:popover/popover.dart';
import 'package:task1_expense_tracker/models/addList.dart';

import 'package:task1_expense_tracker/models/expenseModelList.dart';
import 'package:task1_expense_tracker/screens/addTransaction.dart';

import '../models/dataModel.dart';
import '../models/expenseLimit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _limitController = TextEditingController();

  @override
  void dispose() {
    _limitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double totalAmount = calculateTotalAmount();
    double maxTarget =5000 ;
    double progress = totalAmount / maxTarget;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTransaction()),
          );
        },
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/lightblue.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.34,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 320, top: 25),
                    child: PopupMenuButton(
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem(
                            child: Column(
                          children: [
                            GestureDetector(
                              child: Text("Add Expense Limit"),
                              onTap: () {
                                Navigator.of(context).pop();
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: Text("Set Expense Limit"),
                                          content: Text(
                                              "set your expense limit here"),
                                          actions: [
                                            TextField(
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20))),
                                              controller: _limitController,
                                              keyboardType:
                                                  TextInputType.number,
                                            ),
                                            ElevatedButton(
                                                onPressed: () {
                                                  _applyLimit();
                                                  print(_limitController);
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text("Apply"))
                                          ],
                                        ));
                              },
                            )
                          ],
                        ))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 90, top: 40),
                    child: CircularPercentIndicator(
                      radius: 100,
                      lineWidth: 25,
                      progressColor: CupertinoColors.systemPurple,
                      fillColor: Colors.transparent,
                      backgroundColor: Colors.purple.shade100,
                      circularStrokeCap: CircularStrokeCap.round,
                      percent: progress,
                      addAutomaticKeepAlive: true,
                      center: Text(
                        "${(progress * 100).toStringAsFixed(2)}%",
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  // const SizedBox(height: 1),
                ],
              ),
            ),
            Text(
              "Total: ${totalAmount.toStringAsFixed(2)} Rs",
              style: const TextStyle(fontSize: 20),
            ),
            const Expanded(
              child: ExpenseList(),
            ),
          ],
        ),
      ),
    );
  }

  double calculateTotalAmount() {
    return expenseDataList
        .map((expense) => expense.amount)
        .fold(0, (a, b) => a + b);
  }

  void addLimit(ExpenseLimit setLimit) {
    setState(() {
      limit.add(setLimit);
    });
  }

  void _applyLimit() {
    final enteredAmount = double.tryParse(_limitController.text);
    final invalidAmount = enteredAmount == null || enteredAmount<=0;

    if(invalidAmount){
      showDialog(context: context,
        builder: (context)=>
          AlertDialog(
        title: const Text("Invalid Input"),
        content: const Text("Please make sure the fields are valid!"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Okay"),
          ),
        ],
      ),
      );
      return;
    }
    final setLimit = ExpenseLimit(
        limit: enteredAmount);

    addLimit(setLimit);
  }
}
