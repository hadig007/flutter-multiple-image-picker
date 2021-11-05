// import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  // const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ImagePicker _imagePicker = ImagePicker();

  List<XFile> _imageList = [];

  @override
  Widget build(BuildContext context) {
    print(_imageList.toList());
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          OutlinedButton(
            onPressed: () {
              selectImage();
            },
            child: Text("Select Image"),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(15),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
              ),
              itemBuilder: (BuildContext context, int i) {
                return Stack(fit: StackFit.expand, children: [
                  Image.file(
                    File(_imageList[i].path),
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child:
                        IconButton(onPressed: () {
                          _imageList.removeAt(i);
                          setState(() {
                            
                          });
                        }, icon: Icon(Icons.delete, color: Colors.red,)),
                  )
                ]);
              },
              itemCount: _imageList.length,
            ),
          )
        ]),
      ),
    );
  }

  void selectImage() async {
    final XFile? selected =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (selected!.path.isEmpty) {
      print(selected.path.toString());
      _imageList.add(selected);
    }
    _imageList.add(selected);
    setState(() {});
  }
}
