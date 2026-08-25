import 'package:cached_network_image/cached_network_image.dart';
import 'package:crafty_bay/features/category/data/category_model.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/extensions/utility_extension.dart';
import '../../../products/presentation/screens/products_by_category_screen.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductsByCategoryScreen.name,
          arguments: category.title,
        );
      },
      child: Column(
        spacing: 8,
        children: [
          Container(
            padding: .all(16),
            decoration: BoxDecoration(
              color: AppColors.themeColor.withAlpha(30),
              borderRadius: .circular(12),
            ),
            child: CachedNetworkImage(
              imageUrl: category.icon,
              height: 48,
              width: 48,
              errorWidget: (_, __, ___) {
                return Icon(Icons.error_outline, size: 48, color: Colors.grey);
              },
            ),
          ),
          Text(
            _getTitle(category.title),
            style: context.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.themeColor,
            ),
          ),
        ],
      ),
    );
  }

  String _getTitle(String category) {
    if (category.length > 10) {
      return '${category.substring(0, 8)}..';
    } else {
      return category;
    }
  }
}
