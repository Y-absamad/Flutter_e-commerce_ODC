
import 'package:flutter/material.dart';

class ColorSelection extends StatefulWidget {
  const ColorSelection({super.key});

  @override
  ColorSelectionState createState() => ColorSelectionState();
}

class ColorSelectionState extends State<ColorSelection> {
  Color? selectedColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("Available Colors", style: TextStyle(fontSize: 14)),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _colorOption(Colors.black),
            const SizedBox(width: 10),
            _colorOption(Colors.grey),
            const SizedBox(width: 10),
            _colorOption(Colors.brown),
            const SizedBox(width: 10),
          ],
        ),
      ],
    );
  }

  Widget _colorOption(Color color) {
    bool isSelected = selectedColor == color;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = color;
        });
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          border: isSelected ? Border.all(color: Colors.blue, width: 3) : null,
        ),
      ),
    );
  }
}
