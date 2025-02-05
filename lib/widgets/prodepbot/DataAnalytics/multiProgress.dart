import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:multi_circular_slider/multi_circular_slider.dart';

class MultiProgress extends StatelessWidget {
  const MultiProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: MultiCircularSlider(
            size: MediaQuery.of(context).size.width * 0.8,
            progressBarType: MultiCircularSliderType.circular,
            values: const [0.2, 0.1, 0.3, 0.28],
            colors: const [
              Color(0xFFFD1960),
              Color(0xFF29D3E8),
              Color(0xFF18C737),
              Color(0xFFFFCC05)
            ],
            showTotalPercentage: true,
            label: 'This is label text',
            animationDuration: const Duration(milliseconds: 1000),
            animationCurve: Curves.easeInOutCirc,
            innerIcon: const Icon(Icons.integration_instructions),
            trackColor: Colors.white,
            progressBarWidth: 36.0,
            trackWidth: 36.0,
            labelTextStyle: const TextStyle(),
            percentageTextStyle: const TextStyle(),
          ),
        ),
      ),
    );
  }
}
