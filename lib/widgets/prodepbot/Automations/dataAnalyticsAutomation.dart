import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import 'dart:convert';

String outcome = "";

Future<String> triggerDataAnalyticsAutomation() async {
  try {
    final response = await http.post(
      Uri.parse("http://192.168.8.183:5000" + "/automation-data-analytics"),
      body: jsonEncode(
          {"name": "automation triggerd for data analytics process"}),
      headers: {"Content-Type": "application/json"},
    );
    developer.log(json.decode(response.body)["message"]);
    outcome = json.decode(response.body)["message"];
    await Future.delayed(
      const Duration(seconds: 20),
    );
    return outcome;
    // letting the process to end from a delay timer
    /*  await Future.delayed(
      const Duration(minutes: 1),
    ); */
  } catch (error) {
    print("Error: " +
        error.toString() +
        " on line triggerDataAnalyticsAuto.. 25");
    return "Error: " +
        error.toString() +
        " on line triggerDataAnalyticsAuto.. 25";
  }
}

Future<String> triggerDataAnalyticsAutomation2() async {
  try {
    final response = await http.post(
      Uri.parse(
          "http://192.168.8.183:5000" + "/automation-data-analytics-sencat"),
      body: jsonEncode(
          {"name": "automation triggerd for data analytics process"}),
      headers: {"Content-Type": "application/json"},
    );
    developer.log(json.decode(response.body)["message"]);
    outcome = json.decode(response.body)["message"];
    return outcome;
    // letting the process to end from a delay timer
    /*  await Future.delayed(
      const Duration(minutes: 1),
    ); */
  } catch (error) {
    print("Error: " +
        error.toString() +
        " on line triggerDataAnalyticsAuto.. 50");
    return "Error: " +
        error.toString() +
        " on line triggerDataAnalyticsAuto.. 50";
  }
}
