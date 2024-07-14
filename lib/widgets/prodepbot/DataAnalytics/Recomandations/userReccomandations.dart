import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class UserReccomandations extends StatefulWidget {
  List<String> userRecommand = <String>[];
  String emotionalStatus = "";
  Color recomandationColor;
  Color emotionalStatusColors;
  String userName = "";
  UserReccomandations({
    Key? key,
    required this.userRecommand,
    required this.emotionalStatus,
    required this.recomandationColor,
    required this.emotionalStatusColors,
    required this.userName,
  }) : super(key: key);

  @override
  State<UserReccomandations> createState() => _UserReccomandationsState();
}

class _UserReccomandationsState extends State<UserReccomandations> {
  String emotionalStatus2 = "";

  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.black54,
        elevation: 8,
        actions: [],
        title: Text(
          this.widget.emotionalStatus,
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
            foreground: Paint()
              ..shader = LinearGradient(colors: [
                widget.recomandationColor,
                widget.emotionalStatusColors,
              ]).createShader(
                Rect.fromLTWH(5.0, 5.0, 200.0, 50.0),
              ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Container(
            alignment: Alignment.bottomLeft,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
              color: Colors.blue,
            ),
            padding: EdgeInsets.only(top: 20, left: 5),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    height: 100,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  child: Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      "Dear ${widget.userName},",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 49,
                  child: Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 12),
                    child: Text(
                      "Recommandations for you",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: widget.recomandationColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: CupertinoScrollbar(
              isAlwaysShown: true,
              controller: _scrollController,
              thickness: 5,
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: widget.userRecommand.length,
                itemBuilder: (context, index) {
                  final item = widget.userRecommand[index];
                  return Card(
                    color: Colors.blue,
                    elevation: 10.0,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      height: 110,
                      width: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        /* image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                    "assets/images/bot.png",
                                  ),
                                ), */
                      ),
                      child: ListTile(
                        title: Text(
                          item.replaceAll("{", ""),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        leading: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                        trailing: Icon(
                          Icons.star,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
