import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';

class HomeCarouselSlider extends StatefulWidget {
  const HomeCarouselSlider({super.key});

  @override
  State<HomeCarouselSlider> createState() => _HomeCarouselSliderState();
}

class _HomeCarouselSliderState extends State<HomeCarouselSlider> {
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 180,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              _currentIndex.value = index;
            },
            autoPlay: false,
            autoPlayInterval: Duration(seconds: 1),
          ),
          items: [1, 2, 3, 4, 5].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 1),
                  decoration: BoxDecoration(
                    color: AppColors.themeColor,
                    borderRadius: .circular(8),
                  ),
                  alignment: .center,
                  child: Text('text $i', style: TextStyle(fontSize: 16.0)),
                );
              },
            );
          }).toList(),
        ),
        SizedBox(height: 8),
        ValueListenableBuilder(
          valueListenable: _currentIndex,
          builder: (context, value, _) {
            return Row(
              mainAxisAlignment: .center,
              children: [
                for (int i = 0; i < 5; i++)
                  Container(
                    width: 10,
                    height: 10,
                    margin: .only(right: 2),
                    decoration: BoxDecoration(
                      color: value == i ? AppColors.themeColor : null,
                      shape: BoxShape.circle,
                      border: .all(color: Colors.grey)
                    ),
                  ),
              ],
            );
          }
        ),
      ],
    );
  }
}
