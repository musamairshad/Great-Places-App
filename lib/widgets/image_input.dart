import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  const ImageInput(this.onSelectImage, {super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  Future<void> _takePicture() async {
    // instead off calling pickImage as a static method call pickImage on
    // instance.
    final picker = ImagePicker();
    // image is stored in imageFile variable.
    final imageFile = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    ); // obviously user can select the camera
    // button and click ok so it will take a while to finish.
    // if (imageFile == null) {
    //   return; // if we have no image then we can't show it as a preview
    // so that's why return null.
    // }
    setState(() {
      _storedImage = File((imageFile as XFile).path);
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile!.path);
    final savedImage = await _storedImage?.copy("${appDir.path}/$fileName");
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 100,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          alignment: Alignment.center,
// Image.file() used to create image based on a file on our device.
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Text(
                  "No Image Taken",
                  textAlign: TextAlign.center,
                ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: TextButton.icon(
          icon: const Icon(Icons.camera_alt_rounded),
          label: const Text("Take Picture"),
          // if you use _takePicture() so it automatically gets parsed without
          // the user action.
          onPressed: _takePicture,
        )),
      ],
    );
  }
}