import 'package:flutter/material.dart';

class ConfirmDialogue extends StatefulWidget {
  const ConfirmDialogue({super.key});

  @override
  State<ConfirmDialogue> createState() => _ConfirmDialogueState();
}

class _ConfirmDialogueState extends State<ConfirmDialogue> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirm Action'),
      content: Text('Are you sure you want to buy this? This action can\'t be undone.'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(16)),
      actions: <Widget>[
        TextButton(onPressed: () {}, child: Text('Cancel')),
        TextButton(onPressed: () {}, child: Text('Confirm')),
      ],
    );
  }
}