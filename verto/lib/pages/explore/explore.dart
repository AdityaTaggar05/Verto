import 'package:flutter/material.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {

  final TextEditingController _searchController = TextEditingController();

  final List<String> _allSessions = [
    'Introduction to Flutter',
    'State Management with Provider',
    'Advanced Dart Concepts',
    'Firebase for Flutter Apps',
    'Building Responsive UIs',
    'Animations in Flutter',
    'Testing Flutter Applications',
    'CI/CD for Flutter',
  ];

  // The list that will be displayed and filtered
  List<String> _filteredSessions = [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterSessions() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredSessions = _allSessions.where((session) {
        final sessionLower = session.toLowerCase();
        return sessionLower.contains(query);
      }).toList();
    });
  }

  void initState() {
    super.initState();
    // Initially, the filtered list contains all sessions
    _filteredSessions = _allSessions;
    // Listen for changes in the text field
    _searchController.addListener(_filterSessions);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 20,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 70,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: SearchController(),
                decoration: InputDecoration(
                  hintText: 'Search for sessions...',
                  border: InputBorder.none,
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.grey),
                          onPressed: () {
                            _searchController.clear();
                          },
                        )
                      : null,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredSessions.length,
                itemBuilder: (context, index) {
                  final session = _filteredSessions[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      title: Text(session),
                      leading: const Icon(Icons.class_, color: Colors.blueAccent),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
