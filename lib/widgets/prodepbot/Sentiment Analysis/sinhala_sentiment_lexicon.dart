import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer' as developer;

sinhalaLexiconProcessing(theText) async {
  try {
    final response = await http.post(
      Uri.parse("https://874b-112-134-13-128.ap.ngrok.io" + "/sentiment"),
      body: jsonEncode({"message": theText.toLowerCase()}),
      headers: {"Content-Type": "application/json"},
    );
    developer.log("Sentiment Lexicon ---> " +
        json.decode(response.body)["lexicon"].toString());
    //the_bot_result = json.decode(response.body)["answer"].toString();
  } catch (error) {
    print("Error: " + error.toString());
  }
}
