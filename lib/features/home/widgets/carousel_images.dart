import 'package:amazon_clone/constants/global_variables.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselImage extends StatelessWidget {
  const CarouselImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: GlobalVariables.carouselImages.map((e) {
        return Builder(builder: (context)=>Image.network(e, fit: BoxFit.cover,));
      }).toList(),
      options: CarouselOptions(
        autoPlay: true,
        viewportFraction: 1,
        height: 200,
      ),
    );
  }
}
