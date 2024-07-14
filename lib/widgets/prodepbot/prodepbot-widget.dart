import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prodep_client/widgets/prodepbot/DataAnalytics/History/Widgets/backup.dart';
import 'package:prodep_client/widgets/prodepbot/DataAnalytics/Recomandations/userReccomandations.dart';
import 'package:prodep_client/widgets/prodepbot/DataAnalytics/showAnalytics.dart';
import 'package:prodep_client/widgets/prodepbot/ProDepBot%20Home/Summary/monthly_summary.dart';
import 'package:prodep_client/widgets/prodepbot/ProDepBot%20Home/proDepBotHome.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import 'dart:developer' as developer;
import 'DataAnalytics/History/showChatHistry.dart';
import 'chatbot-main.dart' as botMain;

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProDepBotWidget extends StatefulWidget {
  String the_duration = "";
  String the_status = "";
  late Color the_status_color;
  ProDepBotWidget({
    Key? key,
    required this.the_duration,
    required this.the_status,
    required this.the_status_color,
  }) : super(key: key);
  List<String> reccomandations = [
    "දිනපතා ක්‍රීඩා වල යෙදෙන්න",
    "යාලුවන් සමග ඔබගේ ගැටලු සාකච්චා කරන්න",
    "හොද ආහාර වේලක් අනුගමනය කරන්න",
    "සැම දවසක්ම අරමුනක් සදහා කතයුතු කරන්න",
    "ඕනැවට වඩා සිතීමෙන් වලකින්න"
  ];

  List<String> updated_recomandations = [
    "දිනපතා ක්‍රීඩා වල යෙදෙන්න",
    "යාලුවන් සමග ඔබගේ ගැටලු සාකච්චා කරන්න",
    "හොද ආහාර වේලක් අනුගමනය කරන්න",
    "සැම දවසක්ම අරමුනක් සදහා කතයුතු කරන්න",
    "ඕනැවට වඩා සිතීමෙන් වලකින්න"
  ];

  @override
  State<ProDepBotWidget> createState() => _ProDepBotWidgetState();
}

class _ProDepBotWidgetState extends State<ProDepBotWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              developer.log('Card tapped.');
              developer.log(widget.updated_recomandations.length.toString());
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProDepBotHome(),
                  )
                  //builder: (context) => botMain.MyApp(),
                  //builder: (context) => ShowChatHistry(),
                  //builder: (context) => ,
                  //builder: (context) => MonthlySummary(),
                  //builder: ((context) =>
/*                   builder: (context) => UserReccomandations(
                    userRecommand: widget.updated_recomandations,
                  ), */
                  );
/*               Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => botMain.MyApp(),
                ),
              ); */
            },
            child: Container(
              width: double.infinity,
              height: 200,
              child: Row(
                children: [
                  SizedBox(
                    width: 230,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                              left: 15.0, top: 15.0, right: 15.0),
                          child: Text(
                            "Chatbot Summary",
                            style: TextStyle(
                                fontSize: 25,
                                color: Color(0xFF393737),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          "Last conversation duration:",
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF393737),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              widget.the_duration,
                              style: TextStyle(
                                  fontSize: 35,
                                  color: Color(0xFF2B87CB),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              " mins",
                              style: TextStyle(
                                  fontSize: 35,
                                  color: Color(0xFF2B87CB),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "status: ",
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFF393737),
                              ),
                            ),
                            Text(
                              widget.the_status,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: widget.the_status_color,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          width: 120,
                          'assets/images/bot.png',
                          fit: BoxFit.contain,
                        ),
                        const Text("See more >>")
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
