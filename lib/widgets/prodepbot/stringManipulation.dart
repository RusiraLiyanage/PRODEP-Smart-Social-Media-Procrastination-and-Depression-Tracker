import 'dart:developer' as developer;

List<String> StringManipulation(String sentence) {
  sentence = sentence.replaceAll("  ", " ");
  sentence = sentence.replaceAll("   ", " ");
  sentence = sentence.replaceAll("    ", " ");

  var the_sen2 = sentence.split(" ");
  developer.log(the_sen2.toString());
  for (var i = 0; i < the_sen2.length; i++) {
    developer.log(the_sen2[i].length.toString());
    if (the_sen2[i].length == 0) {
      the_sen2.remove(the_sen2[i]);
    }
    developer.log(the_sen2.toString());
  }
  developer.log(the_sen2.toString());
  for (var i = 0; i < the_sen2.length; i++) {
    developer.log(the_sen2[i].length.toString());
    if (the_sen2[i].length == 0) {
      the_sen2.remove(the_sen2[i]);
    }
  }
  developer.log(the_sen2.toString());
  return the_sen2;
}
