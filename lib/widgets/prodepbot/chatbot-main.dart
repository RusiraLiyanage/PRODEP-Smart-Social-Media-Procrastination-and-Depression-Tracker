import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
//import 'dart:js_util';
import 'dart:math';

import 'package:bubble/bubble.dart';
import 'package:prodep_client/screens/main-screen.dart';
import 'package:prodep_client/widgets/prodepbot/Automations/dataAnalyticsAutomation.dart';
import 'package:prodep_client/widgets/prodepbot/DataAnalytics/Preparing%20for%20Final%20Insights/writingExtraInfoToNotepad.dart';
import 'package:prodep_client/widgets/prodepbot/ProDepBot%20Home/proDepBotHome.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import 'Automations/triggerAutomation.dart';
import 'DataAnalytics/Preparing for Final Insights/calculateDuration.dart';
import 'DataAnalytics/dataRetriewal.dart';
import 'DataAnalytics/showAnalytics.dart';
import 'Sentiment%20Analysis/sentiment_analysis.dart';
import 'Show%20Snackbars/show_Snackbar.dart';
import 'showSnackBar.dart';
import 'stringManipulation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_js/flutter_js.dart';
import 'package:flutter_js/javascriptcore/jscore_runtime.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:splashscreen/splashscreen.dart';
import 'dart:developer' as developer;
import 'codeExtension.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_spinkit/src/dual_ring.dart';
import 'package:another_flushbar/flushbar.dart';

