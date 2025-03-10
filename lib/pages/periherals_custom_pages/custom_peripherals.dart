import 'package:flutter/material.dart';
import 'package:graduation_project/pages/periherals_custom_pages/custom_car_peripheral.dart';
import 'package:graduation_project/pages/periherals_custom_pages/weather_custom_periheral.dart';
import 'package:graduation_project/widgets/custom_card_peripheral.dart';

class CustomPeripheral extends StatelessWidget {
  const CustomPeripheral({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 70,
          ),
          Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05),
              child: CustomCard(
                  method: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MyCar()),
                    );
                  },
                  text: 'custom car\nperipheral',
                  imagePath: 'assets/car.png')),
          SizedBox(
            height: 30,
          ),
          Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05),
              child: CustomCard(
                  method: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyWeatherPage()),
                    );
                  },
                  text: 'custom weather\nperipheral',
                  imagePath: 'assets/hot.png'))
        ],
      ),
    );
  }
}
