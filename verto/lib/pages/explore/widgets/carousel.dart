import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class RecentlyAddedCarousel extends StatefulWidget {
  const RecentlyAddedCarousel({super.key});

  @override
  State<RecentlyAddedCarousel> createState() => _RecentlyAddedCarouselState();
}

class _RecentlyAddedCarouselState extends State<RecentlyAddedCarousel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      child: CarouselSlider(
        options: CarouselOptions(height: 200.0,
          autoPlay: true,
          enlargeCenterPage: true,
        ),
        items: [1,2,3,4,5].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  borderRadius : BorderRadius.circular(16),
                  color: Colors.blueAccent,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withAlpha(150),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(3, 3),
                    ),
                  ]
                ),
                child: Text('text $i', style: TextStyle(fontSize: 16.0),)
              );
            },
          );
        }).toList(),
      )
    );
  }
}