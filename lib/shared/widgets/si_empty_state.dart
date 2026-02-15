import 'package:flutter/material.dart';

class SIEmptyState extends StatelessWidget {
  final String message;

  const SIEmptyState({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message),
    );
  }
}
