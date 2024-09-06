import 'package:animals_app/domain/response/image_response.dart';
import 'package:animals_app/presentation/home/theme.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';

class CarouselIndicators extends StatelessWidget {
  const CarouselIndicators({
    required this.imagenes,
    required this.index,
    required this.controller,
    super.key,
  });
  final List<ImageResponse> imagenes;
  final int index;
  final CarouselSliderController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: imagenes.asMap().entries.map((entry) {
        return GestureDetector(
          onTap: () => controller.animateToPage(entry.key),
          child: Container(
            width: 5.0,
            height: 5.0,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : AppColor.primary)
                    .withOpacity(index == entry.key ? 0.9 : 0.4)),
          ),
        );
      }).toList(),
    );
  }
}
