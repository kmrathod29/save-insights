import 'package:flutter/material.dart';

class TagChip extends StatelessWidget {
  final String label;

  const TagChip({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
    );
  }
}
