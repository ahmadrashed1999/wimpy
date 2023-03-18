import 'package:flutter/material.dart';

class HomePageCard extends StatelessWidget {
  const HomePageCard({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 3, 76, 165),
            Color.fromARGB(255, 17, 61, 81),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
          child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset('assets/images/restaurant.png'),
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.8),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ],
      )),
    );
  }
}
