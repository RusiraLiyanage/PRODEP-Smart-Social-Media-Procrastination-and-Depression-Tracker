import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'main-screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      const Duration(seconds: 4),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainScreen(),
        ),
      ),
    );
  }

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
            Container(
              alignment: Alignment.topLeft,
              width: 250,
              child: Image.asset(
                  width: 340, 'assets/images/pattern.png', fit: BoxFit.contain),
            ),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: Image.asset(
                  width: 280, 'assets/images/logo.png', fit: BoxFit.contain),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 150,
                height: 56,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    )),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFF393737)),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(18.0),
                    ),
                  ),
                  onPressed: () {
                    // Navigator.of(context)
                    //     .pushNamed(LoginSelectionScreen.routeName);
                  },
                  child: Text(
                    'GET STARTED',
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 12,
              ),
              child: const SpinKitThreeBounce(
                color: Colors.black,
                size: 70.0,
                duration: Duration(
                  milliseconds: 1500,
                ),
              ),
            ),
            Flexible(
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.bottomRight,
                    width: double.infinity,
                    child: Image.asset(
                        width: 330,
                        'assets/images/pattern2.png',
                        fit: BoxFit.contain),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                          bottom: 15,
                        ),
                        height: 150,
                        alignment: Alignment.bottomCenter,
                        child: const Text(
                          'Who we are?',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          bottom: 15,
                        ),
                        height: 150,
                        alignment: Alignment.bottomCenter,
                        child: const Text(
                          'What we do?',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
