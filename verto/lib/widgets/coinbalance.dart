import 'package:flutter/material.dart';

class CoinBalance extends StatelessWidget {
  const CoinBalance({super.key, required this.coins});

  final int coins;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/coin.png', height: 30, width: 30),
        Text(
          coins.toString(),
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
      ],
    );
  }
}
