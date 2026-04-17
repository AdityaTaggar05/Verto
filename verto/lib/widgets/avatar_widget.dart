import 'package:flutter/material.dart';
import 'package:verto/api/wardrobe.dart';
import 'package:verto/models/avatar_item.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({super.key, required this.equippedItems});

  final List<String> equippedItems;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (equippedItems[0] != "")
          Image.asset("assets/${equippedItems[0]}.png"),
        Image.asset("assets/${equippedItems[1]}.png"),
        if (equippedItems[2] != "")
          Image.asset("assets/${equippedItems[2]}.png"),
        if (equippedItems[3] != "")
          Image.asset("assets/${equippedItems[3]}.png"),
      ],
    );
  }
}

class AvatarBadge extends StatelessWidget {
  const AvatarBadge({
    super.key,
    required this.height,
    required this.width,
    required this.uid,
  });

  final double width;
  final double height;
  final String uid;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AvatarItem>?>(
      future: fetch(context: context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        String armor = "";
        String skin = "Male Elf";

        if (snapshot.data != null) {
          for (int i = 0; i < snapshot.data!.length; i++) {
            if (snapshot.data![i].itemCategory == ItemCategory.skin) {
              skin = snapshot.data![i].name;
            }
            if (snapshot.data![i].itemCategory == ItemCategory.armor) {
              armor = snapshot.data![i].name;
            }
          }
        }

        return SizedBox(
          width: width,
          height: height,
          child: Stack(
            children: [
              Image.asset(
                width: width * 2,
                height: height * 2,
                "assets/$skin.png",
              ),
              if (armor != "")
                Image.asset(
                  width: width * 2,
                  height: height * 2,
                  "assets/$armor.png",
                ),
            ],
          ),
        );
      },
    );
  }
}
