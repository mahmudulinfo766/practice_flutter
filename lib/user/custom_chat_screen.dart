import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CustomChatScreen extends StatefulWidget {
  const CustomChatScreen({super.key});

  @override
  State<CustomChatScreen> createState() => _CustomChatScreenState();
}

class _CustomChatScreenState extends State<CustomChatScreen> {
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
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Custom Chat"),
      ),
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
    return Align(
      alignment: message.isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.all(10),
        padding: message.imagePath != null ? EdgeInsets.zero : EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: message.isSentByMe ? Colors.deepPurple : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(15),
        ),
        child: message.imagePath != null
            ? ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.file(
            File(message.imagePath!),
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
        )
            : Text(
          message.text!,
          style: TextStyle(
            color: message.isSentByMe ? Colors.white : Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  // Widget to display the input bar for sending messages
  Widget _buildInputBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      color: Colors.grey.shade100,
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.photo, color: Colors.deepPurple),
            onPressed: _pickImage,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
              ),
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  hintText: 'Type a message',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: Colors.deepPurple),
            onPressed: _sendMessage,
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
