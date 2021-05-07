import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTransaction extends StatefulWidget {

  final TextEditingController titleController, priceController ;
  final Function addTransactionFunction;
    
  AddTransaction( {this.titleController , this.priceController , this.addTransactionFunction} );

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.4,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
         TextField(
           decoration: InputDecoration(
             labelText: 'Title',
             labelStyle: Theme.of(context).textTheme.headline6,
             enabledBorder: UnderlineInputBorder(
                 borderSide: BorderSide(width: 2,color: Colors.grey[700])
             ),
             focusedBorder: UnderlineInputBorder(
                 borderSide: BorderSide(width: 3,color: Colors.black)
             ),
           ),
           controller: widget.titleController ,
           style: Theme.of(context).textTheme.headline6,
         ),
         TextField(
            decoration: InputDecoration(
              labelText: 'Price',
              labelStyle: Theme.of(context).textTheme.headline6,
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 2,color: Colors.grey[700])
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 3,color: Colors.black)
              ),
            ),
            keyboardType: TextInputType.numberWithOptions(decimal: true,signed: false),
            controller: widget.priceController ,
            style: Theme.of(context).textTheme.headline6,
          ),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Text(
               'Selected Date : ${DateFormat.yMd().format(selectedDate)}',
               style: Theme.of(context).textTheme.subtitle2,
             ),

             IconButton(
               icon: Icon(
                 Icons.calendar_today,
                 color: Theme.of(context).accentColor,
               ),
               onPressed: () async{
                showDatePicker(
                     context: context,
                     initialDate: DateTime.now(),
                     firstDate: DateTime(2020,1),
                     lastDate: DateTime.now()
                 ).then((value){
                   try{ setState((){selectedDate =  DateTime.parse(value.toString());} ); }
                   catch(e){ setState((){selectedDate = DateTime.now();} ); }
                 });
               }
             ),
           ],
         ),
         TextButton(
            child: Text(
              'Add Transaction',
              style: Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.white),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Theme.of(context).accentColor),
              padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 20,vertical: 10))
            ),
            onPressed: (){ widget.addTransactionFunction(selectedDate); },
          ),
        ],
      ),
    );
  }
}
