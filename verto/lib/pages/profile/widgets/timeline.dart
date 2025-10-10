import 'package:flutter/material.dart';
import 'package:verto/models/session.dart';
import 'package:verto/utils/extensions.dart';

class SessionTimeline extends StatelessWidget {
  final List<Session> sessions;

  const SessionTimeline({super.key, required this.sessions});

  @override
  Widget build(BuildContext context) {
    return Container(
      
      decoration: const BoxDecoration(color: Colors.white),
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.only(top: 12.0, left: 28.0, bottom: 12.0),

      child: ListView.builder(
        physics: const ClampingScrollPhysics(),
        itemCount: sessions.length,
        itemBuilder: (context, index) {
          final Session session = sessions[index];
          final bool isLast = index == sessions.length - 1;
          final endTime = session.startTime.add(const Duration(hours: 1));

          final bool completed = DateTime.now().isAfter(endTime);

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: completed ? Colors.green : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                    child: completed
                        ? const Icon(Icons.check, size: 12, color: Colors.white)
                        : const Text(""),
                  ),

                  Container(
                    width: 3,
                    height: isLast ? 0 : 50,
                    decoration: BoxDecoration(
                      color: isLast ? Colors.transparent : (completed ? Colors.green : Colors.grey),
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 25),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "${session.startTime.customFormat()} - ${session.startTime.add(const Duration(hours: 1)).customFormat()}",
                        style: TextStyle(
                          fontFamily: "regular",
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: completed ? Colors.black : Colors.black54,
                        ),
                      ),

                      const SizedBox(height: 4),
                      Text(
                        session.price.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        session.id,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
