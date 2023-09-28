import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePick extends StatefulWidget {
  const ImagePick({super.key,required this.onPickImage});

  final Function(File pickedImage) onPickImage;


  @override
  State<ImagePick> createState() => _ImagePickState();
}

class _ImagePickState extends State<ImagePick> {

  File? pickedimageFile;

  void imagePick() async {
   final pickedimage = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 50,maxWidth: 150);

    if(pickedimage == null){
      return;
    }

   setState(() {
     pickedimageFile = File(pickedimage.path);
   });

   widget.onPickImage(pickedimageFile!);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
            backgroundColor: Colors.grey[800],
            foregroundImage: pickedimageFile != null ? FileImage(pickedimageFile!) : null,
          radius: 35,
        ),
        TextButton(onPressed: imagePick, child: const Text('Select Profile'))
      ],
    );
  }
}