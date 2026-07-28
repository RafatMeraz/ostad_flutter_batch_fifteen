import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/presentation/providers/main_nav_holder_provider.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/home_carousel_slider.dart';
import '../widgets/home_category_section.dart';
import '../widgets/home_products_section.dart';
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
      body: SingleChildScrollView(
        child: Padding(
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
                onTapSeeAll: () {
                  context.read<MainNavHolderProvider>().moveToCategory();
                },
              ),
              HomeCategorySection(),
              const SizedBox(height: 12),
              HomeSectionHeader(
                title: 'Popular',
                onTapSeeAll: () {},
              ),
              const SizedBox(height: 12),
              HomeProductsSection(
                products: [],
              ),
              const SizedBox(height: 12),
              HomeSectionHeader(
                title: 'Special',
                onTapSeeAll: () {},
              ),
              const SizedBox(height: 12),
              HomeProductsSection(
                products: [],
              ),
              const SizedBox(height: 12),
              HomeSectionHeader(
                title: 'New',
                onTapSeeAll: () {},
              ),
              const SizedBox(height: 12),
              HomeProductsSection(
                products: [],
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
