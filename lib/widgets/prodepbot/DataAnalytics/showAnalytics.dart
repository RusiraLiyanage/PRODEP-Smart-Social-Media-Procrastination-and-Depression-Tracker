import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_circular_slider/multi_circular_slider.dart';
import 'package:prodep_client/widgets/prodepbot/DataAnalytics/Recomandations/userReccomandations.dart';
import 'package:prodep_client/widgets/prodepbot/chatbot-main.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import 'dart:developer' as developer;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dataRetriewal.dart';

class ShowAnalytics extends StatefulWidget {
  ShowAnalytics({Key? key}) : super(key: key);

  @override
  State<ShowAnalytics> createState() => _ShowAnalyticsState();
}

class _ShowAnalyticsState extends State<ShowAnalytics> {
  bool isLoading = true;
/*   List<String> reccomandations = [
    "දිනපතා ක්‍රීඩා වල යෙදෙන්න",
    "යාලුවන් සමග ඔබගේ ගැටලු සාකච්චා කරන්න",
    "හොද ආහාර වේලක් අනුගමනය කරන්න",
    "සැම දවසක්ම අරමුනක් සදහා කතයුතු කරන්න"
  ];

  List<String> updated_recomandations = [
    "දිනපතා ක්‍රීඩා වල යෙදෙන්න",
    "යාලුවන් සමග ඔබගේ ගැටලු සාකච්චා කරන්න",
    "හොද ආහාර වේලක් අනුගමනය කරන්න",
    "සැම දවසක්ම අරමුනක් සදහා කතයුතු කරන්න",
    "ඕනැවට වඩා සිතීමෙන් වලකින්න"
  ]; */

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

