import 'package:crafty_bay/app/app_colors.dart';
import 'package:flutter/material.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({super.key, required this.colors, required this.onChange});

  final List<String> colors;
  final Function(String) onChange;

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  String? _selectedColor;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        for (String color in widget.colors)
          GestureDetector(
            onTap: () {
              _selectedColor = color;
              setState(() {});
              widget.onChange(color);
            },
            child: Container(
              margin: .all(4),
              padding: .symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border: .all(color: Colors.black54),
                borderRadius: .circular(4),
                color: _selectedColor == color ? AppColors.themeColor : null,
              ),
              child: Text(color, style: TextStyle(
                  color: _selectedColor == color ? Colors.white : null,
              ))
            ),
          ),
      ],
    );
  }
}
