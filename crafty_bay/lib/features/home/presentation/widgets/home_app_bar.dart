import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../app/asset_paths.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: SvgPicture.asset(AssetPaths.logoNavSvg),
      actions: [
        _buildIconButton(icon: Icons.person, onTap: () {}),
        SizedBox(width: 8),
        _buildIconButton(icon: Icons.call, onTap: () {}),
        SizedBox(width: 8),
        _buildIconButton(icon: Icons.notifications, onTap: () {}),
      ],
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 16,
        backgroundColor: Colors.grey.withAlpha(40),
        child: Icon(icon, color: Colors.grey, size: 20),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
