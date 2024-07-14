import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProdepTwitterWidget extends StatefulWidget {
  const ProdepTwitterWidget({Key? key}) : super(key: key);

  @override
  State<ProdepTwitterWidget> createState() => _ProdepTwitterWidgetState();
}

class _ProdepTwitterWidgetState extends State<ProdepTwitterWidget> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
            child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            debugPrint('Card tapped.');
          },
          child: Container(
            width: double.infinity,
            height: 200,
            child: Row(
              children: [
                SizedBox(
                  width: 230,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          "Today's Twitter Usage",
                          style: TextStyle(
                              fontSize: 25,
                              color: Color(0xFF393737),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            "09",
                            style: TextStyle(
                              fontSize: 35,
                              color: Color(0xFF393737),
                            ),
                          ),
                          Text(
                            "Hrs",
                            style: TextStyle(
                              fontSize: 35,
                              color: Color(0xFF393737),
                            ),
                          ),
                          Text(
                            "30",
                            style: TextStyle(
                              fontSize: 35,
                              color: Color(0xFF393737),
                            ),
                          ),
                          Text(
                            "mins",
                            style: TextStyle(
                              fontSize: 35,
                              color: Color(0xFF393737),
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        "Too Much",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF393737),
                        ),
                      ),
                    ],
                  ),
                ),
                const VerticalDivider(
                  width: 20,
                  thickness: 1,
                  endIndent: 0,
                  color: Colors.grey,
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Prominent Emotion"),
                      Image.asset(
                        width: 70,
                        'assets/images/happyface.png',
                        fit: BoxFit.contain,
                      ),
                      const Text(
                        "POSITIVE",
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 23,
                            fontWeight: FontWeight.bold),
                      ),
                      const Text("See more >>")
                    ],
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
