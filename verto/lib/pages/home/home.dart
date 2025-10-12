import 'package:flutter/material.dart';
import 'package:verto/services/storage_service.dart';
import 'package:verto/widgets/coinbalance.dart';
import 'package:verto/widgets/exp_bar.dart';

import 'widgets/upcoming_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actionsPadding: EdgeInsets.only(right: 12),
        leading: Padding(
          padding: EdgeInsets.only(left: 16),
          child: CircleAvatar(backgroundImage: AssetImage('assets/pfp.jpg')),
        ),
        title: Text(
          StorageService().getUsername(),
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          ExpBar(),
          SizedBox(width: 16),
          CoinBalance(coins: StorageService().getCoins()),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 70,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search for sessions...',
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              "Upcoming Sessions",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            UpcomingSessionsCarousel(),
          ],
        ),
      ),
    );
  }
}
