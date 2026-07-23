import 'package:flutter/material.dart';

import '../../../../app/extensions/utility_extension.dart';

class HomeSectionHeader extends StatelessWidget {
  const HomeSectionHeader({
    super.key,
    required this.title,
    required this.onTapSeeAll,
  });

  final String title;
  final VoidCallback onTapSeeAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        Text(title, style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        )),
        TextButton(onPressed: onTapSeeAll, child: Text('See All')),
      ],
    );
  }
}
