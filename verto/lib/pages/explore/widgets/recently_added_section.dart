import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:verto/api/session.dart';
import 'package:verto/models/session.dart';
import 'package:verto/services/storage_service.dart';
import 'package:verto/utils/extensions.dart';

class RecentlyAddedCarousel extends StatefulWidget {
  const RecentlyAddedCarousel({super.key});

  @override
  State<RecentlyAddedCarousel> createState() => _RecentlyAddedCarouselState();
}

class _RecentlyAddedCarouselState extends State<RecentlyAddedCarousel> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Session>?>(
      future: fetchRecent(context: context),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.all(32.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.data == null) {
          return Center(child: Text("No upcoming sessions yet!"));
        }

        return SizedBox(
          height: 240,
          child: CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              autoPlay: true,
              enlargeCenterPage: true,
            ),
            items: snapshot.data!.map<Widget>((session) {
              bool isHost = session.hostID == StorageService().getID();

              final Color carosuselColor = !isHost
                  ? const Color.fromRGBO(103, 232, 235, 1)
                  : const Color.fromARGB(255, 109, 57, 230);

              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: carosuselColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withAlpha(150),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(3, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            session.title,
                            style: const TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            session.description,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            session.startTime.customFormat(),
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.white70,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
