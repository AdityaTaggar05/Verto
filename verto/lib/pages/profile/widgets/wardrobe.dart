import 'package:flutter/material.dart';
import 'package:verto/services/storage_service.dart';
import 'package:verto/widgets/coinbalance.dart';

import 'list_elements.dart';

int state1 = 0;
int state2 = 1;
int state3 = 2;
int state4 = 3;

class Wardrobe extends StatefulWidget {
  const Wardrobe({super.key});

  @override
  State<Wardrobe> createState() => _WardrobeState();
}

class _WardrobeState extends State<Wardrobe>
    with SingleTickerProviderStateMixin<Wardrobe> {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  bool _isPanelOpen = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePanel() {
    setState(() {
      _isPanelOpen = !_isPanelOpen;
    });
    if (_isPanelOpen) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  Widget _buildBarrier() {
    if (!_isPanelOpen) return Container();

    return GestureDetector(
      onTap: _togglePanel,
      child: Container(color: Colors.black54),
    );
  }

  Widget _buildSideModal() {
    return Align(
      alignment: Alignment.centerRight,
      child: SlideTransition(
        position: _offsetAnimation,
        child: Container(
          width: 360,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8.0)],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              bottomLeft: Radius.circular(15),
            ),
          ),
          child: ListView(
            children: [
              Column(
                children: [
                  ListElement(state1),
                  ListElement(state2),
                  ListElement(state3),
                  ListElement(state4),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actionsPadding: const EdgeInsets.only(right: 12),
        actions: [CoinBalance(coins: StorageService().getCoins())],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/wardrobe_background.png', fit: BoxFit.fitHeight),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 128, horizontal: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 275,
                  width: 275,
                  child: Stack(
                    children: [
                      Image.asset("assets/Dog.png"),
                      Image.asset("assets/Female Dragonborn.png"),
                      Image.asset("assets/Royal Armour.png"),
                      Image.asset("assets/Spear.png"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: _togglePanel,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(118, 199, 100, 35),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: const Color.fromARGB(255, 90, 22, 22),
                              width: 5,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'assets/armor.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: _togglePanel,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(118, 199, 100, 35),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: const Color.fromARGB(255, 90, 22, 22),
                              width: 5,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'assets/armor.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: _togglePanel,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(118, 199, 100, 35),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: const Color.fromARGB(255, 90, 22, 22),
                              width: 5,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'assets/armor.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: _togglePanel,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(118, 199, 100, 35),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: const Color.fromARGB(255, 90, 22, 22),
                              width: 5,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'assets/armor.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          if (_isPanelOpen) _buildBarrier(),
          _buildSideModal(),
        ],
      ),
    );
  }
}
