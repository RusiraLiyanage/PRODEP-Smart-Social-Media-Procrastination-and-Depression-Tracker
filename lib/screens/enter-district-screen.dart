import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class EnterDistrictScreen extends StatefulWidget {
  EnterDistrictScreen({Key? key}) : super(key: key);

  @override
  State<EnterDistrictScreen> createState() => _EnterDistrictScreenState();
}

class _EnterDistrictScreenState extends State<EnterDistrictScreen> {
  String _selectedDistrict = "Colombo";

  List<String> districts = [
    "Colombo",
    "Gampaha",
    "Kalutara",
    "Kandy",
    "Matale",
    "Nuwara Eliya",
    "Galle",
    "Matara",
    "Hambantota",
    "Jaffna",
    "Kilinochchi",
    "Mannar",
    "Vavuniya",
    "Mullaitivu",
    "Batticaloa",
    "Ampara",
    "Trincomalee",
    "Kurunegala",
    "Puttalam",
    "Anuradhapura",
    "Polonnaruwa",
    "Badulla",
    "Moneragala",
    "Ratnapura",
    "Kegalle"
  ];

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
                      'assets/images/district.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: const Text(
                      'Choose current district',
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
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      textAlign: TextAlign.center,
                      'Choose the district that you are currently living from below list.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Container(
                    width: 330,
                    child: DropdownButtonFormField(
                      value: _selectedDistrict,
                      items: districts.map((String val) {
                        return DropdownMenuItem(
                          value: val,
                          child: Text(val),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          _selectedDistrict = value!;
                        });
                      },
                    ),
                  )
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
                        'PROCEED',
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
