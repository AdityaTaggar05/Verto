import 'package:flutter/material.dart';

class ExpBar extends StatefulWidget {
  const ExpBar({super.key});

  @override
  State<ExpBar> createState() => _ExpBarState();
}

class _ExpBarState extends State<ExpBar> {
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: '75/100',
      child: Stack(
        children: [
          CircularProgressIndicator(value: 0.75,),
          Positioned(
            top: 8,
            left: 8,
            child: Text('42',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                
              ),
            )),
        ],
      ),
    );
  }
}