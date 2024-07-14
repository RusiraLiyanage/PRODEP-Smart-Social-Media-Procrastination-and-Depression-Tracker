import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import 'dart:convert';

Future<void> triggerAutomation() async {
  try {
    final response = await http.post(
      Uri.parse("http://192.168.8.183:5000" + "/automation-sencat"),
      body: jsonEncode({"name": "automation triggerd for sencat process"}),
      headers: {"Content-Type": "application/json"},
    );
    developer.log(json.decode(response.body)["message"]);
    await Future.delayed(
      const Duration(seconds: 120),
    );
  } catch (error) {
    print("Error: " + error.toString() + " on line triggerAuto.. 14");
  }
}

Future<void> triggerAutomation2() async {
  try {
    final response = await http.post(
      Uri.parse("http://192.168.8.183:5000" + "/automation-sentiment"),
      body: jsonEncode(
          {"name": "automation triggerd for sentiment analysis process"}),
      headers: {"Content-Type": "application/json"},
    );
    developer.log(json.decode(response.body)["message"]);
    // letting the process to end from a delay timer
    await Future.delayed(
      const Duration(seconds: 100),
    );
    developer.log("The timer is over");
  } catch (error) {
    print("Error: " + error.toString() + " on line triggerAuto.. 28");
  }
}
