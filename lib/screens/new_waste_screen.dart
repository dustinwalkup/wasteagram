import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// ignore: library_prefixes
import 'package:path/path.dart' as Path;
import 'package:wasteagram/widgets/wasted_food_form.dart';

class NewWasteScreen extends StatefulWidget {
  const NewWasteScreen({Key? key}) : super(key: key);

  @override
  State<NewWasteScreen> createState() => _NewWasteScreenState();
}

class _NewWasteScreenState extends State<NewWasteScreen> {
  XFile? image;
  final ImagePicker _picker = ImagePicker();
  late String url;

  Future getImage() async {
    image = await _picker.pickImage(source: ImageSource.gallery);
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child(Path.basename(image!.path));
    UploadTask uploadTask = ref.putFile(File(image!.path));
    await uploadTask.whenComplete(() async {
      url = await ref.getDownloadURL();
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (image == null) {
      getImage();
      return Container();
    } else {
      return Scaffold(
          appBar: AppBar(
            title: const Text('New Post'),
            centerTitle: true,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Semantics(
                child: Expanded(
                    child: Image.file(
                  File(image!.path),
                  width: 400,
                  height: 200,
                )),
                image: true,
                onTapHint: 'Photo of food waste',
              ),
              WastedFoodForm(
                url: url,
              ),
            ],
          ));
    }
  }
}
