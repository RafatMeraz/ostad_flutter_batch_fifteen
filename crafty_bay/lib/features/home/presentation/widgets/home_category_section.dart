import 'package:flutter/material.dart';

import '../../../shared/presentation/widgets/category_item.dart';

class HomeCategorySection extends StatelessWidget {
  const HomeCategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: .horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return CategoryItem();
        },
        separatorBuilder: (context, index) {
          return SizedBox(width: 8);
        },
      ),
    );
  }
}
