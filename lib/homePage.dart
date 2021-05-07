import 'package:flutter/material.dart';
import 'package:max_course/models/dailyTransaction.dart';
import 'package:max_course/models/sqliteDB.dart' as db;
import 'package:max_course/widgets/addTransaction.dart';
import 'package:max_course/widgets/chart.dart';
import 'package:max_course/widgets/transactionList.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List transList =[];
  TextEditingController titleController, priceController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    priceController = TextEditingController();
    db.getAllTransactions().then((value){ setState(() {
      transList = value;
    }); });
  }

  void addTransaction(DateTime selectedDate){
    try 
    {
        db.addTransaction( DailyTransaction(title: titleController.text, price: double.parse(priceController.text), dateTime: selectedDate) );
        db.getAllTransactions().then((value){
           setState(() {
             transList = value;
             Navigator.of(context).pop();
             titleController.clear();
             priceController.clear();
             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Transaction Added'),duration: Duration(seconds: 1),));
           });
         });
    }
    catch(e)
    {
      Navigator.of(context).pop();
      titleController.clear();
      priceController.clear();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid Input !'),duration: Duration(seconds: 1),));
    }
  }

  void deleteTransaction(int index) {
      showDialog(
        context: context,
        barrierDismissible: true, // user must not tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Delete Transaction'),
            content: Text('Are you sure you want to delete that transaction permanently?'),
            actions: <Widget>[
              TextButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Yes'),
                onPressed: () {
                  db.deleteTransaction(transList[index]['id']);
                  db.getAllTransactions().then((value) {
                    setState(() {
                      transList = value;
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Transaction Deleted'),duration: Duration(seconds: 1),));
                    });
                  });
                },
              ),
            ],
          );
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tansactions'),
        centerTitle: true,
        elevation: 5,
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: (){
                showDialog(
                  context: context,
                  barrierDismissible: true, // user must not tap button!
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('ADD TRANSACTION',textAlign: TextAlign.center,),
                      titleTextStyle: Theme.of(context).textTheme.bodyText1,
                      content:  AddTransaction(
                        titleController: titleController,
                        priceController: priceController,
                        addTransactionFunction: addTransaction,
                      ),
                    );
                  },
                );
                /*showModalBottomSheet(
                  context: context,
                  builder: (_){
                    return SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(bottom:MediaQuery.of(context).viewInsets.bottom,),
                        child: AddTransaction(titleController, priceController, addTransaction ),
                      ),
                    );
                  },
                );*/
              }
          ),
        ],
      ),
      body: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Chart(transList),
             Expanded(child: TransactionList(transList,deleteTransaction))
            ],
          )
      ),
    );
  }
}
