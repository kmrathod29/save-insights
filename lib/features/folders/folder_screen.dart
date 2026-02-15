import 'package:flutter/material.dart';

class FolderScreen extends StatelessWidget {
  const FolderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Folder Screen'),
      ),
      body: Center(
        child: const Text('Folder Screen'),
      ),
    );
  }
}
