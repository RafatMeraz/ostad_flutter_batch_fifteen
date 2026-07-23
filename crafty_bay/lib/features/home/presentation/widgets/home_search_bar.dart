import 'package:flutter/material.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: .search,
      onChanged: (String? value) {},
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.withAlpha(50),
        hintText: 'Search',
        prefixIcon: Icon(Icons.search),
        border: _buildOutlineInputBorder(),
        enabledBorder: _buildOutlineInputBorder(),
        focusedBorder: _buildOutlineInputBorder(),
      )
    );
  }

  OutlineInputBorder _buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    );
  }
}
