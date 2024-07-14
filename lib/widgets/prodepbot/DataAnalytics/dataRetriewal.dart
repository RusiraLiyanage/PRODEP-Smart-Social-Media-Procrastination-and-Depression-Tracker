import 'dart:convert';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;

Future<String> retriewFromMongoDB() async {
  var the_month = DateTime.now().month;
  var the_year = DateTime.now().year;
  var the_day = DateTime.now().day;
  String the_day_string = "";
  if (the_day < 10) {
    the_day_string = "0" + the_day.toString();
  } else {
    the_day_string = the_day.toString();
  }
  try {
    final response = await http.get(
      Uri.parse(
        "http://192.168.8.183:7027/api/DataAnalytics/getLastRecomandations",
      ),
      //body: jsonEncode({"message": query}),
      //headers: {"Content-Type": "application/json"},
    );

    //var result = jsonDecode(response.body);
    //developer.log(response.body);
    return response.body;
  } catch (error) {
    developer.log(error.toString());
    return "Error occured";
  }
}
