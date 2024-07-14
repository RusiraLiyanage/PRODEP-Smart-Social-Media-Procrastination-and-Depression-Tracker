import 'Sentiment%20Analysis/sinhala_sentiment_lexicon.dart';
import 'stringManipulation.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import 'dart:async';
import 'dart:convert';

String element = "";
var str_index;

Future<String> codeExtension(query) async {
  var strings = await StringManipulation(query);
  developer.log(strings.toString());
  for (var i = 0; i < strings.length; i++) {
    element = strings[i];
    element = element.toLowerCase();
    try {
      final response = await http.get(
        Uri.parse(
            "https://api.dictionaryapi.dev/api/v2/entries/en/" + "$element"),
        //body: jsonEncode({"message": query}),
        //headers: {"Content-Type": "application/json"},
      );
      if (element != "man" &&
          element != "mage" &&
          //element != "shape" &&
          element != "ow" &&
          element != "kale" &&
          element != "my" &&
          element != "name" &&
          element != "is" &&
          element != "use" &&
          element != "bye" &&
          element != "maha" &&
          element != "current" &&
          element != "twitter" &&
          element != "motivational") {
        if (!response.body.contains("No Definitions Found")) {
          developer.log(element);
          developer.log(strings.indexOf(element).toString());
          str_index = strings.indexOf(element);

          try {
            var convert_string = strings[str_index];
            final response = await http.post(
              Uri.parse("https://api.mymemory.translated.net/get?q=" +
                  "$convert_string" +
                  "&langpair=en|si"),
              //body: jsonEncode({"message": query}),
              //headers: {"Content-Type": "application/json"},
            );
            //developer.log(json.decode(response.body));
            Map<String, dynamic> map = json.decode(response.body);
            developer.log(map["responseData"]["translatedText"]);
            strings[str_index] = map["responseData"]["translatedText"];
            if (strings[str_index] == "SCITECH FILMS") {
              strings[str_index] = "චිත්රපට";
            }
            //strings[str_index] =
            strings[str_index] =
                strings[str_index].replaceAll("අරමුණ තමයි..", "අරමුණ");
            strings[str_index] = strings[str_index]
                .replaceAll("- ඔයා ඒකෙන් සතුටු වෙනවද ?", "තෘප්තිමත්");
            developer.log("The Strings ---> " + strings.toString());
            /* try {
                var convert_string = strings[str_index];
                final response = await http.post(
                  Uri.parse("https://api.mymemory.translated.net/get?q=" +
                      "$convert_string" +
                      "&langpair=en|si"),
                  //body: jsonEncode({"message": query}),
                  //headers: {"Content-Type": "application/json"},
                );
                //developer.log(json.decode(response.body));
                Map<String, dynamic> map = json.decode(response.body);
                developer.log(map["responseData"]["translatedText"]);
                strings[str_index] = map["responseData"]["translatedText"];
                developer.log("The Strings ---> " + strings.toString()); */
            //the_bot_result = json.decode(response.body)["answer"].toString();
          } catch (error) {
            print("Error: " + error.toString() + " on line 76");
          }
          //developer.log(resulting_string);
          //the_bot_result = json.decode(response.body)["answer"].toString();
/*             } catch (error) {
              print("Error: " + error.toString());
            } */
        } else {
          developer.log("The sentence within an array: " + strings.toString());
        }
      }

      //the_bot_result = json.decode(response.body)["answer"].toString();
    } catch (error) {
      print("Error: " + error.toString() + " on line 90");
    }
  }

  try {
    // extra modification to the Singlish text before sending it for conversion
/*       strings.forEach((element) {
        resulting_string += " $element";
      });

      developer.log("resulting string: " + resulting_string); */

    // get the converted value

    //to check wheather a word is avaliable in a String
    developer.log("The Strings ---> " + strings.toString());
    query = strings.join(" ");
    developer.log("The query ---> " + query.toString());
    query = query.toLowerCase().replaceAll("pra", "p+ra");
    query = query.toLowerCase().replaceAll("oww", "ow");
    query = query.toLowerCase().replaceAll("my name is", "magee nama");

    final response = await http.post(
      Uri.parse("https://easysinhalaunicode.com/api/convert"),
      body: {'data': query.toLowerCase().toString()},
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
    );
    //print(response.body.toString());
    /*  developer.log("Sinhala convertion: " +
        response.body.toString() +
        " , " +
        "Original: " +
        query); */
    developer.log("Sinhala convertion: " +
        response.body.toString() +
        " , " +
        "Original: " +
        query);
    return response.body.toString();
    //await sinhalaLexiconProcessing(response.body.toString());
    //the_bot_result = json.decode(response.body)["answer"].toString();
  } catch (error) {
    print("Error: " + error.toString() + " on line 132");
    return 'Error occured on code extension line number 132';
  }
}
