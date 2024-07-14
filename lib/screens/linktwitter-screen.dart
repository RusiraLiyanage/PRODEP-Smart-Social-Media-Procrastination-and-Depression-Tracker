import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LinkTwitterAccountScreen extends StatelessWidget {
  const LinkTwitterAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      width: 350,
                      child: Image.asset(
                          width: 330,
                          'assets/images/pattern.png',
                          fit: BoxFit.contain),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Container(
                        height: 250,
                        alignment: Alignment.bottomLeft,
                        width: double.infinity,
                        child: const Text(
                          'Do you have a Twitter account?',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 52,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      textAlign: TextAlign.center,
                      'To get the maximum out of this app, we recommend to link your Twitter account if have.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: Image.asset(
                      width: 350,
                      'assets/images/linktwitter.png',
                      fit: BoxFit.contain),
                ),
                Stack(
                  children: [
                    Container(
                      alignment: Alignment.bottomRight,
                      width: double.infinity,
                      child: Image.asset(
                          width: 330,
                          'assets/images/pattern2.png',
                          fit: BoxFit.contain),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 250,
                            child: ElevatedButton.icon(
                              icon: const Icon(FontAwesomeIcons.twitter),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color(0xFF393737)),
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.all(18.0),
                                ),
                              ),
                              onPressed: () {
                                // Navigator.of(context)
                                //     .pushNamed(LoginSelectionScreen.routeName);
                              },
                              label: const Text(
                                'LINK TWITTER ACCOUNT',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ColoredBox(
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Flexible(
                                  child: Divider(color: Colors.grey),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'or',
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Flexible(
                                  child: Divider(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            width: 280,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Color(0xFF393737), width: 2),
                                  borderRadius: BorderRadius.circular(50.0),
                                )),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.all(18.0),
                                ),
                              ),
                              onPressed: () {
                                // Navigator.of(context)
                                //     .pushNamed(LoginSelectionScreen.routeName);
                              },
                              child: const Text(
                                'CONTINUE WITHOUT TWITTER',
                                style: TextStyle(
                                    color: Color(0xFF393737),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ]),
        ));
  }
}
