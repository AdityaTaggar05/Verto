import 'package:flutter/material.dart';
import 'package:verto/api/session.dart';
import 'package:verto/models/session.dart';
import 'package:verto/services/storage_service.dart';
import 'package:verto/utils/elements.dart';
import 'package:verto/utils/extensions.dart';
import 'package:verto/widgets/coinbalance.dart';

import 'widgets/recently_added_section.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});
  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  bool isCarousel = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 64, 12, 12),
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
                    FutureBuilder<List<Session>?>(
                      future: fetchSessionSearchwise(
                        context: context,
                        count: 10,
                        search: _searchController.text,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }

                        if (snapshot.data == null) {
                          return Center(
                            child: Text("No matching sessions found"),
                          );
                        }

                        return Column(
                          children: snapshot.data!
                              .map<SessionCard>((e) => SessionCard(session: e))
                              .toList(),
                        );
                      },
                    ),
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

  final Session session;

  @override
  State<SessionCard> createState() => _SessionCardState();
}

class _SessionCardState extends State<SessionCard> {
  bool status = true;
  bool isExpanded = false;
  bool isHost = false;

  @override
  void initState() {
    super.initState();
    isHost = widget.session.hostID == StorageService().getID();
  }

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
                          widget.session.title,
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
                        Text(
                          'Taken by: ${widget.session.hostName}',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Timings: ${widget.session.startTime.customFormat()}',
                          style: TextStyle(fontSize: 16),
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
              Text(widget.session.description, style: TextStyle(fontSize: 16)),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: isHost || !status || widget.session.isBooked
                    ? null
                    : () async {
                        setState(() => status = false);
                        final bool success = await book(id: widget.session.id);

                        if (!success) {
                          showSnackBar(context, "Insufficient Balance");
                        } else {
                          widget.session.isBooked = true;
                        }

                        setState(() => status = true);
                      },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  backgroundColor: isHost || !status || widget.session.isBooked
                      ? Colors.grey.shade800
                      : Colors.blueAccent.shade700,
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
