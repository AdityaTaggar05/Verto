import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.selected,
    required this.category,
    required this.onTap,
  });

  final String selected;
  final String category;
  final void Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(category),
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
        child: selected != ""
            ? ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset('assets/$selected.png', fit: BoxFit.cover),
              )
            : null,
      ),
    );
  }
}
