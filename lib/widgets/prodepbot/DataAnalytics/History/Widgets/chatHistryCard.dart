import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import 'dart:developer' as developer;
import '../../Recomandations/userReccomandations.dart';

/* final List<String> reccomandations = [
  "දිනපතා ක්‍රීඩා වල යෙදෙන්න",
  "යාලුවන් සමග ඔබගේ ගැටලු සාකච්චා කරන්න",
  "හොද ආහාර වේලක් අනුගමනය කරන්න",
  "සැම දවසක්ම අරමුනක් සදහා කතයුතු කරන්න",
  "ඕනැවට වඩා සිතීමෙන් වලකින්න"
]; */

/* List<String> updated_recomandations = [
  "දිනපතා ක්‍රීඩා වල යෙදෙන්න",
  "යාලුවන් සමග ඔබගේ ගැටලු සාකච්චා කරන්න",
  "හොද ආහාර වේලක් අනුගමනය කරන්න",
  "සැම දවසක්ම අරමුනක් සදහා කතයුතු කරන්න",
  "ඕනැවට වඩා සිතීමෙන් වලකින්න"
]; */

Widget buildLinearProgress(double progress) => Text(
      "${(progress * 100).toStringAsFixed(1)} %",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );

class ChatHistryCard extends StatelessWidget {
  final BuildContext theContext;
  //var histryResults;
  String overall;
  double positivity;
  double negativity;
  double neutral;
  String the_date;
  String the_time;
  double the_duration;
  Color overall_color;
  List<String> recomandations;
  Color recomandationColor;
  Color emotionalStatusColors;
  String overall_recomandation;
  String the_user_name = "";
  ChatHistryCard({
    Key? key,
    required this.theContext,
    required this.overall,
    required this.positivity,
    required this.negativity,
    required this.neutral,
    required this.the_date,
    required this.the_time,
    required this.the_duration,
    required this.recomandations,
    required this.overall_color,
    required this.recomandationColor,
    required this.emotionalStatusColors,
    required this.overall_recomandation,
    required this.the_user_name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //context = theContext;
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(left: 5),
        height: 340,
        child: Stack(children: [
          Positioned(
            top: 25,
            left: 5,
            child: Material(
              child: Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(0.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      offset: new Offset(-10.0, 10.0),
                      blurRadius: 20.0,
                      spreadRadius: 4.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 30,
            left: 9,
            child: Card(
              elevation: 10.0,
              shadowColor: Colors.grey.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                height: 275,
                width: 145,
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
                      Text(
                        "Overall",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationThickness: 5,
                            decorationStyle: TextDecorationStyle.solid),
                      ),
                      Container(
                        width: 135,
                        height: 40,
                        child: Card(
                          color: overall_color,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 3),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "$overall",
                                    style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.blue,
                        thickness: 5,
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        "Positive 😀",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      /* LinearPercentIndicator(
                                width: 140.0,
                                lineHeight: 30.0,
                                percent: 0.5,
                                backgroundColor: Colors.grey,
                                progressColor: Colors.blue,
                                animation: true,
                                animationDuration: 5000,
                                restartAnimation: true,
                                linearStrokeCap: LinearStrokeCap.roundAll,
                              ), */
                      TweenAnimationBuilder(
                        tween: Tween(begin: 0.0, end: positivity),
                        duration: Duration(seconds: 2),
                        builder: (context, value, _) {
                          return SizedBox(
                            width: 130,
                            height: 20,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Container(
                                  width: 100,
                                  height: 17,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    child: LinearProgressIndicator(
                                      value: double.parse(value.toString()),
                                      valueColor:
                                          AlwaysStoppedAnimation(Colors.green),
                                      backgroundColor: Colors.grey,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: buildLinearProgress(
                                      double.parse(value.toString())),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Negative 😕",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      TweenAnimationBuilder(
                        tween: Tween(begin: 0.0, end: negativity),
                        duration: Duration(seconds: 2),
                        builder: (context, value, _) {
                          return SizedBox(
                            width: 130,
                            height: 20,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Container(
                                  width: 100,
                                  height: 17,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    child: LinearProgressIndicator(
                                      value: double.parse(value.toString()),
                                      valueColor: AlwaysStoppedAnimation(
                                        Color(0xFFFD1960),
                                      ),
                                      backgroundColor: Colors.grey,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: buildLinearProgress(
                                      double.parse(value.toString())),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Neutral 😐",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      TweenAnimationBuilder(
                        tween: Tween(begin: 0.0, end: neutral),
                        duration: Duration(seconds: 2),
                        builder: (context, value, _) {
                          return SizedBox(
                            width: 130,
                            height: 20,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Container(
                                  width: 100,
                                  height: 17,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    child: LinearProgressIndicator(
                                      value: double.parse(value.toString()),
                                      valueColor: AlwaysStoppedAnimation(
                                        Colors.yellow,
                                      ),
                                      backgroundColor: Colors.grey,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: buildLinearProgress(
                                      double.parse(value.toString())),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 13,
            child: Container(
              height: 300,
              width: 140,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Conversation",
                    style: TextStyle(
                        fontSize: 25,
                        color: Color(0xFF363f93),
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.black,
                          )
                        ]),
                  ),
                  Divider(
                    color: Colors.blue,
                    thickness: 5,
                  ),
                  Text(
                    "$the_date",
                    style: TextStyle(
                      fontSize: 25,
                      color: Color(0xFF363f93),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "$the_time",
                    style: TextStyle(
                      fontSize: 25,
                      color: Color(0xFF363f93),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Divider(
                    color: Colors.blueAccent,
                    thickness: 5,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 40),
                    child: Text(
                      "Duration: ",
                      style: TextStyle(
                        fontSize: 24,
                        color: Color(0xFF363f93),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TweenAnimationBuilder(
                    tween: Tween(begin: 0.0, end: the_duration),
                    duration: Duration(seconds: 2),
                    builder: (context, value, _) {
                      return SizedBox(
                        width: 130,
                        height: 32,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Container(
                              width: 100,
                              height: 17,
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                child: Text(
                                  "${(double.parse(value.toString()) * 100).toInt()} minutes",
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Color(0xFF363f93),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 3,
                    ),
                    child: Container(
                      height: 82,
                      width: 150,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            SwipeablePageRoute(
                              transitionDuration: Duration(seconds: 2),
                              builder: (context) => UserReccomandations(
                                emotionalStatus: overall_recomandation,
                                userRecommand: recomandations,
                                recomandationColor: recomandationColor,
                                emotionalStatusColors: emotionalStatusColors,
                                userName: the_user_name,
                              ),
                            ),
                          );
                          Flushbar(
                                  message: 'Showing Recommandations :)',
                                  messageSize: 20,
                                  messageColor: Colors.white,
                                  forwardAnimationCurve: Curves.easeInBack,
                                  borderColor: Colors.black26,
                                  duration: Duration(seconds: 3),
                                  flushbarStyle: FlushbarStyle.FLOATING,
                                  flushbarPosition: FlushbarPosition.BOTTOM)
                              .show(context);
                        },
                        child: Card(
                          elevation: 10.0,
                          shadowColor: Colors.grey.withOpacity(0.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                  "assets/images/recomandations.jpg",
                                ),
                              ),
                            ),
                            /* child: Text(
                                      "Recommandations",
                                      style: TextStyle(
                                        fontSize: 29,
                                        color: Color(0xFF363f93),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ), */
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
