import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../category/presentation/providers/category_list_provider.dart';
import '../../../shared/presentation/widgets/category_item.dart';
import '../../../shared/presentation/widgets/centered_progress_indicator.dart';

class HomeCategorySection extends StatelessWidget {
  const HomeCategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Consumer<CategoryListProvider>(
        builder: (context, categoryListProvider, _) {
          if (categoryListProvider.initialLoading) {
            return CenteredProgressIndicator();
          }

          return ListView.separated(
            scrollDirection: .horizontal,
            itemCount: _getCategoryLength(
              categoryListProvider.categories.length,
            ),
            itemBuilder: (context, index) {
              return CategoryItem(
                category: categoryListProvider.categories[index],
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(width: 8);
            },
          );
        },
      ),
    );
  }

  int _getCategoryLength(int length) {
    return length > 10 ? 10 : length;
  }
}
