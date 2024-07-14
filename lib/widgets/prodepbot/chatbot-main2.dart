import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  void theTranslation(theQuery) async {
    try {
      final response = await http.post(
        Uri.parse("https://easysinhalaunicode.com/api/convert"),
        body: jsonEncode({"data": theQuery}),
        headers: {"Content-Type": "application/json"},
      );
      print(json.decode(response.body));
      //the_bot_result = json.decode(response.body)["answer"].toString();
    } catch (error) {
      print("Error: " + error.toString());
    }
  }

  theTranslation("adha subha dhavasak");
}
