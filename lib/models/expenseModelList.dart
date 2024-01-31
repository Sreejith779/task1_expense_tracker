import 'package:flutter/material.dart';
import 'package:task1_expense_tracker/models/color.dart';
import 'package:task1_expense_tracker/models/dataModel.dart';

class ExpenseList extends StatefulWidget {
  const ExpenseList({Key? key}) : super(key: key);

  @override
  State<ExpenseList> createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryElementText,
        borderRadius: BorderRadius.circular(35),
      ),
      child: ListView.builder(
        itemCount: expenseDataList.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: ValueKey(expenseDataList[index]),
            onDismissed: (direction) {
              removeData(expenseDataList[index]);
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Delete Expense'),
                    content: const Text("Are you sure you want to delete this expense?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          removeData(expenseDataList[index]);
                          Navigator.of(context).pop();
                        },
                        child: const Text("Delete"),
                      )
                    ],
                  );
                },
              ).then((result) {
                if (result != null && result) {
                  // The user pressed "Delete," so you can remove the expense.
                  removeData(expenseDataList[index]);
                }
              });
            },
            child: Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
              height: MediaQuery.of(context).size.height * 0.12,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: AppColors.primaryElementText,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.09,
                      width: MediaQuery.of(context).size.width * 0.2,
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Icon(
                        categoryIcons[expenseDataList[index].category],
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Center(
                              child: Text(
                                expenseDataList[index].title,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            Text(
                              "${expenseDataList[index].amount}rs",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey.shade700,
                              ),
                            )
                          ],
                        ),
                        Text(
                          expenseDataList[index].formattedDate,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void removeData(ExpenseData removeData) {
    setState(() {
      expenseDataList.remove(removeData);
    });
  }
}
