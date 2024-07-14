import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import 'dart:convert';

Future<String> calculateDuration(String startTime) async {
  try {
    final response = await http.get(
      Uri.parse("http://192.168.8.183:7027/api/DataAnalytics/" +
          "getUpdateDurationByTime/${startTime}"),
      //body: jsonEncode({"name": "automation triggerd for sencat process"}),
      headers: {"Content-Type": "application/json"},
    );
    //developer.log(json.decode(response.body));
    return response.body.toString();
  } catch (error) {
    print("Error: " + error.toString() + " on line triggerAuto.. 14");
    return "Something went wrong --> $error";
  }
}
