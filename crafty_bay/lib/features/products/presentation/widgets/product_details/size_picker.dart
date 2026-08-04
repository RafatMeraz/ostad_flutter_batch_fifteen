import 'package:crafty_bay/app/app_colors.dart';
import 'package:flutter/material.dart';

class SizePicker extends StatefulWidget {
  const SizePicker({super.key, required this.sizes, required this.onChange});

  final List<String> sizes;
  final Function(String) onChange;

  @override
  State<SizePicker> createState() => _SizePickerState();
}

class _SizePickerState extends State<SizePicker> {
  String? _selectedSize;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        for (String size in widget.sizes)
          GestureDetector(
            onTap: () {
              _selectedSize = size;
              setState(() {});
              widget.onChange(size);
            },
            child: Container(
              margin: .all(4),
              padding: .symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border: .all(color: Colors.black54),
                borderRadius: .circular(4),
                color: _selectedSize == size ? AppColors.themeColor : null,
              ),
              child: Text(size, style: TextStyle(
                  color: _selectedSize == size ? Colors.white : null,
              ))
            ),
          ),
      ],
    );
  }
}
