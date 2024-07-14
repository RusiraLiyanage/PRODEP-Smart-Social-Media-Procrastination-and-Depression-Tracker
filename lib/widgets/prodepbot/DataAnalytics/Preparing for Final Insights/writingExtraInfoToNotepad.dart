import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import 'dart:convert';

Future<String> writeToNotePad(
  String userName,
  String startTime,
  String theTime,
  String theDate,
  String theMonth,
  String theYear,
  String theDuration,
) async {
  try {
    final response = await http.post(
      Uri.parse("http://192.168.8.183:5000/" + "writeExtraInfoToNotePad"),
      body: jsonEncode({
        "userName": userName,
        "startTime": startTime,
        "theTime": theTime,
        "theDate": theDate,
        "theMonth": theMonth,
        "theYear": theYear,
        "theDuration": theDuration,
      }),
      headers: {"Content-Type": "application/json"},
    );
    developer.log(json.decode(response.body));
    return response.body.toString();
  } catch (error) {
    print("Error: " + error.toString() + " on line triggerAuto.. 14");
    return "Something went wrong --> $error";
  }
}
