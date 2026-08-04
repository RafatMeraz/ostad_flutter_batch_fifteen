import 'package:crafty_bay/app/app_colors.dart';
import 'package:flutter/material.dart';

class IncDecButton extends StatefulWidget {
  const IncDecButton({
    super.key,
    required this.initialValue,
    required this.onChange,
    required this.maxValue,
    required this.minValue,
  });

  final int initialValue;
  final Function(int) onChange;
  final int maxValue;
  final int minValue;

  @override
  State<IncDecButton> createState() => _IncDecButtonState();
}

class _IncDecButtonState extends State<IncDecButton> {
  int _count = 1;

  @override
  void initState() {
    super.initState();
    _count = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        _buildIconButton(
          icon: Icons.remove,
          onTap: () {
            if (_count > widget.minValue) {
              _count--;
              widget.onChange(_count);
              setState(() {});
            }
          },
        ),
        Text('$_count', style: TextStyle(fontSize: 16, fontWeight: .w600)),
        _buildIconButton(
          icon: Icons.add,
          onTap: () {
            if (_count < widget.maxValue) {
              _count++;
              widget.onChange(_count);
              setState(() {});
            }
          },
        ),
      ],
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: .all(4),
        decoration: BoxDecoration(
          color: AppColors.themeColor,
          borderRadius: .circular(4),
        ),
        child: Icon(icon, size: 20, color: Colors.white),
      ),
    );
  }
}
