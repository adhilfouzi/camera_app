import 'dart:io';

import 'package:camera_app/database/datamodel.dart';
import 'package:camera_app/database/db_functions.dart';
import 'package:camera_app/database/viewimage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  File? image95;
  String? imagepath;

  Future<void> getImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) {
      return;
    }

    setState(() {
      image95 = File(image.path);
      imagepath = image.path.toString();
    });

    final stdData = AlbumModel(imagex: imagepath!);
    await addData(stdData);
  }

  @override
  Widget build(BuildContext context) {
    update();
    return Scaffold(
      appBar: AppBar(title: const Text('Camera App'), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: albumimages, // Define albumimages somewhere
              builder: (context, value, child) {
                if (value.isEmpty) {
                  return const Center(
                      child: Text(
                    'Album is Empty.....',
                    style: TextStyle(fontSize: 18),
                  ));
                } else {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemCount: value.length,
                    itemBuilder: (BuildContext context, int index) {
                      final pathdata = value[index];
                      return InkWell(
                        child: Card(
                          elevation: 5,
                          child: Image.file(
                            File(
                              pathdata.imagex,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (ctr) =>
                                    ViewScreen(imageview: pathdata))),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.black12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    getImage(ImageSource.gallery);
                  },
                  icon: const Icon(Icons.photo_album_outlined),
                ),
                IconButton(
                  onPressed: () {
                    getImage(ImageSource.camera);
                  },
                  icon: const Icon(Icons.camera),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
