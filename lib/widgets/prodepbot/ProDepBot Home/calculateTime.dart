List<int> the_timing_array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
List<String> the_day_suffix_array = [
  "st",
  "nd",
  "rd",
  "th",
  "th",
  "th",
  "th",
  "th",
  "th",
  "th",
  "th",
  "th",
  "th",
  "th",
  "th",
  "th",
  "th",
  "th",
  "th",
  "th",
  "st",
  "nd",
  "rd",
  "th",
  "th",
  "th",
  "th",
  "th",
  "th",
  "th",
  "st"
];
int getTweleveHourTime(int theTwentyFour) {
  if (theTwentyFour == 13) {
    return the_timing_array[0];
  }
  if (theTwentyFour == 14) {
    return the_timing_array[1];
  }
  if (theTwentyFour == 15) {
    return the_timing_array[2];
  }
  if (theTwentyFour == 16) {
    return the_timing_array[3];
  }
  if (theTwentyFour == 17) {
    return the_timing_array[4];
  }
  if (theTwentyFour == 18) {
    return the_timing_array[5];
  }
  if (theTwentyFour == 19) {
    return the_timing_array[6];
  }
  if (theTwentyFour == 20) {
    return the_timing_array[7];
  }
  if (theTwentyFour == 21) {
    return the_timing_array[8];
  }
  if (theTwentyFour == 22) {
    return the_timing_array[9];
  }
  if (theTwentyFour == 23) {
    return the_timing_array[10];
  }
  if (theTwentyFour == 24) {
    return the_timing_array[11];
  }
  return theTwentyFour;
}

String getDaySuffix(int the_day) {
  if (the_day == 0) {
    return "Not valid";
  }
  return the_day_suffix_array[the_day - 1];
}
