import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class TransactionList extends StatelessWidget {

  final List txList;
  final Function deleteFunc;
  TransactionList(this.txList,this.deleteFunc);

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.all(8),
      child: txList.isEmpty ?
      Image.asset('assets/images/empty.png', height: double.infinity, width: double.infinity, fit: BoxFit.fitHeight,)
          :
      ListView.builder(
        itemCount: txList.length,
        itemBuilder: (context,index){
          return GestureDetector(
            onLongPress: (){ deleteFunc(index); },
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                margin: EdgeInsets.only(bottom:MediaQuery.of(context).size.width*0.04),
                child: Padding(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.04),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          width:width*0.25,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 2.5
                            ),
                            borderRadius: BorderRadius.circular(20)
                          ),
                          padding: EdgeInsets.symmetric(vertical:width*0.03,horizontal: width*0.02),
                          child: FittedBox(
                            child: Text(
                              '\$${txList[index]['price'].toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(width*0.02),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: width*0.5,
                              child: Text(
                                '${txList[index]['title']}',
                                style: Theme.of(context).textTheme.headline6.copyWith(color: Theme.of(context).accentColor),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(width*0.01),
                            ),
                            Text(
                              '${DateFormat.yMMMEd().format( DateTime.parse(txList[index]['date'] ) )} - ${DateFormat.Hms().format(DateTime.parse(txList[index]['date']) )}',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
            ),
          );
        },

      ),
    );
  }
}