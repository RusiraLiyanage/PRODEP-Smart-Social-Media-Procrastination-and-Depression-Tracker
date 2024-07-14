import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:prodep_client/widgets/singleday-widget.dart';

class DateDaysWidget extends StatefulWidget {
  final String monthName;
  const DateDaysWidget({Key? key, required this.monthName}) : super(key: key);

  @override
  State<DateDaysWidget> createState() => _DateDaysWidgetState();
}

class _DateDaysWidgetState extends State<DateDaysWidget> {
  List<Map<String, dynamic>> monthsWithDates = [
    {"month": "January", "noOfDates": 31},
    {"month": "February", "noOfDates": 28},
    {"month": "March", "noOfDates": 31},
    {"month": "April", "noOfDates": 30},
    {"month": "May", "noOfDates": 31},
    {"month": "June", "noOfDates": 30},
    {"month": "July", "noOfDates": 31},
    {"month": "August", "noOfDates": 31},
    {"month": "September", "noOfDates": 30},
    {"month": "October", "noOfDates": 31},
    {"month": "November", "noOfDates": 30},
    {"month": "December", "noOfDates": 31},
  ];
  int currentNoOfDates = 0;

  @override
  Widget build(BuildContext context) {
    for (var items in monthsWithDates) {
      if (items["month"] == widget.monthName) {
        currentNoOfDates = items["noOfDates"];
      }
    }
    return Flexible(
      child: Container(
          height: 70,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: SizedBox(
                  height: 70,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: currentNoOfDates,
                    itemBuilder: (context, index) {
                      return SingleDayWidget(day: (++index), month: widget.monthName,);
                    },
                  ),
                ),
              )
            ],
          )),
    );
  }
}
