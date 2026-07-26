import 'package:crafty_bay/app/extensions/utility_extension.dart';
import 'package:flutter/material.dart';

import '../widgets/home_app_bar.dart';
import '../widgets/home_carousel_slider.dart';
import '../widgets/home_category_section.dart';
import '../widgets/home_search_bar.dart';
import '../widgets/home_section_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: Padding(
        padding: .symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            HomeSearchBar(),
            const SizedBox(height: 12),
            HomeCarouselSlider(),
            const SizedBox(height: 12),
            HomeSectionHeader(
              title: 'Category',
              onTapSeeAll: () {},
            ),
            HomeCategorySection()
          ],
        ),
      ),
    );
  }
}

