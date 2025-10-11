import 'package:flutter/material.dart';
import 'package:verto/models/user.dart';
import 'package:verto/widgets/coinbalance.dart';
import 'widgets/carousel.dart';
import 'package:verto/api/sessions/recent.dart';
import 'package:verto/models/session.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});
  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  late Future<List<Session>> _sessionsFuture;
  List<Session> _allApiSessions = [];
  List<Session> _filteredApiSessions = [];
  bool isCarousel = true;

  final TextEditingController _searchController = TextEditingController();

  final List<String> _allSessions = [
    'Introduction to flutter',
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
      if (query.isEmpty) {
        _filteredApiSessions = _allApiSessions;
        isCarousel = true;
      } else {
        isCarousel = false;
        _filteredApiSessions = _allApiSessions.where((session) {
          return session.hostID.toLowerCase().contains(query) ||
                 session.id.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  void initState() {
    super.initState();
    // _sessionsFuture = fetchRecentSessions();
    _searchController.addListener(_filterSessions);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, toolbarHeight: 20),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 70,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
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
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: (isCarousel)
                          ? [
                              Text(
                                'Recently added...',
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              RecentlyAddedCarousel(),
                              SizedBox(height: 20),
                              Text(
                                'Something you might like...',
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 20),
                            ]
                          : [SizedBox(height: 20)],
                    ),
                    ...List.generate(_filteredSessions.length, (index) {
                      final session = _filteredSessions[index];
                      return SessionCard(session: session);
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SessionCard extends StatefulWidget {
  const SessionCard({super.key, required this.session});

  final String session;

  @override
  State<SessionCard> createState() => _SessionCardState();
}

class _SessionCardState extends State<SessionCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => isExpanded = !isExpanded),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: Colors.grey[300]!, blurRadius: 6)],
        ),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/pfp.jpg', height: 80, width: 80),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          widget.session,
                          maxLines: 2,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 20,
                            height: 0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text('Taken by: Aditya Taggar',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text('Timings: 4:00 pm to 5:00 pm',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                CoinBalance(),
              ],
            ),
            if (isExpanded) ...[
              Divider(color: Colors.grey.shade600, height: 32),
              Text(
                "Flutter is an open-source software development kit (SDK) developed by Google",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  backgroundColor: Colors.blueAccent.shade700,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                child: const Text(
                  'Book Now',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
