import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'constants.dart';
import 'dart:developer' as developer;

class CategoryCard extends StatelessWidget {
  final String svgSrc;
  final String title;
  final Function press;
  final Color cardColor;
  const CategoryCard(
      {Key? key,
      required this.svgSrc,
      required this.title,
      required this.press,
      required this.cardColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        developer.log("Yes Tapped");
        press();
      },
      child: Card(
        color: cardColor,
        elevation: 5,
        shadowColor: Colors.blue,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            // padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(1),
              image: DecorationImage(
                image: AssetImage(svgSrc),
                fit: BoxFit.fill,
                filterQuality: FilterQuality.high,
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 17),
                  blurRadius: 17,
                  spreadRadius: -23,
                  color: kShadowColor,
                ),
              ],
            ),

            /* child: Container(
                margin: EdgeInsets.all(50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
              ), */
          ),
        ),
      ),
    );
  }
}
