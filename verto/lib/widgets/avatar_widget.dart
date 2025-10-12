// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:verto/api/wardrobe.dart';
import 'package:verto/models/avatar_items.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({super.key, required this.uid});

  final String uid;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AvatarItem>?>(
      future: fetch(context: context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: const EdgeInsets.all(32.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        String pet = "", weapon = "", armor = "";
        String skin = "Male Elf";
        if (snapshot.data != null) {
          for (int i = 0; i < snapshot.data!.length; i++) {
            if (snapshot.data![i].itemCategory == ItemCategory.skin)
              skin = snapshot.data![i].name;
            if (snapshot.data![i].itemCategory == ItemCategory.pet)
              pet = snapshot.data![i].name;
            if (snapshot.data![i].itemCategory == ItemCategory.armor)
              armor = snapshot.data![i].name;
            if (snapshot.data![i].itemCategory == ItemCategory.weapon)
              weapon = snapshot.data![i].name;
          }
        }

        print(pet);
        print(skin);
        print(weapon);
        print(armor);

        return Stack(
          children: [
            if (pet != "") Image.asset("assets/$pet.png"),
            Image.asset("assets/$skin.png"),
            if (armor != "") Image.asset("assets/$armor.png"),
            if (weapon != "") Image.asset("assets/$weapon.png"),
          ],
        );
      },
    );
  }
}
