import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prodep_client/widgets/maindate-widget.dart';
import 'package:prodep_client/widgets/prodepbot/prodepbot-widget.dart';
import 'package:prodep_client/widgets/prodepfb/prodepfb-widget.dart';
import 'package:prodep_client/widgets/prodeptwitter/prodeptwitter-widget.dart';
import 'package:prodep_client/widgets/prodepvision/prodepvision-widget.dart';
import 'package:prodep_client/widgets/userinfo-widget.dart';
import '../widgets/prodepbot/chatbot-main.dart' as botMain;
import 'dart:developer' as developer;
import 'dart:convert';
import 'package:http/http.dart' as http;

class MainScreen extends StatefulWidget {
  bool isLoading = true;
  String the_duration = "";
  String the_status = "";
  late Color the_status_color;
  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future<bool> _onWillPop() async {
    // This dialog will exit your app on saying yes
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text(
              'Are you sure?',
              style: GoogleFonts.ubuntu(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 27,
                  foreground: Paint()
                    ..shader = const LinearGradient(colors: [
                      Colors.pinkAccent,
                      Colors.deepPurpleAccent,
                      Colors.red,
                    ]).createShader(
                      Rect.fromLTWH(0.0, 0.0, 200.0, 100.0),
                    ),
                ),
              ),
            ),
            content: new Text(
              'Do you want to exit ProDep Client ?',
              textScaleFactor: 1.0,
              style: GoogleFonts.ubuntu(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
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
            actions: <Widget>[
              new FlatButton(
                onPressed: () => SystemNavigator.pop(),
                child: new Text(
                  'Yes',
                  style: GoogleFonts.ubuntu(
                    textStyle: TextStyle(
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                    ),
                  ),
                ),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text(
                  'No',
                  style: GoogleFonts.ubuntu(
                    textStyle: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }

  getData() async {
    String the_year = DateTime.now().year.toString();
    String the_month = DateTime.now().month.toString();
    try {
      final conversationStatus = await http.get(
        Uri.parse(
            "http://192.168.8.183:7027/api/DataAnalytics/getLastConversationalStatus/" +
                "${the_year}/${the_month}"),
      );
      developer.log(conversationStatus.body);
      Map<String, dynamic> result = jsonDecode(conversationStatus.body);
      widget.the_duration = result["duration"].toString();
      widget.the_status = result["status"].toString();
      developer.log("The Last Conversation Duration: " + widget.the_duration);
      developer.log("The Last Conversation Status: " + widget.the_status);
      if (widget.the_status == "Positive") {
        widget.the_status_color = Colors.green;
      }
      if (widget.the_status == "Negative") {
        widget.the_status_color = Colors.red;
      }
      if (widget.the_status == "Neutral") {
        widget.the_status_color = Colors.yellow;
      }
      var durationArray = widget.the_duration.split(" ");
      widget.the_duration = durationArray[0];
      setState(() {
        widget.isLoading = false;
      });
    } catch (error) {
      developer.log("The error: " + error.toString());
    }
  }

  getDataOnRefresh() async {
    setState(() {
      widget.isLoading = true;
    });
    await getData();
    setState(() {
      widget.isLoading = false;
    });
  }

  Scaffold makeCustomLoadingScreen() {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Image.asset("assets/images/logo.png", height: 130),
          ),

          /* SpinKitFoldingCube(
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
          ), */
          SizedBox(
            height: 25,
          ),
          Center(
            child: Text(
              "ආයුබෝවන්",
              style: GoogleFonts.notoSans(
                textStyle: TextStyle(
                  fontSize: 25,
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
    return widget.isLoading
        ? makeCustomLoadingScreen()
        : WillPopScope(
            onWillPop: _onWillPop,
            child: Scaffold(
              body: Column(
                children: <Widget>[
                  Stack(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        width: 350,
                        child: Image.asset(
                            width: 330,
                            'assets/images/pattern.png',
                            fit: BoxFit.contain),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Icon(Icons.arrow_back, size: 35),
                          ),
                          Container(
                            width: 250,
                            height: 100,
                            child: const UserInfoWidget(
                              username: '',
                              userdistrict: '',
                            ),
                          ),
                        ],
                      ),
                      MainDateWidget(),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            ProdepVisionWidget(),
                            ProdepFbWidget(),
                            ProdepTwitterWidget(),
                            ProDepBotWidget(
                              the_duration: widget.the_duration,
                              the_status: widget.the_status,
                              the_status_color: widget.the_status_color,
                            ),
                            /*     TextButton(
                          child: Text('ProDep Chatbot'),
                          onPressed: () {
                            botMain.MyApp();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => botMain.MyApp(),
                              ),
                            );
                          }), */
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
