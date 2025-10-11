import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:verto/models/session.dart';

class UpcomingSessionsCarousel extends StatefulWidget {
  const UpcomingSessionsCarousel({super.key});

  @override
  State<UpcomingSessionsCarousel> createState() => _UpcomingSessionsCarouselState();
}

class _UpcomingSessionsCarouselState extends State<UpcomingSessionsCarousel> {
  @override
  Widget build(BuildContext context) {
    Session session;
    return SizedBox(
      height: 240,
      child: CarouselSlider(
        options: CarouselOptions(height: 200.0,
          autoPlay: true,
          enlargeCenterPage: true,
        ),
        
        items: [1,2,3,4,5].map((i) {
          bool isHost=false;
          final Color carosuselColor=isHost?const Color.fromRGBO(103, 232, 235, 1):const Color.fromARGB(255, 109, 57, 230);

          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  borderRadius : BorderRadius.circular(16),
                  color: carosuselColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withAlpha(150),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(3, 3),
                    ),
                  ]
                ),
                child:Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TITLE',
                        style: const TextStyle(
                          fontSize: 22.0, 
                          fontWeight: FontWeight.bold, 
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4,),
                       Text(
                        'Price',
                        style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                      const SizedBox(height: 8,),
                      Text(
                        'Dscription',
                        style: const TextStyle(fontSize: 14.0, color: Colors.white70),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                )
              );
            },
          );
        }).toList(),
      )
    );
  }
}