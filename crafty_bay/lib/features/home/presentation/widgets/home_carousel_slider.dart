import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:crafty_bay/features/shared/presentation/widgets/centered_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';
import '../../../shared/presentation/widgets/no_image.dart';
import '../providers/home_sliders_provider.dart';

class HomeCarouselSlider extends StatefulWidget {
  const HomeCarouselSlider({super.key});

  @override
  State<HomeCarouselSlider> createState() => _HomeCarouselSliderState();
}

class _HomeCarouselSliderState extends State<HomeCarouselSlider> {
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeSlidersProvider>(
      builder: (context, homeSlidersProvider, _) {
        if (homeSlidersProvider.getHomeSlidersInProgress) {
          return SizedBox(
              height: 190,
              child: CenteredProgressIndicator());
        }

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
              items: homeSlidersProvider.sliders.map((slide) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 1),
                      decoration: BoxDecoration(
                        color: AppColors.themeColor,
                        borderRadius: .circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: .circular(8),
                        child: CachedNetworkImage(
                          imageUrl: slide.photoUrl,
                          fit: .cover,
                          errorWidget: (_, _, _) => NoImage(),
                          progressIndicatorBuilder: (_, _, _) => NoImage(),
                        ),
                      ),
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
                    for (int i = 0; i < homeSlidersProvider.sliders.length; i++)
                      Container(
                        width: 10,
                        height: 10,
                        margin: .only(right: 2),
                        decoration: BoxDecoration(
                          color: value == i ? AppColors.themeColor : null,
                          shape: BoxShape.circle,
                          border: .all(color: Colors.grey),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        );
      },
    );
  }
}
