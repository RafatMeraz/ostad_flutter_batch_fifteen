import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/extensions/utility_extension.dart';
import '../../../products/presentation/screens/products_by_category_screen.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductsByCategoryScreen.name,
          arguments: 'Electronics',
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
            child: Icon(Icons.computer, size: 48, color: AppColors.themeColor),
          ),
          Text(
            _getTitle('Electronic'),
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
