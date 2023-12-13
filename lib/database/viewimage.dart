import 'dart:io';

import 'package:camera_app/database/db_functions.dart';
import 'package:flutter/material.dart';

class ViewScreen extends StatelessWidget {
  final imageview;
  const ViewScreen({super.key, required this.imageview});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Image'),
        actions: [
          IconButton(
              onPressed: () {
                deleteData(imageview.id);
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: GestureDetector(
        child: Center(child: Image.file(File(imageview.imagex)))),
    );
  }
}
