import 'package:flutter/material.dart';
import 'package:verto/models/session.dart';
import 'package:verto/pages/profile/widgets/export.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final List<Session> sessions = [
    Session(hostID: "", id: "", price: 10, startTime: DateTime(2025, 10, 12, 20)),
    Session(hostID: "", id: "", price: 10, startTime: DateTime(2025, 10, 11)),
    Session(hostID: "", id: "", price: 20, startTime: DateTime(2025, 10, 11, 1)),
    Session(hostID: "", id: "", price: 20, startTime: DateTime(2025, 10, 11, 3))
  ];

  final String userName = 'abcxyz';
  final String name = 'Shasak';
  DateTime selectedDate = DateTime.now();

  bool isSameDay(DateTime date1,DateTime date2){
    return date2.day==date1.day?true:false;
  }  
  List<Session> get filteredSessions {
    return sessions.where((session) {
      return isSameDay(session.startTime, selectedDate);
    }).toList();
  }
  void selectDay(DateTime date){
    setState(() {
      selectedDate=date;
    });
  }
  @override
  Widget build(BuildContext context) {
  final today=DateTime.now();
  final tomorrow=DateTime.now().add(const Duration(days: 1));
  final isTodaySelected=isSameDay(selectedDate,today);
  final isTomorrowSelected=isSameDay(selectedDate,tomorrow);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(icon: const Icon(Icons.monetization_on), onPressed: () {}),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const CircleAvatar(
              radius: 80,
              child: Icon(Icons.person, size: 80),
            ),
            const SizedBox(height: 16),
            Text(
              name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              userName,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),

             Expanded(
              child: SessionTimeline(sessions: filteredSessions), 
            ),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DateSelectionButton(
                  label: 'Today',
                  isSelected: isTodaySelected,
                  onPressed: () => selectDay(today),
                ),
                DateSelectionButton(
                  label: 'Tomorrow',
                  isSelected: isTomorrowSelected,
                  onPressed: () => selectDay(tomorrow),
                ),
              ],
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}