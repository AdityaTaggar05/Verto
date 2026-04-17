import 'package:flutter/material.dart';
import 'package:verto/api/wardrobe.dart';
import 'package:verto/models/avatar_item.dart';
import 'package:verto/services/storage_service.dart';
import 'package:verto/widgets/avatar_widget.dart';
import 'package:verto/widgets/coinbalance.dart';

import 'widgets/category.dart';
import 'widgets/select_item_sheet.dart';

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

  List<String> equippedItems = ["", "Male Elf", "", ""];
  String category = "armor";

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
          FutureBuilder<List<AvatarItem>?>(
            future: fetch(context: context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (snapshot.data != null) {
                for (int i = 0; i < snapshot.data!.length; i++) {
                  if (snapshot.data![i].itemCategory == ItemCategory.skin) {
                    equippedItems[1] = snapshot.data![i].name;
                  }
                  if (snapshot.data![i].itemCategory == ItemCategory.pet) {
                    equippedItems[0] = snapshot.data![i].name;
                  }
                  if (snapshot.data![i].itemCategory == ItemCategory.armor) {
                    equippedItems[2] = snapshot.data![i].name;
                  }
                  if (snapshot.data![i].itemCategory == ItemCategory.weapon) {
                    equippedItems[3] = snapshot.data![i].name;
                  }
                }
              }

              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 128,
                  horizontal: 8,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 275,
                      width: 275,
                      child: AvatarWidget(equippedItems: equippedItems),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CategoryWidget(
                            selected: equippedItems[0],
                            category: "pet",
                            onTap: (c) {
                              setState(() => category = c);
                              _togglePanel();
                            },
                          ),
                          CategoryWidget(
                            selected: equippedItems[1],
                            category: "skin",
                            onTap: (c) {
                              setState(() => category = c);
                              _togglePanel();
                            },
                          ),
                          CategoryWidget(
                            selected: equippedItems[2],
                            category: "armor",
                            onTap: (c) {
                              setState(() => category = c);
                              _togglePanel();
                            },
                          ),
                          CategoryWidget(
                            selected: equippedItems[3],
                            category: "weapon",
                            onTap: (c) {
                              setState(() => category = c);
                              _togglePanel();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          GestureDetector(
            onTap: _togglePanel,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              color: _isPanelOpen ? Colors.black54 : Colors.transparent,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: SlideTransition(
              position: _offsetAnimation,
              child: SelectItemSheet(category: category),
            ),
          ),
        ],
      ),
    );
  }
}
