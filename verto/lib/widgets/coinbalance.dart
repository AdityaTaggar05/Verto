import 'package:flutter/material.dart';
import 'package:verto/services/storage_service.dart';

class CoinBalance extends StatelessWidget {
  const CoinBalance({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/coin.png', height: 30, width: 30),
        Text(
          StorageService().getCoins().toString(),
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
      ],
    );
  }
}
