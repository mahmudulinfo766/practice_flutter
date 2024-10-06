import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _messageController = TextEditingController();
  File? _selectedImage;

  // Function to pick an image
  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
        _messages.add(ChatMessage(imagePath: _selectedImage!.path, isSentByMe: true));
      });
    }
  }

  // Function to send a text message
  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        _messages.add(ChatMessage(text: _messageController.text, isSentByMe: true));
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Facebook-like Chat")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[_messages.length - 1 - index];
                return _buildMessageBubble(message);
              },
            ),
          ),
          _buildInputBar(),
        ],
      ),
    );
  }

  // Widget to display chat message bubbles
  Widget _buildMessageBubble(ChatMessage message) {
    if (message.imagePath != null) {
      return Align(
        alignment: message.isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.all(8),
          child: Image.file(
            File(message.imagePath!),
            width: 150,
            height: 150,
            fit: BoxFit.cover,
          ),
        ),
      );
    } else {
      return Align(
        alignment: message.isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: message.isSentByMe ? Colors.blue[300] : Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            message.text!,
            style: TextStyle(color: message.isSentByMe ? Colors.white : Colors.black),
          ),
        ),
      );
    }
  }

  // Widget to display the input bar for sending messages
  Widget _buildInputBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.photo),
            onPressed: _pickImage, // Pick an image from gallery
          ),
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: "Type a message",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _sendMessage, // Send the message
          ),
        ],
      ),
    );
  }
}
class ChatMessage {
  final String? text;
  final String? imagePath;
  final bool isSentByMe;

  ChatMessage({this.text, this.imagePath, required this.isSentByMe});
}
