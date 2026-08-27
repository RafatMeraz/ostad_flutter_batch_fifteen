import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:crafty_bay/features/shared/presentation/widgets/no_image.dart';
import 'package:flutter/material.dart';

import '../../../../../app/app_colors.dart';

class ProductImageCarousel extends StatefulWidget {
  const ProductImageCarousel({super.key, required this.images});

  final List<String> images;

  @override
  State<ProductImageCarousel> createState() => _ProductImageCarouselState();
}

class _ProductImageCarouselState extends State<ProductImageCarousel> {
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 220,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              _currentIndex.value = index;
            },
            autoPlay: false,
            autoPlayInterval: Duration(seconds: 1),
          ),
          items: widget.images.map((image) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Colors.grey.withAlpha(50)),
                  alignment: .center,
                  child: CachedNetworkImage(
                    imageUrl: image,
                    errorWidget: (_, _, _) => NoImage(),
                    fit: .scaleDown,
                  ),
                );
              },
            );
          }).toList(),
        ),
        SizedBox(height: 8),
        Positioned(
          bottom: 8,
          left: 0,
          right: 0,
          child: ValueListenableBuilder(
            valueListenable: _currentIndex,
            builder: (context, value, _) {
              return Row(
                mainAxisAlignment: .center,
                children: [
                  for (int i = 0; i < widget.images.length; i++)
                    Container(
                      width: 10,
                      height: 10,
                      margin: .only(right: 2),
                      decoration: BoxDecoration(
                        color: value == i ? AppColors.themeColor : Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