final JavascriptRuntime jsRuntime = getJavascriptRuntime();
var count = 0;
var auth_count = 0;
var name_counter = 0;
String user_name = "";
String the_bot_result = "";
String theReplyMessage = "";
String resulting_string = "";
String element = "";
String nameString = "";
bool count_exceeds = false;
bool count_exceeds_called = false;
bool upset_called = false;
bool seasson_over = false;
File? f;
String jsonData = "";
var user_reponses = [];
var original_responses = [];
var displaying_bot_message = "";
var data;
var str_index;
var global_error;
var dateTime;
var dateTime2;
String retunedValue = "";
DateTime user_start_time = new DateTime(0, 0, 0, 0, 0);
String start_time_in_string = "";
String calculated_duration = "";
String the_time_in_practical_format = "";
String the_conversation_date = "";
String conversation_month = "";
String conversation_year = "";
bool analyticsWelcome = false;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.blue,
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(
        seconds: 2,
        navigateAfterSeconds: MyHomePage(title: 'Flutter Demo Home Page'),
        loadingText: Text(
          "Welcome",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
        ),
        useLoader: false,
        imageBackground: AssetImage("assets/images/17788054.jpg"),
        title: Text(
          "PRODEP \n Singlish Chatbot \n 🤖",
          style: TextStyle(
            fontFamily: 'DynaPuff',
            fontWeight: FontWeight.bold,
            fontSize: 60.0,
            //color: Colors.blue,
            foreground: Paint()
              ..shader = LinearGradient(
                colors: [
                  Colors.pinkAccent,
                  Colors.deepPurpleAccent,
                  Colors.red,
                ],
              ).createShader(
                Rect.fromLTWH(100.0, 50.0, 100.0, 50.0),
              ),
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.black12,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

// This widget is the home page of your application. It is stateful, meaning
// that it has a State object (defined below) that contains fields that affect
// how it looks.

// This class is the configuration for the state. It holds the values (in this
// case the title) provided by the parent (in this case the App widget) and
// used by the build method of the State. Fields in a Widget subclass are
// always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String theReply = "";
  //JavascriptRuntime jsRuntime;
  Future<String> getTestReply(
      JavascriptRuntime jsRuntime, String testReply) async {
    print(testReply);
    String appJs = await rootBundle.loadString("assets/theTest.js");
    //final theEquation = "sendReply($testReply)";
    final jsResult =
        jsRuntime.evaluate(appJs + """sendReply("${testReply}")""");
    print(jsResult);
    final jsStringResult = jsResult.stringResult;
    final yooReply = jsStringResult.toString();
    return jsStringResult;
  }

  Future<String> getBotReply(String userReply) async {
    String appJs = await rootBundle.loadString(
        "assets/Business Logic/chatbot-deployment-main/static/app2.js");
    final jsResult = await jsRuntime.evaluate(appJs +
        """onSendButton("${userReply}","${count}", "${name_counter}")""");
    final jsStringResult = jsResult.stringResult;
    count++;
    name_counter++;
    return jsStringResult;
  }

  Future<String> saveResponse(theData) async {
    String appJs = await rootBundle.loadString(
        "assets/Business Logic/chatbot-deployment-main/readWrite.js");
    final jsResult =
        await jsRuntime.evaluate(appJs + """writeUpdate("${theData}")""");
    final jsStringResult = jsResult.stringResult;
    print(jsStringResult);
    return jsStringResult;
  }

  @override
  void initState() {
    super.initState();
    messsages.insert(0, {
      "data": 0,
      "message":
          "Sanvadaya aramba keerima sandaaha obage nama atulath karanna :)"
    });
    displaying_bot_message =
        "Sanvadaya aramba keerima sandaaha obage nama atulath karanna :)";
    CleanUpTheSpace();
    WidgetsBinding.instance.addPostFrameCallback((_) => makeAnWelcome());
    //makeAnWelcome();
  }

  void getByeReply() {
    theReplyMessage = "Goodbye :)";
  }

  void makeAnWelcome() {
    Flushbar(
            message: 'ආයුබෝවන්',
            messageSize: 20,
            messageColor: Colors.white,
            forwardAnimationCurve: Curves.easeInBack,
            borderColor: Colors.black26,
            duration: Duration(seconds: 4),
            flushbarStyle: FlushbarStyle.FLOATING,
            flushbarPosition: FlushbarPosition.TOP)
        .show(context);
  }

  cleaningBeforeGeneratingReport(theResponse) {
    theResponse = theResponse.toString().replaceAll("mage namma ", "");
    theResponse = theResponse.toString().replaceAll("magge nama ", "");
    theResponse = theResponse.toString().replaceAll("magge namma ", "");
    theResponse = theResponse.toString().replaceAll("magee nama ", "");
    theResponse = theResponse.toString().replaceAll("magea nama ", "");
    theResponse = theResponse.toString().replaceAll("my name is ", "");
    return theResponse.toString();
  }

  makeCustomLoadingScreen() {
    return Column(
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
            "Generating ....\nFinal Results !!",
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
    );
  }

  void response(String query) async {
    query = query.toLowerCase().replaceAll(",", " ");
    original_responses.add(query); //to cleanup the user's response
    if (name_counter == 0) {
      user_name = query;
      var name_retreval = await StringManipulation(user_name);
      user_name = name_retreval.join(" ");
      user_name = user_name.toLowerCase().replaceAll("mage nama ", "");
      user_name = user_name.toLowerCase().replaceAll("mage namma ", "");
      user_name = user_name.toLowerCase().replaceAll("magge nama ", "");
      user_name = user_name.toLowerCase().replaceAll("magge namma ", "");
      user_name = user_name.toLowerCase().replaceAll("magee nama ", "");
      user_name = user_name.toLowerCase().replaceAll("magea nama ", "");
      user_name = user_name.toLowerCase().replaceAll("my name is ", "");
      query = query.toLowerCase().replaceAll("kridaa", "k+ridaa");
      developer.log("To check query --> $query");
      var user_name2 = user_name[0].toUpperCase();
      user_name = user_name.replaceFirst(user_name[0], "");
      user_name = user_name2 + user_name;
      user_start_time = DateTime.now();
      start_time_in_string =
          DateFormat("MM-dd-yyyy HH:mm:ss").format(user_start_time);
      developer.log("User start time: " + start_time_in_string);
      the_time_in_practical_format =
          new DateFormat.jm().format(user_start_time);
      developer
          .log("The start time in 12 hours: " + the_time_in_practical_format);
      if (int.parse(DateTime.now().day.toString()) < 10) {
        the_conversation_date = DateTime.now().month.toString() +
            "/0" +
            DateTime.now().day.toString() +
            "/" +
            DateTime.now().year.toString();
      } else {
        the_conversation_date = DateTime.now().month.toString() +
            "/" +
            DateTime.now().day.toString() +
            "/" +
            DateTime.now().year.toString();
      }
      conversation_month = DateTime.now().month.toString();
      conversation_year = DateTime.now().year.toString();
      name_counter++;
    }

    jsonData =
        '{ "Bot Message": "${displaying_bot_message}", "User\'s Reply": "${query}"}';

    var questions = [
      "Obage wayasa kopamana weiida ?",
      user_name + " , adha dhavasa obata kohomadha :) ?",
      "Ada davase oyage wadda plan ekata anuwa wenavadda (wistratmakava pawasanna) ?",
      "matta kiyanna oya adda kochara wella facebook use kalada ? (option ekuk select karanna) \n 1. 1 to 2 hours \n 2. 3 to 4 hours \n 3. more than 4 hours \n 4. use kalle nahha",
      "mona wagge contents da oyya facebook ekke wadiyenma dakkke ?",
      user_name + " , matta kiyanna Oya adda mona hari upset ekenda inne ?",
      //"adda davase obagae twitter baavitaya pilibandha yamak pawasanna...",
      user_name + " , oya mea welave hodinda inne ? :)",
      "oya dinapatha sports walla yedenavada ?",
      //"adda davasse mea wenakun oyya kochara welavak movies baluwada ? mona wage movies da baluwe ?",
      //"oya movies balanne kammali hinda da nattam karanna wadak nati hinda da ehemath nattam .... ?",
      //"oyya samanayen books kiyawanavada ? books dinapatha kiyaweema gana mokada hitanne ?",
      user_name +
          " , oyyage adda davasse goal ekuk tiyenavada ? ekka sampoorna kara ganna oyya lassthida ? :)",
      "oya social media use karanne mona wage popurses walatada ?",
      "matta kiyanna oyyge adda davasa gatta wenna vidiha ganna oya mona widihatada satisfy wenne? :)",
      user_name +
          " , avasanna washyen obata mona hari avul sahagata prashnayak / hageemak tibenum eya maa hata pawasanna, kenekta pawaseemen oabage manasa nidahas wenava :) ",
      "Sanvadayata sambandha vunata godaaak stuthii.. obata Suba davasak weewwa " +
          user_name +
          " !! Neerogiyawa sitinna :)"
    ];
    context.loaderOverlay.show();
    try {
      final response = await http.post(
        Uri.parse("http://192.168.8.183:5000" + "/predict"),
        body: jsonEncode({"message": query.toLowerCase()}),
        headers: {"Content-Type": "application/json"},
      );
      print(json.decode(response.body)["answer"]);
      the_bot_result = json.decode(response.body)["answer"].toString();
    } catch (error) {
      print("Error: " + error.toString() + " on line main 335");
    }
    try {
      auth_count = count;
      if (count >= 13) {
        count_exceeds = true;
        developer.log(
            "[Debugging] ---> line number 202 called for array count - $count");
      }

      if (count >= 7 && (query == "ow" || query == "oww")) {
        //questions[count] = questions[count];
        String correctQuestion = questions[count];
        questions[count] = correctQuestion;
        developer.log(
            "[Debugging] ---> line number 210 called for array count - $count");
      } else {
        if (the_bot_result != "Matta Therunne naha...") {
          if (count >= 1) {
            if (questions[count - 1] ==
                user_name +
                    " , matta kiyanna Oya adda mona hari upset ekenda inne ?") {
              if (query.contains("upset") ||
                  query.contains("ow") ||
                  query.contains("oww")) {
                questions[count] =
                    "Matta kiyanna oyya upset ekken inna hetuwa :)";
              }
            }
          }
          if (the_bot_result ==
                  "Matta kiyanna oyya upset ekken inna hetuwa :)" &&
              (count == 5)) {
            questions[count] = the_bot_result;
            developer.log(
                "[Debugging] ---> line number 218 called for array count - $count");
          } else {
            if (the_bot_result !=
                "Matta kiyanna oyya upset ekken inna hetuwa :)") {
              developer.log(
                  "[Debugging] ---> line number 223 called for array count - $count");
              if (!count_exceeds) {
                questions[count] = the_bot_result + " " + questions[count];
                developer.log(
                    "[Debugging] ---> line number 227 called for array count - $count");
              } else {
                questions[count] = the_bot_result;
                developer.log(
                    "[Debugging] ---> line number 231 called for array count - $count");
              }
            } else {
              if (!count_exceeds) {
                questions[count] = questions[count];
                developer.log(
                    "[Debugging] ---> line number 237 called for array count - $count");
              } else {
                questions[count] = the_bot_result;
                developer.log(
                    "[Debugging] ---> line number 241 called for array count - $count");
              }
            }
          }
          if (questions[count] ==
              "Matta kiyanna oyya upset ekken inna hetuwa :) matta kiyanna oya adda kochara wella facebook use kalada ? (option ekuk select karanna) \n 1. 1 to 2 hours \n 2. 3 to 4 hours \n 3. more than 4 hours \n 4. use kalle nahha") {
            questions[count] =
                "matta kiyanna oya adda kochara wella facebook use kalada ? (option ekuk select karanna) \n 1. 1 to 2 hours \n 2. 3 to 4 hours \n 3. more than 4 hours \n 4. use kalle nahha";
            developer.log(
                "[Debugging] ---> line number 250 called for array count - $count");
          }
          if (count == 13) {
            questions[count] = ":)";
            developer.log(
                "[Debugging] ---> line number 255 called for array count - $count");
          }
        } else {
          if (count == 13) {
            questions[count] = ":)";
            developer.log(
                "[Debugging] ---> line number 261 called for array count - $count");
          }
        }
      }

      if (the_bot_result ==
              "hondai :) facebook use kalle nati vunata kamak naha " &&
          original_responses.contains("4")) {
        questions[count] = the_bot_result + " " + questions[count + 1];
        developer.log(
            "[Debugging] ---> line number 271 called for array count - $count");
      }

      if (count_exceeds) {
        questions[count] = ":)";
        developer.log(
            "[Debugging] ---> line number 277 called for array count - $count");
      }

      theReplyMessage = questions[count];
    } catch (error) {
      print(error);
      global_error = error;
      developer.log("The Global error: " + global_error.toString());
      retunedValue = await codeExtension(query);
      user_reponses.add(retunedValue);

      if (the_bot_result != "Matta Therunne naha...") {
        theReplyMessage = the_bot_result;
      } else {
        theReplyMessage = ":)";
      }

      context.loaderOverlay.hide();
      await Future.delayed(
        const Duration(milliseconds: 84),
      );

      setState(() {
        messsages.insert(0, {"data": 0, "message": theReplyMessage});
      });
      if (theReplyMessage.contains(questions[12])) {
        developer.log("Came into the catch block");
      }
      if (count_exceeds) {
        developer.log("Yes count is exceeding :)--> ");
        count_exceeds_called = true;
      }
    }
    // -----------------------------------------------------------------------------------
    developer.log("yooo ->>>> executed after the catch block");
    try {
      String replaced = jsonData.replaceAll('\n', '');
      data = jsonDecode(replaced);
      var stringified = await saveResponse(data);
    } catch (error) {
      print("Error: " + error.toString() + " on line main 575");
    }

    if (count >= 6 && (query == "ow" || query == "oww")) {
      count++;
      developer.log(
          "[Debugging] ---> line number 308 called for array count - $count");
    }
    developer.log(
        "[Debugging] ---> line number 312 called for array count - $count");
    if (the_bot_result == "Matta kiyanna oyya upset ekken inna hetuwa :)" &&
        (count == 5)) {
      //count++;
      upset_called = true;
      developer.log(
          "[Debugging] ---> line number 315 called for array count - $count");
    }
    if (count >= 1) {
      if (questions[count - 1] ==
          user_name +
              " , matta kiyanna Oya adda mona hari upset ekenda inne ?") {
        if (query.contains("upset") ||
            query.contains("ow") ||
            query.contains("oww")) {
          upset_called = true;
        }
      }
    }

    if (the_bot_result ==
            "hondai :) facebook use kalle nati vunata kamak naha " &&
        original_responses.contains("4")) {
      count = count + 2;
      developer.log(
          "[Debugging] ---> line number 323 called for array count - $count");
    }

    if (questions[count] ==
        "Matta kiyanna oyya upset ekken inna hetuwa :) matta kiyanna oya adda kochara wella facebook use kalada ? (option ekuk select karanna) \n 1. 1 to 2 hours \n 2. 3 to 4 hours \n 3. more than 4 hours \n 4. use kalle nahha") {
      count++;
      developer.log(
          "[Debugging] ---> line number 330 called for array count - $count");
    }

    if (auth_count == count && !upset_called) {
      count++;
      developer.log(
          "[Debugging] ---> line number 339 called for array count - $count");
    } else if (auth_count < count) {
      print("count variable is already incremented");
      developer.log(
          "[Debugging] ---> line number 341 called for array count - $count");
      developer.log(
          "[Debugging] ---> line number 343 called for array auth_count - $auth_count");
    }
    upset_called = false;
    //count++;
    developer.log(
        "[Debugging] ---> line number 349 called for array count - $count");
    // thi is done to clear the bot reply to avoid colids in if checks.
    displaying_bot_message = theReplyMessage;
    the_bot_result = "";
// ----------------------------------------------------------------------------------------------------- //
    if (global_error == null) {
      developer.log("yesss ---> called ");
      retunedValue = await codeExtension(query);
      user_reponses.add(retunedValue);
      var message = "හොද දවසක්";

      context.loaderOverlay.hide();
      await Future.delayed(
        const Duration(milliseconds: 84),
      );
      setState(() {
        messsages.insert(0, {"data": 0, "message": theReplyMessage});
      });
      if (theReplyMessage.contains(questions[12])) {
        if (!user_reponses[0].toString().contains("mage namma ") ||
            !user_reponses[0].toString().contains("magge nama ") ||
            !user_reponses[0].toString().contains("magge namma ") ||
            !user_reponses[0].toString().contains("magee nama ") ||
            !user_reponses[0].toString().contains("magea nama ") ||
            !user_reponses[0].toString().contains("my name is ")) {
          user_reponses[0] =
              await cleaningBeforeGeneratingReport(user_reponses[0]);
          user_reponses[0] = "මගේ නම " + user_reponses[0];
        }
        seasson_over = true;
        count_exceeds_called = true;
        await Future.delayed(
          const Duration(seconds: 1),
        );
        context.loaderOverlay.show();
        // ------------------ where async operation starts ---------------------------------
        // Calculating the duration
        String durationResponse = await calculateDuration(start_time_in_string);
        calculated_duration = durationResponse;
        /* calculated_duration =
            await calculateDuration(start_time_in_string) as String; */
        developer.log("User's conversation duration: " + calculated_duration);
        // Writing important extra information to the notepad
        developer.log("UserName: " + user_name);
        developer.log("Start Tiem: " + start_time_in_string);
        developer.log("The Time: " + the_time_in_practical_format);
        developer.log("The Date: " + the_conversation_date);
        developer.log("The Month: " + conversation_month);
        developer.log("The year: " + conversation_year);
        developer.log("The Duration: " + calculated_duration);

        await writeToNotePad(
          user_name,
          start_time_in_string,
          the_time_in_practical_format,
          the_conversation_date,
          conversation_month,
          conversation_year,
          calculated_duration,
        );
        // calling rest of the work
        await theWorkAtTheEndOfSeasson2();
        // -------------------- where the async operation ends -----------------------------
        context.loaderOverlay.hide();
        Flushbar(
                message: 'ස්තූතියි',
                messageSize: 20,
                messageColor: Colors.white,
                forwardAnimationCurve: Curves.easeInBack,
                borderColor: Colors.black26,
                duration: const Duration(seconds: 4),
                flushbarStyle: FlushbarStyle.FLOATING,
                flushbarPosition: FlushbarPosition.TOP)
            .show(context);
        // make a timing and navigating into the analytics page
        await Future.delayed(
          const Duration(seconds: 2),
        );
        setState(() {
          analyticsWelcome = true;
        });
        await Future.delayed(
          const Duration(seconds: 3),
        );
        setState(() {
          analyticsWelcome = false;
        });
        Navigator.push(
          context,
          SwipeablePageRoute(
            builder: (context) => ShowAnalytics(),
          ),
        );
      }
    }
  }

  void restartTheSeasson() {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text(
                "Restart",
                style: GoogleFonts.ubuntu(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 27,
                    foreground: Paint()
                      ..shader = LinearGradient(colors: [
                        Colors.pinkAccent,
                        Colors.deepPurpleAccent,
                        Colors.red,
                      ]).createShader(
                        Rect.fromLTWH(0.0, 0.0, 200.0, 100.0),
                      ),
                  ),
                ),
              ),
              content: Text(
                "Are you sure you wanna start over ? :)",
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
              actions: [
                TextButton(
                    child: Text(
                      "Yes",
                      style: GoogleFonts.ubuntu(
                        textStyle: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                        ),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        messsages.clear();
                        messsages.insert(0, {
                          "data": 0,
                          "message":
                              "Sanvadaya aramba keerima sandaaha obage nama atulath karanna :)"
                        });
                        count = 0;
                        name_counter = 0;
                        auth_count = 0;
                        user_name = "";
                        the_bot_result = "";
                        theReplyMessage = "";
                        count_exceeds = false;
                        count_exceeds_called = false;
                        jsonData = "";
                        user_reponses.clear();
                        original_responses.clear();
                        displaying_bot_message = "";
                        global_error = null;
                        seasson_over = false;
                        upset_called = false;
                        start_time_in_string = "";
                        calculated_duration = "";
                        the_time_in_practical_format = "";
                        the_conversation_date = "";
                        conversation_month = "";
                        conversation_year = "";
                        analyticsWelcome = false;
                      });
                      Navigator.of(ctx).pop();
                      final snackBar = SnackBar(
                        backgroundColor: Colors.black54,
                        elevation: 3,
                        duration: Duration(seconds: 2),
                        content: Text(
                          "Conversation Restarted !!",
                          style: GoogleFonts.notoSans(
                            textStyle: TextStyle(
                              fontSize: 16.5,
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
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }),
                TextButton(
                    child: Text(
                      "No",
                      style: GoogleFonts.ubuntu(
                        textStyle: TextStyle(
                          color: Colors.yellow,
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      showSnackBar(ctx);
                    })
              ],
            ));
  }

  Future<void> theWorkAtTheEndOfSeasson() async {
    dateTime = new DateFormat('MM-dd-yyyy hh-mm-ss');
    dateTime2 = new DateFormat('MM-dd-yyyy');
    nameString = "$dateTime2/FinalResults $dateTime.json";
    //09-17-2022/FinalResults 09-17-2022
    try {
      final response = await http.post(
        Uri.parse("http://localhost:5000" + "/add"),
        body: jsonEncode({"name": nameString, "array": user_reponses}),
        headers: {"Content-Type": "application/json"},
      );
      developer.log(json.decode(response.body)["message"]);
    } catch (error) {
      print("Error: " + error.toString() + " on line main 942");
    }
    await triggerAutomation();
    developer.log("Automation triggerd");
    var endResult = await triggerDataAnalyticsAutomation2();
    developer.log("Data Analytics automation successfully triggerd");
    user_reponses.clear();
  }

  Future<void> theWorkAtTheEndOfSeasson2() async {
    dateTime = new DateFormat('MM-dd-yyyy hh-mm-ss');
    dateTime2 = new DateFormat('MM-dd-yyyy');
    nameString = "$dateTime2/FinalResults $dateTime.json";
    try {
      final response = await http.post(
        Uri.parse("http://192.168.8.183:5000" + "/sinhala-english"),
        body: jsonEncode({"name": nameString, "array": user_reponses}),
        headers: {"Content-Type": "application/json"},
      );
      developer.log(json.decode(response.body)["message"]);
    } catch (error) {
      print("Error: " + error.toString() + " on line main 979");
    }
    await triggerAutomation2();
    developer.log("Automation 2 successfully finished");
    var endResult = await triggerDataAnalyticsAutomation();
    developer.log("Data Analytics automation successfully finished");
    user_reponses.clear();
  }

  Scaffold makeAnalyticsWelcome() {
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
              "Opening Results .......",
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

  void CleanUpTheSpace() {
    count = 0;
    name_counter = 0;
    auth_count = 0;
    user_name = "";
    the_bot_result = "";
    theReplyMessage = "";
    count_exceeds = false;
    count_exceeds_called = false;
    jsonData = "";
    user_reponses.clear();
    original_responses.clear();
    displaying_bot_message = "";
    global_error = null;
    seasson_over = false;
    upset_called = false;
    start_time_in_string = "";
    calculated_duration = "";
    the_time_in_practical_format = "";
    the_conversation_date = "";
    conversation_month = "";
    conversation_year = "";
    analyticsWelcome = false;
  }

  Future<bool> _onWillPop() async {
    bool status = false;
    // This dialog will exit your app on saying yes
    await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text(
          'You wanna go back Home Page?',
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
          'The changes wouldn\'t be saved!',
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
            onPressed: () {
              Navigator.of(context).pop(false);
              status = false;
            },
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
          new FlatButton(
            onPressed: () {
              CleanUpTheSpace();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ProDepBotHome(),
                ),
              );
              //status = true;
            },
            child: new Text(
              'Yes',
              style: GoogleFonts.ubuntu(
                textStyle: TextStyle(
                  color: Colors.yellowAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    return status;
  }

  final messageInsert = TextEditingController();
  List<Map> messsages = <Map>[];

  @override
  Widget build(BuildContext context) {
    return analyticsWelcome
        ? makeAnalyticsWelcome()
        : WillPopScope(
            onWillPop: _onWillPop,
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  "ProDep Singlish Chatbot",
                  textScaleFactor: 1.1,
                  //textWidthBasis: TextWidthBasis.parent,
                  style: GoogleFonts.notoSans(
                    textStyle: TextStyle(
                      //color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 21,
                      foreground: Paint()
                        ..shader = LinearGradient(colors: [
                          Colors.pinkAccent,
                          Colors.deepPurpleAccent,
                          Colors.red,
                        ]).createShader(
                          Rect.fromLTWH(100.0, 50.0, 100.0, 50.0),
                        ),
                    ),
                  ),
                ),
              ),
              body: LoaderOverlay(
                useDefaultLoading: false,
                overlayWidget: Center(
                  child: seasson_over
                      ? makeCustomLoadingScreen()
                      : Center(
                          child: SpinKitFadingCube(
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
                                  shape: BoxShape.circle,
                                ),
                              );
                            },
                            size: 100.0,
                          ),
                        ),
                ),
                overlayColor: Colors.black,
                overlayOpacity: 0.7,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      //matchTextDirection: true,
                      filterQuality: FilterQuality.low,
                      colorFilter: ColorFilter.mode(
                        Colors.black,
                        BlendMode.screen,
                      ),
                      //image: AssetImage("assets/3bb074f5e7ff82cfa76c0b42e00176ba.jpg"),
                      image: AssetImage(
                          "assets/images/781e212cb0a891c6d8a3738c525e235d.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        color: Colors.black26,
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(top: 15, bottom: 10),
                        child: Text(
                          "Appi apage manasika savukaya manavin pavatvva ganimu :) ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 17.5,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()..color = Colors.blue,
                            fontFamily: 'DynaPuff',
                          ),
                        ),
                      ),
                      Flexible(
                        child: ListView.builder(
                          reverse: true,
                          itemCount: messsages.length,
                          itemBuilder: (context, index) => chat(
                            messsages[index]["message"].toString(),
                            messsages[index]["data"],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(
                        height: 7.0,
                        color: Colors.blueAccent,
                        thickness: 3,
                      ),
                      Container(
                        child: ListTile(
                          leading: IconButton(
                              icon: Icon(
                                Icons.restart_alt_sharp,
                                color: Colors.purpleAccent,
                                size: 35,
                              ),
                              onPressed: () {
                                restartTheSeasson();
                              }),
                          title: Container(
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14)),
                              color: Color.fromRGBO(220, 220, 220, 1),
                            ),
                            padding: EdgeInsets.only(left: 15),
                            child: TextFormField(
                              maxLines: 1,
                              showCursor: true,
                              autofocus: false,
                              controller: messageInsert,
                              decoration: InputDecoration(
                                hintText: "Enter a Message...",
                                hintStyle: TextStyle(
                                  color: Colors.black26,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'DynaPuff',
                                  fontSize: 15.45,
                                ),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                                fontFamily: 'DynaPuff',
                              ),
                              onChanged: (value) {},
                            ),
                          ),
                          trailing: IconButton(
                              icon: Icon(
                                Icons.send,
                                size: 30.0,
                                color: Colors.purpleAccent,
                              ),
                              onPressed: () async {
                                if (messageInsert.text.isEmpty) {
                                  print("empty message");
                                  final snackBar2 = SnackBar(
                                    backgroundColor: Colors.black54,
                                    elevation: 3,
                                    duration: Duration(seconds: 1),
                                    content: Text(
                                      "Type your message :)",
                                      style: GoogleFonts.notoSans(
                                        textStyle: TextStyle(
                                          fontSize: 16.5,
                                          fontWeight: FontWeight.bold,
                                          foreground: Paint()
                                            ..shader = LinearGradient(colors: [
                                              Colors.pinkAccent,
                                              Colors.deepPurpleAccent,
                                              Colors.red,
                                            ]).createShader(
                                              Rect.fromLTWH(
                                                  5.0, 5.0, 200.0, 50.0),
                                            ),
                                        ),
                                      ),
                                    ),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar2);
                                } else {
                                  if (!count_exceeds_called) {
                                    setState(() {
                                      messsages.insert(0, {
                                        "data": 1,
                                        "message": messageInsert.text
                                      });
                                    });
                                    response(messageInsert.text);
                                    // ----------------------------------
                                    //var response = await retriewFromMongoDB();
                                    // Map<String, dynamic> result =
                                    //     jsonDecode(response);
                                    // developer.log(result["Recomandations"]);
                                    // -----------------------------------
                                    //var recomandations =
                                    //jsify(result["Recomandations"]);
                                    //var yups =
                                    // "{\"Recomandations\": ${result["Recomandations"]}}";
                                    //var recomandations = jsonDecode(yups);
                                    //developer.log(recomandations);
                                    //var recomandations =
                                    // jsonDecode(result["Recomandations"]);
                                    //developer.log(recomandations);
                                    //developer.log(response);
                                    //var reply = jsonDecode(response);
                                    //developer.log(reply);
                                    //developer
                                    //  .log(reply("Total number of sentiments"));
                                    messageInsert.clear();
                                  } else {
                                    if (!seasson_over) {
                                      developer.log("---> yes it was called");
                                      seasson_over = true;
                                      messageInsert.clear();
                                      ShowSnackBar(
                                          "Press Restart to Start Over :)",
                                          context);
                                    } else {
                                      developer.log("---> yes it was called");
                                      messageInsert.clear();
                                      ShowSnackBar(
                                          "Press Restart to Start Over :)",
                                          context);
                                    }
                                  }
                                }
                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                              }),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  Widget chat(String message, int data) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment:
                  data == 1 ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                data == 0
                    ? Container(
                        height: 60,
                        width: 60,
                        child: CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/robot.jpg"),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.blue.shade300,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.blue.shade600,
                                  blurRadius: 12,
                                  spreadRadius: 3,
                                  offset: Offset(0, 7))
                            ]),
                      )
                    : Container(),
                Padding(
                  padding: EdgeInsets.fromLTRB(2, 2, 2, 10),
                  child: Bubble(
                      radius: Radius.circular(15.0),
                      color: data == 0
                          ? Colors.blue.shade600
                          : Colors.purple.shade600,
                      elevation: 0.0,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(2, 2, 2, 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(
                              width: 10.0,
                            ),
                            Flexible(
                              child: Container(
                                constraints: BoxConstraints(maxWidth: 172),
                                child: Text(
                                  message,
                                  style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.05,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                ),
                data == 1
                    ? Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          height: 60,
                          width: 60,
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/images/default.jpg"),
                            backgroundColor: Colors.white,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.purple.shade300,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.purple.shade600,
                                    blurRadius: 12,
                                    spreadRadius: 2,
                                    offset: Offset(10, 3))
                              ]),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
