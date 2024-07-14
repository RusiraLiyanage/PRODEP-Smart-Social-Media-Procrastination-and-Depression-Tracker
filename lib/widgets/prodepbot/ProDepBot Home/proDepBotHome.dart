import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:prodep_client/widgets/prodepbot/DataAnalytics/History/showChatHistry.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import '../DataAnalytics/showAnalytics.dart';
import 'Summary/monthly_summary.dart';
import 'calculateTime.dart';
import 'category_card.dart';
import 'gridItemCard.dart';
import '../chatbot-main.dart' as botMain;

class ProDepBotHome extends StatefulWidget {
  const ProDepBotHome({Key? key}) : super(key: key);

  @override
  State<ProDepBotHome> createState() => _ProDepBotHomeState();
}

class _ProDepBotHomeState extends State<ProDepBotHome> {
  String the_year = "";
  int the_month = 0;
  int the_hour = 0;
  String month_name = "";
  String the_day = "";
  String the_greeting = "";
  String the_minutes = "";
  String the_correct_time = "";
  String the_day_suffix = "";
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

  List<String> the_day_suffixes = [];

  Future<void> callInitAgain() async {
    the_year = DateTime.now().year.toString();
    the_month = DateTime.now().month;
    the_day = DateTime.now().day.toString();
    month_name = the_month_array[the_month - 1];
    greeting();

    //the_correct_time = getTweleveHourTime(the_hour);
    the_day_suffix = getDaySuffix(int.parse(the_day));
    the_correct_time = new DateFormat.jm().format(DateTime.now());
    setState(() {});
  }

  void greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      the_greeting = 'Good Morning !!';
    }
    if (hour < 17 && hour >= 12) {
      the_greeting = 'Good Afternoon !!';
    }
    if (hour >= 16) {
      the_greeting = 'Good Evening !!';
    }
  }

  String time_type = "";
  @override
  void initState() {
    the_year = DateTime.now().year.toString();
    the_month = DateTime.now().month;
    the_hour = DateTime.now().hour;
    the_day = DateTime.now().day.toString();
    the_minutes = DateTime.now().minute.toString();

    month_name = the_month_array[the_month - 1];

    greeting();
    the_correct_time = new DateFormat.jm().format(DateTime.now());
    //the_correct_time = getTweleveHourTime(the_hour);
    the_day_suffix = getDaySuffix(int.parse(the_day));
    setState(() {});
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: RefreshIndicator(
        onRefresh: callInitAgain,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              opacity: 70,
              //matchTextDirection: true,
              filterQuality: FilterQuality.high,
              colorFilter: ColorFilter.mode(
                Colors.black,
                BlendMode.screen,
              ),
              //image: AssetImage("assets/3bb074f5e7ff82cfa76c0b42e00176ba.jpg"),
              image: AssetImage("assets/images/light_background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: <Widget>[
              Container(
                // Here the height of the container is 45% of our total height
                height: 200,
                width: 500,
                decoration: BoxDecoration(
                  color: Color(0xFFF5CEB8),
                  image: DecorationImage(
                    alignment: Alignment.center,
                    image: AssetImage(
                      "assets/images/background2.webp",
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 200),
                child: Container(
                  padding: EdgeInsets.only(top: 50),
                  child: Text(
                    "${the_correct_time}",
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        alignment: Alignment.center,
                        height: 52,
                        width: 52,
                        decoration: BoxDecoration(
                          color: Color(0xFFF2BEA1),
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset("assets/icons/menu.svg"),
                      ),
                    ),
                    Image(
                      image: AssetImage("assets/images/the_bot.png"),
                      fit: BoxFit.fill,
                      filterQuality: FilterQuality.high,
                      width: 200,
                      height: 70,
                    ),
                    Text(
                      "${the_day}${the_day_suffix} Of $month_name $the_year",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "$the_greeting",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: .85,
                        crossAxisSpacing: 7,
                        mainAxisSpacing: 20,
                        children: <Widget>[
                          CategoryCard(
                            title: "Start new conversation :)",
                            svgSrc: "assets/images/start a new chat.png",
                            cardColor: Colors.green,
                            press: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => botMain.MyApp(),
                                ),
                              );
                            },
                          ),
                          CategoryCard(
                            title: "Your last conversation status",
                            svgSrc:
                                "assets/images/last conversation status.png",
                            cardColor: Colors.blue,
                            press: () {
                              Navigator.push(
                                context,
                                SwipeablePageRoute(
                                  builder: (context) => ShowAnalytics(),
                                ),
                              );
                            },
                          ),
                          CategoryCard(
                            title: "Your Conversation Histry",
                            svgSrc: "assets/images/Conversation Histry.png",
                            cardColor: Colors.purpleAccent,
                            press: () {
                              Navigator.push(
                                context,
                                SwipeablePageRoute(
                                  builder: (context) => ShowChatHistry(),
                                ),
                              );
                            },
                          ),
                          CategoryCard(
                            title: "Summary for this month",
                            cardColor: Colors.lightBlue,
                            svgSrc: "assets/images/Summary.png",
                            press: () {
                              Navigator.push(
                                context,
                                SwipeablePageRoute(
                                  builder: (context) => MonthlySummary(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
