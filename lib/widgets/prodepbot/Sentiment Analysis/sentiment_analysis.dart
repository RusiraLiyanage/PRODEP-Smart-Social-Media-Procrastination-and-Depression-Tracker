import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import 'dart:convert';

String? the_result;
String? the_response;
//var myHeaders = new Headers();

Map<String, String> requestHeaders = {
  'Content-type': 'application/json',
  'Accept': 'application/json',
  'apikey': 'cKcyIU85z5Us6tbb5OpvMZ1mlSmGil2a'
};

/* var requestOptions = {
  'method': 'POST',
  'redirect': 'follow',
  'headers': requestHeaders,
  'body': 'raw'
}; */

AnalyseTheSentiment(String message) async {
  try {
    final response = await http.post(
      Uri.parse("https://api.apilayer.com/sentiment/analysis"),
      body: jsonEncode(message),
      headers: requestHeaders,
    );
    the_response = json.decode(response.body).toString();
    the_result = json.decode(response.body)["sentiment"].toString();
    developer.log("The Result: " + the_response!);
    developer.log("The Sentiment: " + the_result!);
  } catch (error) {
    developer.log(error.toString());
  }
}
