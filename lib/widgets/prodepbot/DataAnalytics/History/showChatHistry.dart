import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:prodep_client/widgets/prodepbot/DataAnalytics/History/Widgets/chatHistryCard.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import '../Recomandations/userReccomandations.dart';

class ShowChatHistry extends StatefulWidget {
  ShowChatHistry({Key? key}) : super(key: key);

  @override
  State<ShowChatHistry> createState() => _ShowChatHistryState();
}

class _ShowChatHistryState extends State<ShowChatHistry> {
  var yupsContext;

  final ScrollController _scrollController = ScrollController();

  Future<void> callInitAgain() async {
    loadData();
  }

  Widget buildLinearProgress(double progress) => Text(
        "${(progress * 100).toStringAsFixed(1)} %",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      );
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
  String emotionalStatus = "Loading";
  String emotionalStatus2 = "Loading";
  String emotionalLabel = "Loading";
  String duration = "";
  int duration_string = 0;
  double positivity = 0.0;
  double negativity = 0.0;
  double neutral = 0.0;
  late Color overall_colors;

  List<String> monthly_analytics_list = [];
  //List<dynamic> map = [];
  List<String> overall_list = [];
  List<double> positive_precentage_list = [];
  List<double> negative_precentage_list = [];
  List<double> neutral_precentage_list = [];
  List<String> the_date_list = [];
  List<String> the_time_list = [];
  List<double> duration_list = [];
  Map<String, dynamic> map = new Map<String, dynamic>();
  bool isLoading = true;
  int the_data_list_length = 0;
  late Color recomandationColor;
  late Color emotionalStatusColors;
  String overall_recomandation = "";
  String month_name = "";
  String the_year = "";
  @override
  void initState() {
    loadData();
    // TODO: implement initState
    super.initState();
  }

  void loadData() async {
    var live_month = DateTime.now().month;
    var live_year = DateTime.now().year;
    try {
      final response = await http.get(
        Uri.parse(
            "http://192.168.8.183:7027/api/DataAnalytics/getAnalyticList/" +
                "${live_year}/${live_month}"),
      );
      developer.log(response.body.runtimeType.toString());

      map = json.decode(response.body);
      List<dynamic> data = map["arrayResponse"];
      developer.log("The length: " + data.length.toString());
      the_data_list_length = data.length;
      var the_month = DateTime.now().month;
      month_name = the_month_array[the_month - 1];
      the_year = DateTime.now().year.toString();
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      developer.log(error.toString());
    }
  }

  Scaffold makeCustomLoadingScreen() {
    return Scaffold(
      backgroundColor: Colors.black54,
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

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? makeCustomLoadingScreen()
        : Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                Container(
                  height: 185,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(50),
                    ),
                    color: Colors.blue,
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 50,
                        left: 0,
                        child: Container(
                          height: 100,
                          width: 300,
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
                        top: 75,
                        left: 10,
                        child: Text(
                          "Your Conversation Histry",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      Positioned(
                        top: 105,
                        left: 10,
                        child: Text(
                          "Month Of $month_name $the_year",
                          style: TextStyle(
                            fontSize: 23,
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
                    ],
                  ),
                ),
                SizedBox(
                  height: 1,
                ),
                Expanded(
                  child: CupertinoScrollbar(
                    isAlwaysShown: true,
                    controller: _scrollController,
                    thickness: 5,
                    child: RefreshIndicator(
                      onRefresh: callInitAgain,
                      child: ListView.builder(
                        controller: _scrollController,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: the_data_list_length,
                        itemBuilder: (context, index) {
                          List<dynamic> data = map["arrayResponse"];
                          int reversedIndex = the_data_list_length - 1 - index;
                          var the_decoded =
                              jsonDecode(data[reversedIndex]["results"]);
                          var the_name_decoded =
                              jsonEncode(data[reversedIndex]["userName"]);
                          developer.log("The Name: " + the_name_decoded);
                          String the_user_name = the_name_decoded.toString();
                          the_user_name =
                              the_user_name.replaceAll(RegExp('"'), "");
                          var the_date =
                              (data[reversedIndex]["theDate"]).toString();
                          the_date = the_date.replaceAll("-", "/");
                          var the_time = (data[reversedIndex]["theTime"]);
                          var duration = (data[reversedIndex]["duration"]);
                          var durationArray = duration.split(" ");
                          duration = durationArray[0];
                          var overall =
                              the_decoded["Conversation Status"].toString();
                          if (overall == "Positive") {
                            overall = "Positive 😀";
                            overall_colors = Colors.green.shade400;
                            recomandationColor = Colors.green;
                            emotionalStatusColors = Colors.green.shade600;
                            overall_recomandation =
                                "Emotional Status:\nPositive 😀";
                          }
                          if (overall == "Negative") {
                            overall = "Negative 😕";
                            overall_colors = Colors.red.shade400;
                            recomandationColor = Colors.red;
                            emotionalStatusColors = Colors.red.shade600;
                            overall_recomandation =
                                "Emotional Status:\nNegative 😕";
                          }
                          if (overall == "Neutral") {
                            overall = "Neutral 😐";
                            overall_colors = Colors.yellow.shade400;
                            recomandationColor = Colors.yellow;
                            emotionalStatusColors = Colors.yellow.shade600;
                            overall_recomandation =
                                "Emotional Status:\nNeutral 😐";
                          }
                          var positivity = the_decoded["Positive Precentage"];
                          var negativity = the_decoded["Negative Precentage"];
                          var neutral = the_decoded["Neutral Precentage"];
                          String recomandations_strings =
                              the_decoded["Recomandations"].toString();
                          recomandations_strings =
                              recomandations_strings.replaceAll("{", "");
                          recomandations_strings =
                              recomandations_strings.replaceAll("}", "");
                          List<String> recomandations =
                              recomandations_strings.split(",");
                          var toRemove = [];
                          recomandations.forEach((element) {
                            if (element.isEmpty) {
                              toRemove.add(element);
                            }
                          });
                          recomandations
                              .removeWhere((e) => toRemove.contains(e));
                          return ChatHistryCard(
                            theContext: context,
                            overall: overall,
                            positivity: (double.parse(positivity) / 100.0),
                            negativity: (double.parse(negativity) / 100.0),
                            neutral: (double.parse(neutral) / 100.0),
                            the_date: the_date,
                            the_time: the_time,
                            the_duration: (double.parse(duration) / 100.0),
                            recomandations: recomandations,
                            overall_color: overall_colors,
                            recomandationColor: recomandationColor,
                            emotionalStatusColors: emotionalStatusColors,
                            overall_recomandation: overall_recomandation,
                            the_user_name: the_user_name,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
