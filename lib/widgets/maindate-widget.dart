import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:prodep_client/widgets/datedays-widget.dart';
import 'package:intl/intl.dart';
import 'package:prodep_client/widgets/prodepvision/prodepvision-widget.dart';

class MainDateWidget extends StatefulWidget {
  const MainDateWidget({Key? key}) : super(key: key);

  @override
  State<MainDateWidget> createState() => _MainDateWidgetState();
}

class _MainDateWidgetState extends State<MainDateWidget> {
  int hours = DateTime.now().hour;
  int monthInInt = DateTime.now().month;
  String dropdownvalue = DateFormat("MMMM").format(DateTime.now());
  List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100.0),
      child: Container(
        width: double.infinity,
        height: 140,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: hours >= 12
                      ? Text(
                          "Good Afternoon!..",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        )
                      : Text(
                          "Good Morning!..",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: DropdownButton(
                    value: dropdownvalue,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: months.map((String month) {
                      return DropdownMenuItem(
                        value: month,
                        child: Text(
                          month,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),
                ),
              ],
            ),
            DateDaysWidget(monthName: dropdownvalue,),
          ],
        ),
      ),
    );
  }
}
