import 'package:flutter/material.dart';
import 'package:verto/api/wardrobe.dart';
import 'package:verto/models/avatar_item.dart';

import 'list_element.dart';

class SelectItemSheet extends StatelessWidget {
  const SelectItemSheet({super.key, required this.category});

  final String category;

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: FutureBuilder<List<AvatarItem>?>(
        future: fetchByCategory(context: context, category: category),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Padding(
              padding: const EdgeInsets.all(32.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          print("SNAPSHOT: ${snapshot.data}");

          return ListView(
            children: List.generate(
              snapshot.data!.length,
              (index) => ListElement(0),
            ),
          );
        },
      ),
    );
  }
}