  bool onTap = false;
  String emotionalStatus = "Loading";
  String emotionalStatus2 = "Loading";
  String emotionalLabel = "Loading";
  String duration = "";
  int duration_string = 0;
  double positivity = 0.0;
  double negativity = 0.0;
  double neutral = 0.0;
  List<double> precentageList = [];
  String recomandations = "";
  List<String> recomandation_list = [];
  late Color recomandationColor;
  late Color emtionalStatusColor;
  bool yupsPositive = true;
  String userName = "";
  var the_day_string = "";
  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }

  void getData() async {
    try {
      var the_month = DateTime.now().month;
      var the_year = DateTime.now().year;
      var the_day = DateTime.now().day;
      if (the_day < 10) {
        the_day_string = "0" + the_day.toString();
      } else {
        the_day_string = the_day.toString();
      }
      developer.log(the_day_string);
      final response = await http.get(
        Uri.parse("http://192.168.8.183:7027/api/DataAnalytics"),
        //body: jsonEncode({"message": query}),
        //headers: {"Content-Type": "application/json"},
      );
      //await Future.delayed(const Duration(seconds: 30));
      //var result = jsonDecode(response.body);
      //developer.log(response.body);

      var returnedValue = response.body;
      Map<String, dynamic> result = jsonDecode(returnedValue);
      //var theJsonResult = jsonDecode(returnedValue);
      var results = jsonDecode(result["results"]);
      // ------------------------------------------------------
      emotionalStatus = results["Conversation Status"];
      developer.log(emotionalStatus);
      if (emotionalStatus == "Positive") {
        setState(() {
          emotionalStatus = "You are Emotionally Positive Biased :)";
          positivity = double.parse(results["Positive Precentage"]);
          emotionalLabel = "Positive\n  $positivity%\n   😀";
        });
      }
      if (emotionalStatus == "Negative") {
        setState(() {
          emotionalStatus = "You are Emotionally Negative Biased :(";
          negativity = double.parse(results["Negative Precentage"]);
          emotionalLabel = "Negative\n  $negativity%\n   😕";
        });
      }
      if (emotionalStatus == "Neutral") {
        setState(() {
          emotionalStatus = "You are Emotionally Neutral Biased :|";
          neutral = double.parse(results["Neutral Precentage"]);
          emotionalLabel = "Neutral\n  $neutral%\n   😐";
        });
      }
      // -----------------------------------------------------------
      positivity = (double.parse(results["Positive Precentage"]) / 100.0);
      negativity = (double.parse(results["Negative Precentage"]) / 100.0);
      neutral = (double.parse(results["Neutral Precentage"]) / 100.0);

      setState(() {
        precentageList = [positivity, negativity, neutral];
      });

      duration = result["duration"];
      var yups = duration.split(" ");
      duration_string = int.parse(yups[0]);
      userName = result["userName"].toString();
      // ------------------------------------------------------------

      var yups2 = await retriewFromMongoDB();
      Map<String, dynamic> result5 = jsonDecode(yups2);
      developer.log(result5["Recomandations"]);
      recomandations = result5["Recomandations"].toString().replaceAll("{", "");
      recomandations = result5["Recomandations"].toString().replaceAll("}", "");
      recomandation_list = recomandations.split(",");
      var toRemove = [];
      recomandation_list.forEach((element) {
        if (element.isEmpty) {
          toRemove.add(element);
        }
      });
      recomandation_list.removeWhere((e) => toRemove.contains(e));
/*       for (var item in recomandation_list) {
        if (item.isEmpty) {
          recomandation_list.remove(item);
        }
      } */
      developer.log(recomandation_list.toString());
      if (emotionalStatus.contains("Positive")) {
        recomandationColor = Colors.green;
        emtionalStatusColor = Colors.green.shade600;
        yupsPositive = true;
      }
      if (emotionalStatus.contains("Negative")) {
        recomandationColor = Colors.red;
        emtionalStatusColor = Colors.red.shade600;
        yupsPositive = false;
      }
      if (emotionalStatus.contains("Neutral")) {
        recomandationColor = Colors.yellow;
        emtionalStatusColor = Colors.yellow.shade600;
        yupsPositive = false;
      }
    } catch (error) {
      developer.log(error.toString());
    }
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? makeCustomLoadingScreen()
        : Scaffold(
            backgroundColor: Colors.black12,
            appBar: AppBar(
              title: Text(
                "Conversation Status",
                style: TextStyle(
                  fontSize: 21,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    if (emotionalStatus ==
                        "You are Emotionally Positive Biased :)") {
                      emotionalStatus2 = "Emotional Status:\nPositive 😃";
                    }
                    if (emotionalStatus ==
                        "You are Emotionally Negative Biased :(") {
                      emotionalStatus2 = "Emotional Status:\nNegative 😕";
                    }
                    if (emotionalStatus ==
                        "You are Emotionally Neutral Biased :|") {
                      emotionalStatus2 = "Emotional Status:\nNeutral 😐";
                    }
                    /* context.navigator
                  .push<void>(SwipeablePageRoute(builder: (_) => SecondPage())); */
                    Navigator.push(
                      context,
                      SwipeablePageRoute(
                        builder: (context) => UserReccomandations(
                          userRecommand: recomandation_list,
                          emotionalStatus: emotionalStatus2,
                          recomandationColor: recomandationColor,
                          emotionalStatusColors: emtionalStatusColor,
                          userName: userName,
                        ),
                      ),
                    );
                  },
                  icon: Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(right: 10),
                    child: const Icon(
                      Icons.recommend,
                      size: 40,
                    ),
                  ),
                  tooltip: 'See Recommandations',
                ),
              ],
            ),
            body: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                /*           Padding(
                padding: const EdgeInsets.all(16.0),
                child: TweenAnimationBuilder(
                  tween: Tween(begin: 0.0, end: 0.5),
                  duration: Duration(seconds: 3),
                  builder: (context, value, _) => SizedBox(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator(
                      value: double.parse(value.toString()),
                      valueColor: AlwaysStoppedAnimation(Colors.blue),
                      backgroundColor: Colors.grey,
                      strokeWidth: 13,
                    ),
                  ),
                ),
              ), */
                SizedBox(
                  height: 2,
                ),
                Text(
                  "Dear ${userName},",
                  style: TextStyle(
                      fontSize: 23.7,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "$emotionalStatus",
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: recomandationColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  highlightColor: Colors.blue,
                  onTap: () {
                    if (emotionalStatus ==
                        "You are Emotionally Positive Biased :)") {
                      emotionalStatus2 = "Emotional Status:\nPositive 😃";
                    }
                    if (emotionalStatus ==
                        "You are Emotionally Negative Biased :(") {
                      emotionalStatus2 = "Emotional Status:\nNegative 😕";
                    }
                    if (emotionalStatus ==
                        "You are Emotionally Neutral Biased :|") {
                      emotionalStatus2 = "Emotional Status:\nNeutral 😐";
                    }
                    Navigator.of(context).push(new PageRouteBuilder(
                        opaque: true,
                        transitionDuration: const Duration(milliseconds: 650),
                        pageBuilder: (BuildContext context, _, __) {
                          return new UserReccomandations(
                            userRecommand: recomandation_list,
                            emotionalStatus: emotionalStatus2,
                            recomandationColor: recomandationColor,
                            emotionalStatusColors: emtionalStatusColor,
                            userName: userName,
                          );
                        },
                        transitionsBuilder:
                            (_, Animation<double> animation, __, Widget child) {
                          return new SlideTransition(
                            child: child,
                            position: new Tween<Offset>(
                              begin: const Offset(1, 0),
                              end: Offset.zero,
                            ).animate(animation),
                          );
                        }));
                    Flushbar(
                            message: 'Showing Recommandations :)',
                            messageSize: 20,
                            messageColor: Colors.white,
                            forwardAnimationCurve: Curves.easeInBack,
                            borderColor: Colors.black26,
                            duration: Duration(seconds: 4),
                            flushbarStyle: FlushbarStyle.FLOATING,
                            flushbarPosition: FlushbarPosition.BOTTOM)
                        .show(context);
                  },
                  onHighlightChanged: (value) {
                    developer.log("Yess --->" + value.toString());
                    if (value == true) {
                      /* Flushbar(
                            message: 'Tap Middle to see Recommandations',
                            messageSize: 20,
                            messageColor: Colors.white,
                            forwardAnimationCurve: Curves.easeInBack,
                            borderColor: Colors.black26,
                            duration: Duration(seconds: 4),
                            flushbarStyle: FlushbarStyle.FLOATING,
                            flushbarPosition: FlushbarPosition.TOP)
                        .show(context); */
                      /*                 var snackBar = SnackBar(
                      /// need to set following properties for best effect of awesome_snackbar_content
                      elevation: 0,
                      behavior: SnackBarBehavior.fixed,
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.transparent,
                      content: Text("Tap on the middle\nto see recommandations"),
                    ); */

                      //ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: SafeArea(
                    maintainBottomViewPadding: false,
                    child: Center(
                      child: MultiCircularSlider(
                        size: MediaQuery.of(context).size.width * 0.845,
                        progressBarType: MultiCircularSliderType.circular,
                        values: precentageList,
                        colors: const [
                          Color(0xFF18C737),
                          Color(0xFFFD1960),
                          Colors.yellow,
                        ],
                        label: emotionalLabel,
                        animationDuration: const Duration(seconds: 4),
                        //animationCurve: Curves.easeInOutCirc,
                        //innerIcon: const Icon(Icons.face),
                        trackColor: Colors.white,
                        progressBarWidth: 10.0,
                        trackWidth: 36.0,
                        labelTextStyle: TextStyle(
                            fontSize: 30.4,
                            fontWeight: FontWeight.bold,
                            color: emtionalStatusColor),
                        percentageTextStyle: const TextStyle(fontSize: 0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Text(
                        "Last conversation\nDuration:",
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
                      SizedBox(
                        width: 0,
                      ),
                      TweenAnimationBuilder(
                        tween: Tween(begin: 0.0, end: duration_string),
                        duration: Duration(seconds: 5),
                        builder: (context, value, _) {
                          var value2 = double.parse(value.toString());
                          var value3 = value2.round().toInt();
                          return Text(
                            "\n$value3 minutes",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              foreground: Paint()
                                ..shader = LinearGradient(colors: [
                                  Colors.deepPurpleAccent,
                                  Colors.blue,
                                ]).createShader(
                                  Rect.fromLTWH(100, 100, 100, 100),
                                ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Text(
                        "Positvity: ",
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF18C737),
                        ),
                      ),
                      SizedBox(
                        width: 76,
                      ),
                      TweenAnimationBuilder(
                        tween: Tween(begin: 0.0, end: positivity),
                        duration: Duration(seconds: 5),
                        builder: (context, value, _) {
                          var value2 = double.parse(value.toString());
                          value2 = value2 * 100;
                          var value3 = value2.toStringAsFixed(2);
                          return Text(
                            "$value3 %",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF18C737),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Text(
                        "Negativity:",
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFD1960),
                        ),
                      ),
                      SizedBox(
                        width: 65,
                      ),
                      TweenAnimationBuilder(
                        tween: Tween(begin: 0.0, end: negativity),
                        duration: Duration(seconds: 5),
                        builder: (context, value, _) {
                          var value2 = double.parse(value.toString());
                          value2 = value2 * 100;
                          var value3 = value2.toStringAsFixed(2);
                          return Text(
                            "$value3 %",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFD1960),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Text(
                        "Neutral:",
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: Colors.yellow,
                        ),
                      ),
                      SizedBox(
                        width: 95,
                      ),
                      TweenAnimationBuilder(
                        tween: Tween(begin: 0.0, end: neutral),
                        duration: Duration(seconds: 5),
                        builder: (context, value, _) {
                          var value2 = double.parse(value.toString());
                          value2 = value2 * 100;
                          var value3 = value2.toStringAsFixed(2);
                          return Text(
                            "$value3 %",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                /* MultiCircularSlider(
                size: MediaQuery.of(context).size.width * 0.8,
                progressBarType: MultiCircularSliderType.circular,
                values: const [0.4, 0.3, 0.2],
                colors: const [
                  Color(0xFFFD1960),
                  Color(0xFF29D3E8),
                  Color(0xFF18C737),
                ],
                showTotalPercentage: true,
                label: 'Sentiment Analysis',
                animationDuration: const Duration(milliseconds: 1000),
                animationCurve: Curves.easeInOutCirc,
                innerIcon: const Icon(Icons.integration_instructions),
                trackColor: Colors.white,
                progressBarWidth: 36.0,
                trackWidth: 36.0,
                labelTextStyle: const TextStyle(),
                percentageTextStyle: const TextStyle(fontSize: 15),
              ), */
              ],
            ),
          );
  }
}
