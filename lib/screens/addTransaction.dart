



import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task1_expense_tracker/models/dataModel.dart';

final formatter = DateFormat.yMd();

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

   Categories _selectedCategory = Categories.Travel;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/lightblue.jpg"), fit: BoxFit.fill)),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          height: MediaQuery.of(context).size.height * 0.5,
          margin: const EdgeInsets.only(left: 20, right: 20, top: 100),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Add new expense",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                const Text(
                    "Enter the details of your expense to help you track your spending"),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                      label: const Text("title"),
                      fillColor: Colors.cyan,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16))),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      label: const Text("Amount"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16))),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    _selectedDate();
                  },
                  child:  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DropdownButton(
                        value: _selectedCategory,
                        items: Categories.values.map((category) {
                          return DropdownMenuItem(
                            value: category,
                            child: Text(category.name.toString()),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if(value==null){
                            return;
                          }
                      setState(() {
                        _selectedCategory =value;
                      });
                        },
                        hint: const Center(child: Text("Category")),
                      ),
                      Row(
                        children: [
                          Text(_datePicked ==null ? "Select Date":formatter.format(_datePicked!) ),
                          const Icon(Icons.calendar_month_outlined) ],
                      ),

                    ],
                  ),
                ),


                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    ElevatedButton(onPressed: () {}, child: const Text("Cancel")),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          _submitValidating();
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Added Sucessfully")));
                          print(_titleController.text);
                          print(_amountController.text);
                        },
                        child: const Text("Submit"))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  DateTime? _datePicked;
  void _selectedDate() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 2, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context, firstDate: firstDate, lastDate: now);

    setState(() {
      _datePicked = pickedDate;
    });

  }

//   void _submitValidating(){
//
//     final enteredAmount = double.tryParse(_amountController.text);
//     final invalidAmount = enteredAmount==null || enteredAmount <=0;
//     if(_titleController.text.trim().isEmpty|| invalidAmount || _datePicked==null)
//     {
// showDialog(context: context, builder: (ctx)=>AlertDialog(
//   title: const Text("Invalid Input"),
//   content: const Text("Please make sure the fields are valid!"),
//   actions: [
//     TextButton(onPressed: (){
//       Navigator.pop(context);
//     }, child: const Text("Okay"))
//   ],
// ));
//     }
//   }
  void _submitValidating() {
    final enteredTitle = _titleController.text.trim();
    final enteredAmount = double.tryParse(_amountController.text);
    final invalidAmount = enteredAmount == null || enteredAmount <= 0;

    if (enteredTitle.isEmpty || invalidAmount || _datePicked == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
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

    final expenseData = ExpenseData(
      title: enteredTitle,
      amount: enteredAmount,
     dateTime: _datePicked!,
      category: _selectedCategory,
    );

    addExpense(expenseData);

    Navigator.pop(context);
  }

void addExpense(ExpenseData expenseData){
    setState(() {
      expenseDataList.add(expenseData);
    });

}

void removeExpense(ExpenseData removeData){
    setState(() {
      expenseDataList.remove(removeData);
    });
}
}

