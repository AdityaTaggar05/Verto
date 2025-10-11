import 'package:flutter/material.dart';
import 'package:verto/widgets/coinbalance.dart';
import 'widgets/carousel.dart';


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
        title: Text('John Doe',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.home), tooltip: 'exp'),
          CoinBalance(),
        ],
      ),

      body: Padding(padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                height: 8,
              ),
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
              
              UpcomingSessionsCarousel(),
            ],
          ),
        ),
    );
  }
}
