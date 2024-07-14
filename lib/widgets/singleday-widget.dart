import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class SingleDayWidget extends StatefulWidget {
  final int day;
  final String month;

  const SingleDayWidget({Key? key, required this.day, required this.month})
      : super(key: key);

  @override
  State<SingleDayWidget> createState() => _SingleDayWidgetState();
}

class _SingleDayWidgetState extends State<SingleDayWidget> {
  int today = DateTime.now().day;
  String currentMonth = DateFormat("MMMM").format(DateTime.now());
  bool isEqual = false;
  void checkToday() {
    if (today == widget.day && currentMonth == widget.month) {
      isEqual = true;
    } else {
      isEqual = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    checkToday();
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        decoration: isEqual
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: const Color(0xFF393737),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              )
            : BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
        alignment: Alignment.center,
        width: 60,
        height: 80,
        child: Text(
          widget.day.toString(),
          style: isEqual
              ? const TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)
              : const TextStyle(fontSize: 25, color: Colors.black),
        ),
      ),
    );
  }
}
