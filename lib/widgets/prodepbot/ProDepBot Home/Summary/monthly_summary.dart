import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;

class MonthlySummary extends StatefulWidget {
  MonthlySummary({Key? key}) : super(key: key);

  @override
  State<MonthlySummary> createState() => _MonthlySummaryState();
}

class _MonthlySummaryState extends State<MonthlySummary> {
/*   List<Map> _seassons = [
    {'dateTime': '10/05/2022 10.00 a.m', 'duration': '30 mins'},
    {'dateTime': '10/06/2022 2.30 p.m', 'duration': '15 mins'},
    {'dateTime': '11/15/2022 6.00 p.m', 'duration': '5 mins'},
    {'dateTime': '12/21/2022 11.00 a.m', 'duration': '20 mins'},
    {'dateTime': '12/20/2022 10.00 a.m', 'duration': '10 mins'}
  ]; */

  int positive_count = 0;
  int negative_count = 0;
  int neutral_count = 0;
  List<Map> the_table = [];
  List<dynamic> the_dynamic_table = [];
  var live_month;
  var live_year;
  var live_day;
  String userName = "";
  bool isLoading = true;
  List<String> the_month_array = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "Octomber",
    "November",
    "December"
  ];
  String month_name = "";
  String the_year = "";
  String the_day_string = "";
  Scaffold makeCustomLoadingScreen() {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitFoldingCube(
            itemBuilder: (context, index) {
              final colors = [
                Colors.pinkAccent,
                Colors.deepPurpleAccent,
                Colors.red,
                Colors.blue[800]
              ];
              final color = colors[index % colors.length];
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.rectangle,
                ),
              );
            },
            size: 100.0,
            duration: Duration(
              milliseconds: 2200,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Center(
            child: Text(
              "Loading Data ...........",
              style: GoogleFonts.notoSans(
                textStyle: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..shader = LinearGradient(colors: [
                      Colors.pinkAccent,
                      Colors.deepPurpleAccent,
                      Colors.red,
                    ]).createShader(
                      Rect.fromLTWH(5.0, 5.0, 200.0, 50.0),
                    ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  SingleChildScrollView _createDataTable() {
    return SingleChildScrollView(
      child: Scrollbar(
        child: DataTable(
          columnSpacing: 10,
          columns: _createColumns(),
          rows: _createRows(),
          headingRowHeight: 25,
        ),
      ),
    );
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(
          label: Text(
        'Seasson Date and Time',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      )),
      DataColumn(
          label: Text(
        'Duration',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ))
    ];
  }

  List<DataRow> _createRows() {
    return the_table
        .map((table_data) => DataRow(cells: [
              DataCell(Text(
                table_data['startDateTime'],
                style: TextStyle(
                  fontSize: 17,
                ),
              )),
              DataCell(Text(
                table_data['duration'] + " mins",
                style: TextStyle(
                  fontSize: 17,
                ),
              ))
            ]))
        .toList();
  }

  @override
  void initState() {
    live_month = DateTime.now().month;
    live_year = DateTime.now().year;
    live_day = DateTime.now().day;
    developer.log("Current Month: " + live_month.toString());
    developer.log("Current Year: " + live_year.toString());
    getData();
    // TODO: implement initState
    super.initState();
  }

  void getData() async {
    try {
      final positiveCount = await http.get(
        Uri.parse(
            "http://192.168.8.183:7027/api/DataAnalytics/getSentimentCount/" +
                "$live_year/$live_month/Positive"),
        //body: jsonEncode({"message": query}),
        //headers: {"Content-Type": "application/json"},
      );
      positive_count = int.parse(positiveCount.body);
      developer.log("Positive Count: " + positive_count.toString());
    } catch (error) {
      developer.log("error occured: " + error.toString());
    }

    try {
      final negativeCount = await http.get(
        Uri.parse(
            "http://192.168.8.183:7027/api/DataAnalytics/getSentimentCount/" +
                "$live_year/$live_month/Negative"),
        //body: jsonEncode({"message": query}),
        //headers: {"Content-Type": "application/json"},
      );
      negative_count = int.parse(negativeCount.body);
      developer.log("Negative Count: " + negative_count.toString());
    } catch (error) {
      developer.log("error occured: " + error.toString());
    }

    try {
      final neutralCount = await http.get(
        Uri.parse(
            "http://192.168.8.183:7027/api/DataAnalytics/getSentimentCount/" +
                "$live_year/$live_month/Neutral"),
        //body: jsonEncode({"message": query}),
        //headers: {"Content-Type": "application/json"},
      );
      neutral_count = int.parse(neutralCount.body);
      developer.log("Neutral Count: " + neutral_count.toString());
    } catch (error) {
      developer.log("error occured: " + error.toString());
    }

    try {
      final theTable = await http.get(
        Uri.parse(
            "http://192.168.8.183:7027/api/DataAnalytics/getSummaryTable/" +
                "$live_year/$live_month"),
      );
      the_dynamic_table = jsonDecode(theTable.body);
      the_table = the_dynamic_table.cast<Map>();
      the_table = the_table.reversed.toList();
      developer.log(the_table.toString());
    } catch (error) {
      developer.log("error occured: " + error.toString());
    }

    try {
      if (live_day < 10) {
        the_day_string = "0" + live_day.toString();
      } else {
        the_day_string = live_day.toString();
      }
      final userNameResponse = await http.get(
        Uri.parse(
            "http://192.168.8.183:7027/api/DataAnalytics/getLastUserName"),
      );
      userName = userNameResponse.body.toString();
      //var decodedUserName = jsonDecode(userNameResponse.body);
      developer.log("User Name: " + userName);
    } catch (error) {
      developer.log("error occured: " + error.toString());
    }

    var the_month = DateTime.now().month;
    month_name = the_month_array[the_month - 1];
    the_year = DateTime.now().year.toString();
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) => isLoading
      ? makeCustomLoadingScreen()
      : Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Container(
                alignment: Alignment.bottomLeft,
                height: 125,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50),
                  ),
                  color: Colors.blue,
                ),
                padding: EdgeInsets.only(top: 40, left: 5),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        height: 60,
                        width: 250,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      child: Container(
                        height: 100,
                        width: 700,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hi $userName",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                /* foreground: Paint()
                                  ..shader = LinearGradient(colors: [
                                    Colors.pinkAccent,
                                    Colors.deepPurpleAccent,
                                    Colors.red,
                                  ]).createShader(
                                    Rect.fromLTWH(5.0, 5.0, 200.0, 50.0),
                                  ), */
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 30,
                      child: Text(
                        "Welcome back :)",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          /* foreground: Paint()
                            ..shader = LinearGradient(colors: [
                              Colors.pinkAccent,
                              Colors.deepPurpleAccent,
                              Colors.red,
                            ]).createShader(
                              Rect.fromLTWH(5.0, 5.0, 200.0, 50.0),
                            ), */
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(
                        "Summary",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()
                            ..shader = LinearGradient(colors: [
                              Colors.pinkAccent,
                              Colors.deepPurpleAccent,
                            ]).createShader(
                              Rect.fromLTWH(5.0, 5.0, 200.0, 50.0),
                            ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
              Text(
                "Month Of $month_name $the_year",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..shader = LinearGradient(colors: [
                      Colors.purple,
                      Colors.deepPurpleAccent,
                    ]).createShader(
                      Rect.fromLTWH(5.0, 5.0, 200.0, 50.0),
                    ),
                ),
              ),
              Card(
                elevation: 10.0,
                color: Colors.purple.shade50,
                shadowColor: Colors.grey.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  height: 160,
                  width: 285,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    /* image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(
                            "assets/images/bot.png",
                          ),
                        ), */
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            "Upto now you had,",
                            style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                decorationThickness: 5,
                                decorationStyle: TextDecorationStyle.solid),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TweenAnimationBuilder(
                          tween: Tween(begin: 0.0, end: positive_count),
                          duration: Duration(milliseconds: 600),
                          builder: (context, value, _) {
                            return Text(
                              "${(double.parse(value.toString())).round()} Positive Conversations",
                              style: TextStyle(
                                fontSize: 24.5,
                                fontWeight: FontWeight.bold,
                                foreground: Paint()
                                  ..shader = LinearGradient(colors: [
                                    Colors.green,
                                    Colors.green.shade400,
                                  ]).createShader(
                                    Rect.fromLTWH(5.0, 5.0, 200.0, 50.0),
                                  ),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        TweenAnimationBuilder(
                          tween: Tween(begin: 0.0, end: negative_count),
                          duration: Duration(milliseconds: 600),
                          builder: (context, value, _) {
                            return Text(
                              "${(double.parse(value.toString())).round()} Negative Conversations",
                              style: TextStyle(
                                fontSize: 24.5,
                                fontWeight: FontWeight.bold,
                                foreground: Paint()
                                  ..shader = LinearGradient(colors: [
                                    Colors.red,
                                    Colors.red.shade400,
                                  ]).createShader(
                                    Rect.fromLTWH(5.0, 5.0, 200.0, 50.0),
                                  ),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        TweenAnimationBuilder(
                          tween: Tween(begin: 0.0, end: neutral_count),
                          duration: Duration(milliseconds: 600),
                          builder: (context, value, _) {
                            return Text(
                              "${(double.parse(value.toString())).round()} Neutral Conversations",
                              style: TextStyle(
                                fontSize: 24.5,
                                fontWeight: FontWeight.bold,
                                foreground: Paint()
                                  ..shader = LinearGradient(colors: [
                                    Colors.yellow.shade800,
                                    Colors.yellow.shade900
                                  ]).createShader(
                                    Rect.fromLTWH(5.0, 5.0, 200.0, 50.0),
                                  ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Session Duration",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()
                      ..shader = LinearGradient(colors: [
                        Colors.purple,
                        Colors.deepPurpleAccent,
                      ]).createShader(
                        Rect.fromLTWH(5.0, 5.0, 200.0, 50.0),
                      ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: _createDataTable(),
              ),
            ],
          ),
        );
}
