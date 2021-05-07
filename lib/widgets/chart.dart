import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {

  final List txList;
  Chart(this.txList);

  List<Map<String,Object>> get groupedTransactionsValues
  {
    return List.generate( 7, (index)
    {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double dayPriceSum = 0;

      for(var e in txList)
      {
        if( DateTime.parse(e['date']).day == weekDay.day && DateTime.parse(e['date']).month == weekDay.month && DateTime.parse(e['date']).year == weekDay.year)
        {
          dayPriceSum += e['price'];
        }
      }
      return { 'day':  DateFormat.E().format(weekDay) , 'price': dayPriceSum };

    });
  }

  double get totalSpendings => groupedTransactionsValues.fold(0.0, (sum, element) => sum + element['price'] );




  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Card(
      elevation: 10,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...groupedTransactionsValues.reversed.map((e){
              return Flexible(
                fit: FlexFit.tight,
                child: Column(
                  children: [
                    Text(
                      '\$${(e['price'] as double).toStringAsFixed(0)}',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    SizedBox(height: height*0.015),

                    Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Container(
                        width: width*0.05,
                        height: height*0.14,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.white,Theme.of(context).accentColor],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: ( totalSpendings == 0)? [1,0] : [1-((e['price'] as double)/totalSpendings),1-((e['price'] as double)/totalSpendings)]
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),

                    SizedBox(height: height*0.015),
                    Text(e['day'],style: Theme.of(context).textTheme.subtitle2,),
                  ],
                ),
              );
            }).toList()
          ],
        ),
      ),
    );
  }
}
