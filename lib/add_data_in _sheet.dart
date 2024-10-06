import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddCharacterScreen extends StatefulWidget {
  const AddCharacterScreen({super.key});

  @override
  State<AddCharacterScreen> createState() => _AddCharacterScreenState();
}

class _AddCharacterScreenState extends State<AddCharacterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  ApiService apiService = ApiService();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add SNES Character'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: null,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),

                TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: null,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(labelText: 'Phone'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a phone';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(labelText: 'Address'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Character character = Character(
                        name: _nameController.text,
                        phone: _phoneController.text,
                        address: _addressController.text,
                      );
                      apiService.addCharacter(character);  // Submit the data
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Character added!')));
                    }
                    Navigator.pop(context);
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
class Character {
  final String name;
  final dynamic phone;
  final String address;

  Character({required this.name, required this.phone, required this.address});

  // Convert the Character object into JSON
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Phone': phone,
      'Address': address,
    };
  }
}

class ApiService {
  final String apiUrl = 'https://script.google.com/macros/s/AKfycbyVwuCotsZ0Ki7BUzU9QMxtKtRAaU5WYDqWSn791DRMZOjOaeHyNbTiTgaBRYP0bd24rw/exec';  // Replace with your Google Apps Script URL

  // Method to send data to the API
  Future<void> addCharacter(Character character) async {
    print(character.toJson());
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(character.toJson()),
    );

    log(response.statusCode);

    /*if (response.statusCode == 200) {
      print('Data added successfully');
    } else {
      throw Exception('Failed to add character');
    }*/
  }
}