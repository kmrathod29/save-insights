import 'package:flutter/material.dart';

class SIButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const SIButton({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
