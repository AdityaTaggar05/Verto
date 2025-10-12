import 'package:flutter/material.dart';
import 'package:verto/api/session.dart';
import 'package:verto/models/session.dart';
import 'package:verto/pages/profile/widgets/export.dart';
import 'package:verto/pages/session/create_session.dart';
import 'package:verto/services/auth.dart';
import 'package:verto/services/storage_service.dart';
import 'package:verto/widgets/coinbalance.dart';

import 'widgets/wardrobe.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  DateTime selectedDate = DateTime.now();

  bool isSameDay(DateTime date1, DateTime date2) {
    return date2.day == date1.day ? true : false;
  }

  void selectDay(DateTime date) => setState(() => selectedDate = date);

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    final isTodaySelected = isSameDay(selectedDate, today);
    final isTomorrowSelected = isSameDay(selectedDate, tomorrow);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => logout(context: context),
          icon: Icon(Icons.power_settings_new, size: 30),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: CoinBalance(coins: StorageService().getCoins()),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Wardrobe()),
                );
              },
              child: const CircleAvatar(
                radius: 80,
                child: Icon(Icons.person, size: 80),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "${StorageService().getFirstName()} ${StorageService().getLastName()}",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              StorageService().getUsername(),
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<Session>?>(
                future: fetchSessionsDaywise(
                  context: context,
                  day: isSameDay(today, selectedDate) ? "today" : "tomorrow",
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (snapshot.data == null) {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Center(child: Text("No sessions created yet!")),
                    );
                  }

                  return SessionTimeline(sessions: snapshot.data!);
                },
              ),
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
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreateSession()),
                    );
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blue,
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Colors.grey),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  child: Text(
                    "Add +",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
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
