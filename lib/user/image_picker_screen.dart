import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePickerScreen extends StatefulWidget {
  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  File? _image;

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  // Function to show preview and allow canceling
  void _showPreview(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Image Preview"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_image != null)
                Image.file(
                  _image!,
                  fit: BoxFit.contain,
                  height: 300, // Adjust to your needs
                )
              else
                Text("No image selected"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                // Proceed with the selected image (e.g., upload or save)
                Navigator.pop(context);
              },
              child: Text("Proceed"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Image")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _pickImage,
              child: Text("Pick an Image from Gallery"),
            ),
            if (_image != null)
              ElevatedButton(
                onPressed: () => _showPreview(context),
                child: Text("Preview Image"),
              ),
          ],
        ),
      ),
    );
  }
}
