import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class BackgroundRunWarningScreen extends StatelessWidget {
  const BackgroundRunWarningScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: Image.asset(
                      width: 200,
                      'assets/images/warning.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      textAlign: TextAlign.center,
                      'This app will run in background.',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        textAlign: TextAlign.center,
                        'To provide the best experience for you, this app will run in background.',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
                Container(
                  width: double.infinity,
                  height: 100,
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 150,
                    height: 40,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
                      child: const Text(
                        'GOT IT',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
